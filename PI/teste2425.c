#include <stdio.h>
#include <string.h>
#include <stdlib.h>



typedef struct no {
    int valor;
    struct no *prox;
    } *LInt;

LInt arrayToList(int v[],int N){
    LInt novo = malloc(sizeof *novo);
    novo ->valor = v[N-1];
    novo->prox = NULL;

    for (int i = N-2; i >= 0; i--)
    {
        LInt novo2 = malloc(sizeof *novo2);
        novo2 -> valor = v[i];
        novo2 -> prox = novo;
        novo = novo2;
    }
    return novo;
}