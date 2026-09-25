import sys
import random
import os

def main():
    if len(sys.argv) < 3:
        print("Uso: python3 my_otp_attack.py <cifraFile> <palavra1> <palavra2> ...")
        return

    cifraFile = sys.argv[1]
    palavras_alvo = [palavra.encode('utf-8') for palavra in sys.argv[2:]]

    if not os.path.isfile(cifraFile):
        print(f"Erro: O ficheiro '{cifraFile}' não foi encontrado.")
        return

    with open(cifraFile, 'rb') as f:
        cifra = f.read()

    # 2^16
    for seed_guess in range(65536):
        random.seed(seed_guess)
        key = random.randbytes(len(cifra))
        
        ptxt_bytes = bytes([c ^ k for c, k in zip(cifra, key)])
        
        encontrou_todas = True
        for palavra in palavras_alvo:
            if palavra not in ptxt_bytes:
                encontrou_todas = False
                break

        if encontrou_todas:
            texto_limpo = ptxt_bytes.decode('utf-8', errors='replace')

            if '' in texto_limpo:
                continue

            print("\n SUCESSO! Mensagem decifrada:")
            print("-" * 30)
            print(texto_limpo)
            print("-" * 30)
            print(f"(Seed encontrada: {seed_guess})")
            return

    print("\nFalha: Não foi possível decifrar a mensagem com as palavras fornecidas.")

if __name__ == "__main__":
    main()