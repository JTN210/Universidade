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

Palavras acrescentaInicio (Palavras l, char *p){
    Palavras new = malloc(sizeof(struct celula));
    new -> palavra = p;
    new -> ocorr = 1;
    new -> prox = l;
    return new;
}

Palavras acrescentaFim( Palavras l, char *p){
    Palavras new = malloc(sizeof(struct celula));
    new -> palavra = p;
    new -> ocorr = 1;
    new -> prox = NULL;
    if (l == NULL )
    {
      return new;
    }
    while (l -> prox != NULL)
    {
        l = l->prox;
    }
    l -> prox = new;
    
    return l;
}

Palavras acrescenta (Palavras l, char *p){
    Palavras retorno = l;
    if (retorno == NULL)
    {
        return acrescentaFim(l,p);
    }
    
    while (l -> prox != NULL)
    {
        if (strcmp(l -> palavra, p) == 0)
        {
            l -> ocorr++;
            return retorno;
        }
        l = l -> prox; 
    }
    if (strcmp(l -> palavra, p) == 0)
        {
            l -> ocorr++;
            return retorno;
        }
    return acrescentaFim(retorno, p);
}