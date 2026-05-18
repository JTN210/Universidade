import sys
import os
from cryptography.hazmat.primitives import serialization, hashes
from cryptography.hazmat.primitives.asymmetric import dh
from cryptography.hazmat.primitives.kdf.hkdf import HKDF
from cryptography.hazmat.primitives.ciphers.aead import AESGCM


P_hex = "FFFFFFFFFFFFFFFFC90FDAA22168C234C4C6628B80DC1CD129024E088A67CC74020BBEA63B139B22514A08798E3404DDEF9519B3CD3A431B302B0A6DF25F14374FE1356D6D51C245E485B576625E7EC6F44C42E9A637ED6B0BFF5CB6F406B7EDEE386BFB5A899FA5AE9F24117C4B1FE649286651ECE45B3DC2007CB8A163BF0598DA48361C55D39A69163FA8FD24CF5F83655D23DCA3AD961C62F356208552BB9ED529077096966D670C354E4ABC9804F1746C08CA18217C32905E462E36CE3BE39E772C180E86039B2783A2EC07A28FB5C55DF06F4C52C9DE2BCBF6955817183995497CEA956AE515D2261898FA051015728E5A8AACAA68FFFFFFFFFFFFFFFF"
P = int(P_hex,16)
g = 2

def get_params():
    return dh.DHParameterNumbers(P, g).parameters()

def mkpair(x, y):
   """ produz uma byte-string contendo o tuplo '(x,y)' ('x' e 'y' são byte-strings) """
   len_x = len(x)
   len_x_bytes = len_x.to_bytes(2, 'little')
   return len_x_bytes + x + y

def unpair(xy):
   """ extrai componentes de um par codificado com 'mkpair' """
   len_x = int.from_bytes(xy[:2], 'little')
   x = xy[2:len_x+2]
   y = xy[len_x+2:]
   return x, y  

def derive_key(shared_key_bytes):
    return HKDF(
    algorithm=hashes.SHA256(),
    length=32,
    salt=None,
    info=b'session key',
).derive(shared_key_bytes)
    
def setup(user):
    params = get_params()
    sk = params.generate_private_key()
    pk = sk.public_key()
    
    # isto deixa nos passar para ficheiro, contem os dados para gravar-mos
    sk_bytes = sk.private_bytes(
        encoding=serialization.Encoding.PEM,
        format=serialization.PrivateFormat.PKCS8,
        encryption_algorithm=serialization.NoEncryption()
    )
    pk_bytes = pk.public_bytes(
        encoding=serialization.Encoding.PEM,
        format=serialization.PublicFormat.SubjectPublicKeyInfo
    )
    
    with open(f"{user}.sk", "wb") as f: f.write(sk_bytes)
    with open(f"{user}.pk", "wb") as f: f.write(pk_bytes)
    print(f"Chaves para '{user}' criadas.")



def enc(user,fich):
    
    with open(f"{user}.pk", "rb") as f:
        pk_bob = serialization.load_pem_public_key(f.read())
    
    params = get_params()
    sk_alice = params.generate_private_key()
    pk_alice = sk_alice.public_key()
    
    shared_key = sk_alice.exchange(pk_bob)
    k = derive_key(shared_key)
    
    with open(fich, "rb") as f:
        data = f.read()
    
    aesgcm = AESGCM(k)
    nonce = os.urandom(12)
    ct = aesgcm.encrypt(nonce, data, None)
    
    pk_alice_bytes = pk_alice.public_bytes(
        encoding=serialization.Encoding.DER,
        format=serialization.PublicFormat.SubjectPublicKeyInfo
    )
    # Guardamos o nonce junto ao criptograma para a decifração
    payload = mkpair(pk_alice_bytes, nonce + ct)
    
    with open(fich + ".enc", "wb") as f:
        f.write(payload)
    print(f"Ficheiro '{fich}.enc' gerado para {user}.")
    

def dec(user,fich):
    with open(f"{user}.sk", "rb") as f:
        sk_bob = serialization.load_pem_private_key(f.read(), password=None)
    
    # separar pkAlice do resto
    with open(fich, "rb") as f:
        pk_alice_bytes, data_rest = unpair(f.read())
    
    pk_alice = serialization.load_der_public_key(pk_alice_bytes)
    
    # Derivar a chave de sessão K
    shared_key = sk_bob.exchange(pk_alice)
    k = derive_key(shared_key)
    
    nonce = data_rest[:12]
    ct = data_rest[12:]
    aesgcm = AESGCM(k)
    
    try:
        pt = aesgcm.decrypt(nonce, ct, None)
        with open(fich.replace(".enc", ".dec"), "wb") as f:
            f.write(pt)
        print("Decifração concluída com sucesso!")
    except Exception as e:
        print("Erro na decifração: Verifique a chave ou a integridade do ficheiro.")    




if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Uso: python cfich_nike.py <setup|enc|dec> <user> [fich]")
        sys.exit(1)
        
    op = sys.argv[1]
    name = sys.argv[2]
    
    if op == "setup":
        setup(name)
    elif op == "enc" and len(sys.argv) == 4:
        enc(name, sys.argv[3])
    elif op == "dec" and len(sys.argv) == 4:
        dec(name, sys.argv[3])
    else:
        print("Argumentos inválidos.")