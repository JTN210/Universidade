import sys
import hmac
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
from cryptography.hazmat.primitives import padding
from cryptography.hazmat.backends import default_backend

class InvalidTag(Exception):
    pass

def compute_cbc_mac(key: bytes, message: bytes) -> bytes:

    # No CBC-MAC clássico, o IV é um bloco de zeros (16 bytes para AES)
    iv = b'\x00' * 16
    
    padder = padding.PKCS7(128).padder()
    padded_message = padder.update(message) + padder.finalize()
    
    cipher = Cipher(algorithms.AES(key), modes.CBC(iv), backend=default_backend())
    encryptor = cipher.encryptor()
    ciphertext = encryptor.update(padded_message) + encryptor.finalize()
    
    mac_tag = ciphertext[-16:]
    return mac_tag

def tag_file(fkey, file_path):
    with open(fkey, 'rb') as f:
        key = f.read()
        
    with open(file_path, 'rb') as f:
        message = f.read()
        
    tag = compute_cbc_mac(key, message)
    
    tag_path = file_path + ".tag"
    with open(tag_path, 'wb') as f:
        f.write(tag)
        
    print(f"Sucesso: Tag de autenticação gerado e guardado em '{tag_path}'")

def verify_tag(fkey, file_path, tag_path):
    with open(fkey, 'rb') as f:
        key = f.read()
    with open(file_path, 'rb') as f:
        message = f.read()
    with open(tag_path, 'rb') as f:
        stored_tag = f.read()
        
    calculated_tag = compute_cbc_mac(key, message)

    if not hmac.compare_digest(calculated_tag, stored_tag):
        raise InvalidTag(f"Erro de Integridade: O tag em '{tag_path}' não é válido para '{file_path}'.")
        
    print("Verificação Bem-Sucedida: O ficheiro está íntegro e autêntico!")

def main():
    args = sys.argv[1:]
    
    if len(args) < 3:
        print("Sintaxe incorreta.")
        print("Uso para gerar:   python cbc_mac.py tag <key> <file>")
        print("Uso para validar: python cbc_mac.py verify <key> <file> <tag>")
        sys.exit(1)
        
    operacao = args[0]
    
    if operacao == "tag":
        if len(args) != 3:
             print("Uso: python cbc_mac.py tag <key> <file>")
             sys.exit(1)
        tag_file(args[1], args[2])
        
    elif operacao == "verify":
        if len(args) != 4:
             print("Uso: python cbc_mac.py verify <key> <file> <tag>")
             sys.exit(1)
        verify_tag(args[1], args[2], args[3])
        
    else:
        print("Operação inválida. Use 'tag' ou 'verify'.")

if __name__ == "__main__":
    main()