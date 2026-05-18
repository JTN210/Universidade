import sys

def main():
    if len(sys.argv) != 5:
        print("Uso incorreto.")
        print("Sintaxe: python chacha_attack.py <fctxt> <pos> <ptxtAtPos> <newPtxtAtPos>")
        sys.exit(1)

    fctxt = sys.argv[1]
    pos = int(sys.argv[2])
    
    ptxtAtPos = sys.argv[3].encode('utf-8')
    newPtxtAtPos = sys.argv[4].encode('utf-8')

    if len(ptxtAtPos) != len(newPtxtAtPos):
        print("Erro: O tamanho do texto original e do novo texto devem ser iguais.")
        sys.exit(1)

    TAMANHO_NONCE = 16 

    try:
        with open(fctxt, 'rb') as f:
            ciphertext = bytearray(f.read())

        for i in range(len(ptxtAtPos)):
            target_pos = TAMANHO_NONCE + pos + i 
            
            if target_pos < len(ciphertext):
                 # original+key xor original xor novo == key+novo
                ciphertext[target_pos] = ciphertext[target_pos] ^ ptxtAtPos[i] ^ newPtxtAtPos[i]
            else:
                print(f"Aviso: A posição {target_pos} ultrapassa o fim do ficheiro.")
                break

        ficheiro_ataque = fctxt + ".attack"
        with open(ficheiro_ataque, 'wb') as f:
            f.write(ciphertext)
            
        print(f"Sucesso! Criptograma manipulado guardado em: {ficheiro_ataque}")

    except FileNotFoundError:
        print(f"Erro: O ficheiro {fctxt} não foi encontrado.")
        sys.exit(1)
    except Exception as e:
        print(f"Ocorreu um erro: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()