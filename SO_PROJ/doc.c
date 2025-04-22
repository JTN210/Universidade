#include "doc.h"

int main(int argc, char* argv[]){

    if ( argc < 2 )
    {
        printf("Erro: argumentos insuficientes\n");
        printf("Uso:\n");
        printf("Adicionar documento: ./doc -a [titulo] [autores] [ano] [path]\n");
        printf("Consultar Documento: ./doc -c  [registo]\n");
        printf("Remover Documento: ./doc -d [registo]\n");
        printf("Contar linhas: ./doc -l [registo] [nome]\n");
        printf("Listar IDs: ./doc -s [nome]\n");
        return 1;
    }

    if ( strcmp(argv[1],"-a") == 0 )
    {
        return insereDoc(argv[2], argv[3], atoi(argv[4]), argv[5]); //atoi passa de string para inteiro, quando escreves no terminal para executar um ficheiro, aquilo é uma string, como o inserePessoa recebe um inteiro tens de passar para inteiro
    }

    /*
    if ( strcmp(argv[1],"-c") == 0 )
    {
       return consultaDoc(atoi(argv[2]));
    }

    if ( strcmp(argv[1],"-d") == 0 )
    {
        return removeDoc (atoi(argv[2]));
    }

    if ( strcmp(argv[1],"-l") == 0 )
    {
       // return numeroLinhas(atoi(argv[2]),(argv[3]));
    }
    if ( strcmp(argv[1],"-s") == 0 )
    {
        //return listaIdDocs(argv[2]);
    }
    */
    return 0;
}