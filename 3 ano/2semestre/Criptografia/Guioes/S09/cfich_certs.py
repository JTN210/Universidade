import sys
import os
from cryptography import x509
from cryptography.hazmat.primitives import hashes, serialization
from cryptography.hazmat.primitives.asymmetric import rsa, padding, dh
from cryptography.hazmat.primitives.kdf.hkdf import HKDF
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
from datetime import datetime, timezone

dhPrams = dh.generate_parameters(generator=2, key_size=2048)

def cert_load(fname):
    """Lê certificado de ficheiro"""
    with open(fname, "rb") as fcert:
        return x509.load_pem_x509_certificate(fcert.read())

def verify_cert_robust(cert, ca_cert_path):
    """Valida o certificado"""
    ca_cert = cert_load(ca_cert_path)

    now = datetime.now(timezone.utc)
    if now < cert.not_valid_before_utc or now > cert.not_valid_after_utc:
        raise Exception("Certificado expirado ou fora do prazo de validade.")

    cert.verify_directly_issued_by(ca_cert)

def setup(user):
    """Gera chaves RSA e DH para o utilizador"""
    rsa_priv = rsa.generate_private_key(public_exponent=65537, key_size=2048)
        
    pem_priv = rsa_priv.private_bytes(
        encoding=serialization.Encoding.PEM,
        format=serialization.PrivateFormat.PKCS8,
        encryption_algorithm=serialization.BestAvailableEncryption(b"1234")
    )
    
    # temos de assinar aqui o rsa para o BOB ser o unico a falar com a alice 
    with open(f"{user}.key", "wb") as f:
        f.write(pem_priv)
    
    print(f"Setup concluído.")

def enc(dest_user, me, filename, ca_cert_path):
    """Cifra o ficheiro e assina usando o certificado"""
    with open(f"{me}.key", "rb") as f:
        my_priv_key = serialization.load_pem_private_key(f.read(), password=b"1234")
    
    with open(filename, "rb") as f:
        data = f.read()

    signature = my_priv_key.sign(
        data,
        padding.PSS(mgf=padding.MGF1(hashes.SHA256()), salt_length=padding.PSS.MAX_LENGTH),
        hashes.SHA256()
    )

    with open(f"{me}.crt", "rb") as f:
        my_cert_data = f.read()

    with open(filename + ".enc", "wb") as f:
        f.write(len(my_cert_data).to_bytes(4, 'big'))
        f.write(my_cert_data)
        f.write(signature)
        f.write(data)
    
    print(f"Ficheiro {filename}.enc criado com certificado e assinatura de {me}.")

def dec(filename, ca_cert_path):
    try:
        with open(filename, "rb") as f:
            content = f.read()
            
        ptr = 0
        cert_len = int.from_bytes(content[ptr:ptr+4], 'big'); ptr += 4
        cert_blob = content[ptr:ptr+cert_len]; ptr += cert_len
        signature = content[ptr:ptr+256]; ptr += 256 # RSA 2048 gera 256 bytes
        data = content[ptr:]

        """Validação de certificado"""
        try:
            user_cert = x509.load_pem_x509_certificate(cert_blob)
            verify_cert_robust(user_cert, ca_cert_path)
            print("Certificado validado pela Âncora de Confiança.")
        except Exception as e:
            print(f"ERRO DE REJEIÇÃO (Certificado): {e}")
            return

        """ Validação da assinatura """
        try:
            pub_key = user_cert.public_key()
            pub_key.verify(
                signature,
                data,
                padding.PSS(mgf=padding.MGF1(hashes.SHA256()), salt_length=padding.PSS.MAX_LENGTH),
                hashes.SHA256()
            )
            print("Assinatura Válida.")
        except Exception:
            print("ERRO DE REJEIÇÃO (Assinatura)")
            return

        with open(filename.replace(".enc", ".dec"), "wb") as f:
            f.write(data)

    except Exception as e:
        print(f"Erro ao processar ficheiro: {e}")

if __name__ == "__main__":
    args = sys.argv[1:]
    if not args:
        print("Uso: setup <user> | enc <dest> <me> <fich> <ca_cert> | dec <fich_enc> <ca_cert>")
    elif args[0] == "setup":
        setup(args[1])
    elif args[0] == "enc":
        enc(args[1], args[2], args[3], args[4])
    elif args[0] == "dec":
        dec(args[1], args[2])