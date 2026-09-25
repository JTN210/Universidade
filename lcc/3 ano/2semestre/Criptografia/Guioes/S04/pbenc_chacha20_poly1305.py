import sys
import os
import getpass
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.ciphers.aead import ChaCha20Poly1305
from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC
from cryptography.hazmat.backends import default_backend

def derivar_chave(password: bytes, salt: bytes) -> bytes:
    kdf = PBKDF2HMAC(
        algorithm=hashes.SHA256(),
        length=32,  
        salt=salt,
        iterations=100000,
        backend=default_backend()
    )
    return kdf.derive(password)

def cifrar(fich):
    with open(fich, 'rb') as f:
        plaintext = f.read()

    password = getpass.getpass("Introduza a palavra passe para cifrar: ").encode('utf-8')

    salt = os.urandom(16)
    nonce = os.urandom(12)

    key = derivar_chave(password, salt)
    
    chacha = ChaCha20Poly1305(key)
    
    ciphertext_with_tag = chacha.encrypt(nonce, plaintext, None)

    with open(fich + ".enc", 'wb') as f:
        f.write(salt + nonce + ciphertext_with_tag)
    
    print(f"Sucesso! Ficheiro cifrado com autenticação gravado como: {fich}.enc")

def decifrar(fich):
    with open(fich, 'rb') as f:
        conteudo = f.read()

    salt = conteudo[:16]
    nonce = conteudo[16:28]
    ciphertext_with_tag = conteudo[28:]

    password = getpass.getpass("Introduza a palavra passe para decifrar: ").encode('utf-8')

    try:
        key = derivar_chave(password, salt)
        
        chacha = ChaCha20Poly1305(key)
            
        plaintext = chacha.decrypt(nonce, ciphertext_with_tag, None)

        fich_dec = fich.replace(".enc","") + (".dec")
            
        with open(fich_dec, 'wb') as f:
            f.write(plaintext)
            
        print(f"Sucesso! Ficheiro decifrado e Autenticado gravado como: {fich_dec}")
        
    except Exception as e:
        print(f"Erro ao decifrar. A palavra passe pode estar errada ou o ficheiro corrompido. Detalhe: {e}")

def main():
    if len(sys.argv) != 3:
        print("Sintaxe incorreta.")
        print("Uso: python pbenc_chacha20_poly1305.py <enc|dec> <ficheiro>")
        sys.exit(1)

    operacao = sys.argv[1]
    fich = sys.argv[2]

    if operacao == 'enc':
        cifrar(fich)
    elif operacao == 'dec':
        decifrar(fich)
    else:
        print("Operação inválida. Use 'enc' para cifrar ou 'dec' para decifrar.")

if __name__ == "__main__":
    main()