import os
import sys
import hmac
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
from cryptography.hazmat.primitives import padding
from cryptography.hazmat.backends import default_backend

#seja IV = 14 e Mensagem = 26 isto é  = 40 então nos usamos tipo um IV = 12 
#e assim podemos mudar a mensagem = 28 e ninguem nota porque no MAC vai ser = 40 na mesma
#se o IV for sempre 0 ja não dá para fazer esta trafulhice 

class InvalidTag(Exception):
    pass

def compute_cbc_mac_rnd(key: bytes, message: bytes, iv=None) -> bytes:
    if iv is None:
        iv = os.urandom(16)
    
    padder = padding.PKCS7(128).padder()
    padded_message = padder.update(message) + padder.finalize()
    
    cipher = Cipher(algorithms.AES(key), modes.CBC(iv), backend=default_backend())
    encryptor = cipher.encryptor()
    ciphertext = encryptor.update(padded_message) + encryptor.finalize()
    
    return iv + ciphertext[-16:]

def tag_file(fkey, file_path):
    with open(fkey, 'rb') as f: key = f.read()
    with open(file_path, 'rb') as f: message = f.read()
    
    tag = compute_cbc_mac_rnd(key, message)
    
    with open(file_path + ".tag", 'wb') as f:
        f.write(tag)
    print(f"Tag (IV + MAC) guardada com sucesso.")

def verify_tag(fkey, file_path, tag_path):
    with open(fkey, 'rb') as f: key = f.read()
    with open(file_path, 'rb') as f: message = f.read()
    with open(tag_path, 'rb') as f: full_tag = f.read()
    
    if len(full_tag) != 32:
        raise InvalidTag("Tag com tamanho inválido.")

    extracted_iv = full_tag[:16]
    stored_mac = full_tag[16:]
    
    calculated_tag = compute_cbc_mac_rnd(key, message, iv=extracted_iv)
    
    if not hmac.compare_digest(calculated_tag[16:], stored_mac):
        raise InvalidTag("Erro de Integridade: Tag inválida.")
    print("Verificação Bem-Sucedida!")
    
def main():
    args = sys.argv[1:]
    
    if len(args) < 3:
        print("Uso para gerar:   python cbc_mac_rnd.py tag <key> <file>")
        print("Uso para validar: python cbc_mac_rnd.py verify <key> <file> <tag>")
        sys.exit(1)
        
    operacao = args[0]
    
    try:
        if operacao == "tag":
            tag_file(args[1], args[2])
        elif operacao == "verify":
            if len(args) < 4:
                print("Uso: python cbc_mac_rnd.py verify <key> <file> <tag>")
                sys.exit(1)
            verify_tag(args[1], args[2], args[3])
        else:
            print("Operação inválida.")
    except InvalidTag as e:
        print(f"ALERTA: {e}")
        sys.exit(1)
    except Exception as e:
        print(f"Erro inesperado: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
