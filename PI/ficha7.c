#include <stdio.h>
#include <string.h>
#include <stdlib.h>

typedef struct celula {
    char *palavra;
    int ocorr;
    struct celula * prox;
    } * Palavras;

void libertaLista (Palavras l){

    free(l);
}

int quantasP (Palavras l){
    int res = 0;
   while (l != NULL)
   {
    res++;
    l = l ->prox;
   }
   return res;
}

void listaPal (Palavras l){
    while (l != NULL)
    {
        printf("%s: %d",l->palavra, l->ocorr);
        l = l-> prox;
    }
}

char * ultima (Palavras l){
    while (l -> prox != NULL)
    {
        l = l -> prox;  
    }
    return l -> palavra;
}

int acrescentaInicio (Palavras l, char *p){
    

    return 0;
}