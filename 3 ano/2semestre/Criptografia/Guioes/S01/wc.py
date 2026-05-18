import sys

def main(inp):
   
    if len(inp) < 2:
        print("Uso: python3 wc.py <nome_do_ficheiro>")
        return

    nome_ficheiro = inp[1]

    try:
        
        with open(nome_ficheiro, 'r', encoding='utf-8') as f:
            conteudo = f.read()

        linhas = len(conteudo.splitlines())
        palavras = len(conteudo.split())
        caracteres = len(conteudo)

        print(f"\t{linhas}\t{palavras}\t{caracteres}")

    except FileNotFoundError:
        print(f"Erro: O ficheiro '{nome_ficheiro}' não foi encontrado.")

if __name__ == "__main__":
    main(sys.argv)