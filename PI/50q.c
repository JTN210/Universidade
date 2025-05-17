#include <stdio.h>
#include <stdlib.h>

int q1(){
        int p;
        scanf("%d", &p);
        int max = p;
        while(p != 0) {
            scanf("%d", &p);
            if (p > max)
                max = p;
        }
        printf("%d\n", max);
        return max;    
}


int q2(){
   int numElementos = 1, x, soma;
        scanf("%d", &soma);
        x = soma; 
        while(x != 0)
        {
            scanf("%d", &x);
            if (x != 0) 
            {
                 soma += x;
                 numElementos++;
            }
        }
            int media = soma/numElementos;
            printf("%d\n", media);
            return media;
        }


int q3(){
    int l, max = 0, sec = 0;
    scanf("%d", &l);
    max = l;
    while (l != 0)
    {   
        scanf("%d",&l);
        if ( l > max)
        {
            sec = max;
            max = l;
        }
        else if (l < max && l > sec)
        {
            sec = l;
        }
    }  
   printf("%d\n", sec);
    return sec;
}
    
int q4(unsigned int n){

    return 0;
}
typedef struct lligada {
    int valor;
    struct lligada *prox;
    } *LInt;

int length (LInt lista){
    int res = 0;
    while (lista != NULL )
    {
       res++;
        lista = lista ->prox;
    }
    return res;
    }

void freeL (LInt lista){
    LInt list;

    while (lista != NULL)
    {
        list = lista -> prox;
        free(lista);
        lista = list;
    }
}

void imprimeL (LInt lista){

    while (lista != NULL)
    {
        printf("%d\n", lista->valor);
        lista ->prox;


    }
}

int reverseL(LInt l) {
    LInt prev = NULL;      // ponteiro para a parte “já invertida”
    LInt curr = l;         // ponteiro para o nó atual que vamos processar
    LInt next1 = NULL;             // ponteiro auxiliar para guardar o próximo nó

    while (curr != NULL) 
    {
        next1 = curr->prox; // salva o restante da lista
        curr->prox = prev; // inverte a ligação deste nó
        prev = curr;       // avança o início da lista invertida
        curr = next1;       // avança no restante original
    }
    return prev;          // prev é a cabeça da lista agora invertida
}

void insertOrd (LInt *lista, int x){
 LInt nova = malloc(sizeof(LInt));
  nova ->prox = NULL;
  nova -> valor = x;
    while (lista !=NULL && (*lista) -> valor < x)
    {
        lista = &((*lista)->prox);
    }
   nova->prox = *lista;
   lista=&nova; 
}

int removeOneOrd (LInt *lista, int x){
    
}


void merge (LInt *r, LInt a, LInt b){

    while (a != NULL || b != NULL) 
    {
        if ((a != NULL && b != NULL && a->valor < b->valor) || b == NULL) 
        {
        *r = a;
        a = a->prox;
        } 
        else
        {
        *r = b;
        b = b->prox;
        }
        r = &( (*r)->prox);
    }
    *r = NULL;
}

LInt parteAmeio (LInt *l){
    LInt lista = *l;
    LInt head = *l;
    LInt Pp = NULL;
    LInt Sp = NULL;
    int count = 0;
    while (lista !=NULL)
    {
        lista = lista->prox;
        count++;   
    }
    lista = *l;
    int meio = count / 2;
    while (meio > 0)
    {
        Pp = lista;
        lista = lista->prox;
        meio--;
    }
    Pp ->prox = NULL;

    Sp = lista;
    *l = Sp;

return head;
}

int main(){
   // q1(99999999);
   // q2(99999999);
      q3(99999999);
    return 0;
}