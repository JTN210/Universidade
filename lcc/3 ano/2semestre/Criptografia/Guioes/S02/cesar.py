import sys

def preproc(str):
      l = []
      for c in str:
          if c.isalpha():
              l.append(c.upper())
      return "".join(l)  

def cesar(operacao, key, mens):
    valorKey = ord(preproc(key)[0]) - ord('A')
    mensagemUpper = preproc(mens)
    resultado = ""

    sinal = 1 if operacao == 'enc' else -1    
    for c in mensagemUpper:
        nova_posicao = (ord(c) - ord('A') + (sinal * valorKey)) % 26
        resultado += chr(nova_posicao + ord('A'))
        
    return resultado

def main():
    if len(sys.argv) != 4:
        print("Erro: Use python3 cesar.py <enc/dec> <chave> <mensagem>")
        return
    print(cesar(sys.argv[1], sys.argv[2], sys.argv[3]))
    
if __name__ == "__main__":
    main()