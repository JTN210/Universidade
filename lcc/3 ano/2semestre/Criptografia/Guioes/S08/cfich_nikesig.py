import sys
import os
from cryptography.hazmat.primitives import hashes, serialization
from cryptography.hazmat.primitives.asymmetric import rsa, padding, dh
from cryptography.hazmat.primitives.kdf.hkdf import HKDF
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes

dhPrams = dh.generate_parameters(generator=2, key_size=2048)

def save_key(filename, key, is_public=False):
    
    if is_public:
        pem = key.public_bytes(encoding=serialization.Encoding.PEM, format=serialization.PublicFormat.SubjectPublicKeyInfo)
    else:
        pem = key.private_bytes(encoding=serialization.Encoding.PEM,format=serialization.PrivateFormat.PKCS8,encryption_algorithm=serialization.NoEncryption())
    with open(filename, 'wb') as f:
        f.write(pem)

def load_private_key(filename, key_type='rsa'):
    with open(filename, 'rb') as f:
        return serialization.load_pem_private_key(f.read(), password=None)

def load_public_key(filename, key_type='rsa'):
    with open(filename, 'rb') as f:
        return serialization.load_pem_public_key(f.read())

def setup(user):
    rsa_priv = rsa.generate_private_key(public_exponent=65537, key_size=2048)
    rsa_pub = rsa_priv.public_key()
    
    rsaPriv = rsa_priv.private_bytes(encoding=serialization.Encoding.PEM, format=serialization.PrivateFormat.PKCS8, encryption_algorithm=serialization.NoEncryption())
    rsa_pub_pem = rsa_pub.public_bytes(encoding=serialization.Encoding.PEM, format=serialization.PublicFormat.SubjectPublicKeyInfo)
    
    save_key(f"{user}.rsask", rsaPriv)
    save_key(f"{user}.rsapk", rsa_pub_pem)
    
    dhPriv = dhPrams.generate_private_key()
    dhPub = dhPriv.public_key()
    dhPub_bytes = dhPub.public_bytes(encoding=serialization.Encoding.PEM, format=serialization.PublicFormat.SubjectPublicKeyInfo)    
    signature = rsa_priv.sign(dhPub_bytes,padding.PSS(mgf=padding.MGF1(hashes.SHA256()), salt_length=padding.PSS.MAX_LENGTH),hashes.SHA256())

def load_signed_dh_pub(filename, senderRSApub):
    with open(filename, 'rb') as f:
        content = f.read()
    
    dhPub_bytes = content[:-256]
    signature = content[-256:]
    senderRSApub.verify(signature,dhPub_bytes,padding.PSS(mgf=padding.MGF1(hashes.SHA256()), salt_length=padding.PSS.MAX_LENGTH),hashes.SHA256())
    return serialization.load_pem_public_key(dhPub_bytes)
        
def enc(dest_user, me, filename):
    destRSApub = serialization.load_pem_public_key(open(f"{dest_user}.rsapk", "rb").read())
    destDHpub = load_signed_dh_pub(f"{dest_user}.dhpk", destRSApub)
    
    myDHpriv = load_private_key(f"{me}.dhsk")
    myRSApriv = load_private_key(f"{me}.rsask")
    
    with open(filename, 'rb') as f:
        data = f.read()

    shared_key = myDHpriv.exchange(destDHpub)
    derived_key = HKDF(algorithm=hashes.SHA256(), length=32, salt=None, info=b'nike-sig').derive(shared_key)

    signature = myRSApriv.sign(data, padding.PSS(mgf=padding.MGF1(hashes.SHA256()), salt_length=padding.PSS.MAX_LENGTH), hashes.SHA256())

    iv = os.urandom(12)
    cipher = Cipher(algorithms.AES(derived_key), modes.GCM(iv))
    encryptor = cipher.encryptor()
    ciphertext = encryptor.update(data + signature) + encryptor.finalize()

    with open(filename + ".enc", 'wb') as f:
        f.write(iv + encryptor.tag + ciphertext)
    
    print(f"Ficheiro {filename}.enc criado e assinado.")

def dec(me, sender_user, filename):
    myDHpriv = load_private_key(f"{me}.dhsk")
    senderRSApub = serialization.load_pem_public_key(open(f"{sender_user}.rsapk", "rb").read())
    
    senderDHpub = load_signed_dh_pub(f"{sender_user}.dhpk", senderRSApub)

    shared_key = myDHpriv.exchange(senderDHpub)
    derived_key = HKDF(algorithm=hashes.SHA256(), length=32, salt=None, info=b'nike-sig').derive(shared_key)

    with open(filename, 'rb') as f:
        file_content = f.read()
    
    iv, tag, ciphertext = file_content[:12], file_content[12:28], file_content[28:]

    cipher = Cipher(algorithms.AES(derived_key), modes.GCM(iv, tag))
    decryptor = cipher.decryptor()
    decrypted_payload = decryptor.update(ciphertext) + decryptor.finalize()
    data, signature = decrypted_payload[:-256], decrypted_payload[-256:]

    senderRSApub.verify(signature, data, padding.PSS(mgf=padding.MGF1(hashes.SHA256()), salt_length=padding.PSS.MAX_LENGTH), hashes.SHA256())
    out_file = filename.replace(".enc", ".dec")
    with open(out_file, 'wb') as f:
        f.write(data)
    
    print(f"Sucesso! Ficheiro decifrado em {out_file}")

if __name__ == "__main__":
    args = sys.argv[1:]
    if not args:
        print("Uso: setup <user> | enc <dest> <me> <fich> | dec <me> <sender> <fich>")
    elif args[0] == "setup":
        setup(args[1])
    elif args[0] == "enc":
        enc(args[1], args[2], args[3])
    elif args[0] == "dec":
        dec(args[1], args[2], args[3])