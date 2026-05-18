import vigenere
import sys
import cesar


def pontuar(texto):
    # Baseado na dica do professor: A, E, O, S são as mais frequentes
    return sum(1 for c in texto if c in "AEOS")

def vigenere_attack(cifra, tamanho_chave, palavras):
    alfabeto = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    chave_final = ""
    palavras = list(palavras)
    tamanho_chave = int(tamanho_chave)
    for i in range(tamanho_chave):
        fatia = cifra[i::tamanho_chave]
        melhor_letra = 'A'
        maior_pontuacao = -1

        for letra_teste in alfabeto:
            decriptado = cesar.cesar('dec', letra_teste, fatia)
            
            pontos = pontuar(decriptado)
            
            if pontos > maior_pontuacao:
                maior_pontuacao = pontos
                melhor_letra = letra_teste
        
        chave_final += melhor_letra

    texto_limpo = vigenere.vigenere('dec', chave_final, cifra)
    
    print(chave_final)
    print(texto_limpo)    

def main():
    if len(sys.argv) > 4:
        print(vigenere_attack(sys.argv[2], sys.argv[1], sys.argv[3:]))
    else:
        print("Erro: Use python3 viginere_Attack.py <int> <cifra> <palavras>")
        

if __name__ == "__main__":
    main()