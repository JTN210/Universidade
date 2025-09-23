#include <stdio.h>
#include <string.h>
#include <stdlib.h>

typedef struct LInt_nodo {
    int valor;
    struct LInt_nodo *prox;
    } *LInt;

typedef struct ABin_nodo {
    int valor;
    struct ABin_nodo *esq, *dir;
    } *ABin;


LInt removeMaiores(LInt l, int x){
    LInt anterior = NULL;
    LInt atual = l;
    if (atual == NULL)
    {
        return NULL;
    }
    else if (atual-> valor > x )
    {
        return NULL;
    }
    
    
    while (atual != NULL && atual ->valor <= x)
    {
        anterior = atual;
        atual = atual->prox;
    }
    anterior -> prox = NULL;
    atual = anterior;

    return l;
}


LInt caminho(ABin a, int x){
    LInt caminho = malloc(sizeof *caminho);
    caminho -> valor = a -> valor;
    caminho -> prox = NULL;
    LInt anterior = caminho;
    while (a != NULL)
    {
        if (a -> valor > x)
        {
            a = a -> dir;
            if(a != NULL) 
            {
            LInt proximo = malloc(sizeof *proximo);
            proximo -> valor = a -> valor;
            proximo -> prox = NULL;
            caminho -> prox = proximo;
            caminho = caminho -> prox;
            }
        }
        else if (a -> valor < x)
        {
            a = a -> esq;
            if (a != NULL)
            {
            LInt proximo = malloc(sizeof *proximo);
            proximo -> valor = a -> valor;
            proximo -> prox = NULL;
            caminho -> prox = proximo;
            caminho = caminho -> prox;
            }
        }
        else
        {
            LInt proximo = malloc(sizeof *proximo);
            proximo -> valor = a -> valor;
            proximo -> prox = NULL;
            caminho -> prox = proximo;
            return anterior;
        }  

    }
    return NULL;
}


void duplicaTodos(LInt l){
    LInt curr = l;
    while (curr != NULL)
    {

        LInt dup = malloc(sizeof *dup);
        dup -> valor = curr -> valor;
        dup->prox = curr ->prox;
        curr -> prox = dup ;
        curr = dup -> prox;  
    }

}




int expande(char s[]){
    int res = 0; int j = 0; int i = 0; int x; int n = 9999999;
    int *v = malloc(n * sizeof *v);
while (s[i] != '\0')
{
    if (s[i] >= '0' && s[i] <= '9')
    {
        x = s[i] - '0';
        v[j] = x+1;
        j++;
    }
    i++;
}
for (int i = 0; i <= j; i++)
{
    res = res + v[i];
}
return res;
}