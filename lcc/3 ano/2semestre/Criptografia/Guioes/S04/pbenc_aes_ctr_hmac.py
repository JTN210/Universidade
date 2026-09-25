import sys
import os
import getpass
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
from cryptography.hazmat.primitives import hashes, hmac
from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC
from cryptography.hazmat.backends import default_backend

def derivar_chaves(password: bytes, salt: bytes) -> tuple:
    """
    Deriva 64 bytes a partir da password e divide em duas chaves de 32 bytes.
    Retorna (chave_encriptacao, chave_mac)
    """
    kdf = PBKDF2HMAC(
        algorithm=hashes.SHA256(),
        length=64,
        salt=salt,
        iterations=100000,
        backend=default_backend()
    )
    material_chave = kdf.derive(password)
    
    key_enc = material_chave[:32]
    key_mac = material_chave[32:]
    return key_enc, key_mac

def cifrar(fich):
    with open(fich, 'rb') as f:
        plaintext = f.read()

    password = getpass.getpass("Introduza a pass-phrase para cifrar: ").encode('utf-8')

    salt = os.urandom(16)
    iv = os.urandom(16)

    key_enc, key_mac = derivar_chaves(password, salt)

    cipher = Cipher(algorithms.AES(key_enc), modes.CTR(iv), backend=default_backend())
    encryptor = cipher.encryptor()
    ciphertext = encryptor.update(plaintext) + encryptor.finalize()

    # MAC: Calcular o HMAC (Selo de Integridade)
    # Incluí o salt e o iv no cálculo do MAC para os proteger também
    h = hmac.HMAC(key_mac, hashes.SHA256(), backend=default_backend())
    h.update(salt + iv + ciphertext)
    mac_tag = h.finalize()

    with open(fich + ".enc", 'wb') as f:
        f.write(salt + iv + mac_tag + ciphertext)
    
    print(f"Sucesso! Ficheiro cifrado e autenticado gravado como: {fich}.enc")

def decifrar(fich):
    with open(fich, 'rb') as f:
        conteudo = f.read()

    salt = conteudo[:16]
    iv = conteudo[16:32]
    mac_gravado = conteudo[32:64]
    ciphertext = conteudo[64:]

    password = getpass.getpass("Introduza a pass-phrase para decifrar: ").encode('utf-8')

    key_enc, key_mac = derivar_chaves(password, salt)

    h = hmac.HMAC(key_mac, hashes.SHA256(), backend=default_backend())
    h.update(salt + iv + ciphertext)
    
    try:
        h.verify(mac_gravado)
        print("Integridade verificada com sucesso!")
    except Exception:
        print("ERRO CRÍTICO: Integridade falhou! A password está errada ou o ficheiro foi adulterado.")
        return

    cipher = Cipher(algorithms.AES(key_enc), modes.CTR(iv), backend=default_backend())
    decryptor = cipher.decryptor()
    plaintext = decryptor.update(ciphertext) + decryptor.finalize()

    fich_dec = fich + ".dec"
    if fich.endswith(".enc"):
        fich_dec = fich[:-4] + ".dec"
        
    with open(fich_dec, 'wb') as f:
        f.write(plaintext)
        
    print(f"Sucesso! Ficheiro decifrado gravado como: {fich_dec}")

def main():
    if len(sys.argv) != 3:
        print("Sintaxe incorreta.")
        print("Uso: python pbenc_aes_ctr_hmac.py <enc|dec> <ficheiro>")
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