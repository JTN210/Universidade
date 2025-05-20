#include <stdio.h>
#include <string.h>
#include <stdlib.h>




void rodaEsq(int a[], int N, int r){
    int i = 0, m = 0;
    int r2 = r;
    int *s = malloc(N * sizeof *s);
    while (r != 0)
    {
        s[N - r] = a[i];
        i++;
        r--;
    }
    for (int j = 0; j < N - r2; j++)
    {
      s[j] = a[i];
      i++;  
    }

    for (int i = 0; i < N; i++)
    {
        a[i] = s[i]; 
    }
    free(s);
}

typedef struct lint_nodo {
    int valor;
    struct lint_nodo *prox;
    } *LInt;

int delete(int n, LInt *l){
    LInt ant = NULL;
    LInt proximo = (*l);
    if ( (*l) == NULL)
    {
        return -1;
    }
    if (n == 0) {
        LInt rem = *l;          
        *l = rem->prox;         
        free(rem);              
        return 0;
    }
    
    
    while (proximo!= NULL && n > 0)
    {
        ant = proximo;
        proximo = proximo -> prox;
        n--;
    }
    if (proximo == NULL)
    {
        return -1;
    }
    
     ant -> prox = proximo -> prox;
    free(proximo);
    return 0;
}


int maxCresc(LInt l){
    int counter = 1;
    int max = 1;
    if (l == NULL)
    {
        return counter;
    }
    while ( l != NULL )
    {
        if (l -> valor < l-> prox -> valor)
        {
            counter++;
        }
        else
        {
            if (counter > max)
            {
                max = counter;
                counter = 1;
            }
        }
        l = l -> prox;
    }
    if (counter > max)
    {
        max = counter;
    }
    return max;
}


typedef struct abin_nodo {
    int valor;
    struct abin_nodo *esq, *dir;
    } *ABin;


ABin folhaEsq(ABin a){

    if (a == NULL)
    {
        return NULL;
    }
    
    while (a ->esq != NULL)
    {
        a = a->esq;
    }
    if (a ->dir == NULL)
    {
        return a;
    }
    else
    {
        return folhaEsq(a ->dir);
    }    
}

int parentesisOk(char exp[]){

    
}  