import sys

def preproc(str):
      l = []
      for c in str:
          if c.isalpha():
              l.append(c.upper())
      return "".join(l)  

def vigenere(operacao, key, mens):
    valorKey = ord(preproc(key)[0]) - ord('A')
    n = len(key)
    mensagemUpper = preproc(mens)
    resultado = ""

    sinal = 1 if operacao == 'enc' else -1
    i = 0
    for c in mensagemUpper:
        nova_posicao = (ord(c) - ord('A') + (sinal * (ord(preproc(key)[i]) - ord('A')))) % 26
        resultado += chr(nova_posicao + ord('A'))
        i = (i + 1) % n
        
    return resultado

def main():
    if len(sys.argv) == 4:
        print(vigenere(sys.argv[1], sys.argv[2], sys.argv[3]))
    else:
        print("Erro: Use python3 cesar.py <enc/dec> <chave> <mensagem>")
        

if __name__ == "__main__":
    main()