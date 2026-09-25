import sys
import os
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms

def setup(fkey):
    key = os.urandom(32)
    with open(fkey, 'wb') as f:
        f.write(key)
    print(f"Chave gerada com sucesso em: {fkey}")

def encrypt(fich, fkey):
    with open(fkey, 'rb') as f:
        key = f.read()
    
    with open(fich, 'rb') as f:
        plaintext = f.read()

    nonce = os.urandom(16)

    algorithm = algorithms.ChaCha20(key, nonce)
    cipher = Cipher(algorithm, mode=None)
    encryptor = cipher.encryptor()
    
    ciphertext = encryptor.update(plaintext)

    with open(fich + ".enc", 'wb') as f:
        f.write(nonce + ciphertext)
    print(f"Ficheiro cifrado: {fich}.enc")

def decrypt(fich, fkey):
    with open(fkey, 'rb') as f:
        key = f.read()
    
    with open(fich, 'rb') as f:
        data = f.read()
    
    nonce = data[:16]
    ciphertext = data[16:]
    
    algorithm = algorithms.ChaCha20(key, nonce)
    cipher = Cipher(algorithm, mode=None)
    decryptor = cipher.decryptor()
    
    plaintext = decryptor.update(ciphertext)

    with open(fich + ".dec", 'wb') as f:
        f.write(plaintext)
    print(f"Ficheiro decifrado: {fich}.dec")

if __name__ == "__main__":
    args = sys.argv[1:]
    
    if not args:
        print("Uso: python cfich_chacha20.py [setup|enc|dec] <ficheiro> <chave>")
    elif args[0] == "setup":
        setup(args[1])
    elif args[0] == "enc":
        encrypt(args[1], args[2])
    elif args[0] == "dec":
        decrypt(args[1], args[2])