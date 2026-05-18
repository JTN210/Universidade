# setup <num de Bytes aleatorios a gerar para a key> <ficheiro para escrever a key>
# enc <ficheiro com a mensagem>(*) <ficheiro com a key> -> cifra no file (*).enc
# dec <ficheiro a decifrar>(*) <ficheiro com a key> -> mens no file (*).dec

import os
import sys

def setup(nBytes, ficheiro):
    key = os.urandom(int(nBytes))
    with open(ficheiro, 'wb') as f:
        f.write(key)

def enc(mensFile, keyFile):
    with open(mensFile, 'rb') as f1:
        mens = f1.read()
    with open(keyFile, 'rb') as f2:
        key = f2.read()

    cifra = bytes([bMens ^ bKey for bMens, bKey in zip(mens, key)])

    cifraFile = mensFile + '.enc' 
    
    with open(cifraFile, 'wb') as encriptado:
        encriptado.write(cifra)
        print(f"Sucesso: Ficheiro guardado como {cifraFile}")

def dec(cifraFile, keyFile):
    with open(cifraFile, 'rb') as f1:
        cifra = f1.read()
    with open(keyFile, 'rb') as f2:
        key = f2.read()

    mens = bytes([bCifra ^ bKey for bCifra, bKey in zip(cifra, key)])

    mensFile = cifraFile + '.dec'
    
    with open(mensFile, 'wb') as mensagem:
        mensagem.write(mens)
        print(f"Sucesso: Ficheiro guardado como {mensFile}")

def main():
    if len(sys.argv) == 4:
        if sys.argv[1] == 'setup':
            setup(sys.argv[2], sys.argv[3])
        elif sys.argv[1] == 'enc':
            enc(sys.argv[2], sys.argv[3])
        elif sys.argv[1] == 'dec':
            dec(sys.argv[2], sys.argv[3])
        else:
            print("Erro: Use \"enc\" ou \"dec\" ou \"setup\"")
    else:
        print("Erro: formato invalido")

if __name__ == "__main__":
    main()