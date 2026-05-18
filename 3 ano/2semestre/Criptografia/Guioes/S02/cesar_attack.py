import sys
import cesar

def attack(cifra, word1, word2):
    l = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    for i in l:
        texto_limpo = cesar.cesar('dec',i,cifra)
        if word1 in texto_limpo or word2 in texto_limpo:
            print(i)
            print(texto_limpo)
            return

def main():
    if len(sys.argv) != 4:
        print("Usage: python3 cesar_attack.py <cifra> <word1> <word2>")
        return
    attack(sys.argv[1], sys.argv[2], sys.argv[3])

if __name__ == "__main__":
    main()
