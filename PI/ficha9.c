#include <stdio.h>
#include <string.h>
#include <stdlib.h>


typedef struct nodo {
    int valor;
    struct nodo *esq, *dir;
} * ABin;
    ABin newABin (int r, ABin e, ABin d) {
    ABin a = malloc (sizeof(struct nodo));
    if (a!=NULL) {
    a->valor = r; a->esq = e; a->dir = d;
    }
    return a;
}

int altura (ABin a){
    int res;
   if (a == NULL)
   {
    res = 0;
   }
   else
   {
    res = 1 + max(altura(a->esq),altura(a->dir));
   }
   return res;
}


int nFolhas (ABin a){
    int res;
    if (a == NULL)
    {
        res = 0;
    }
    if (a->esq == NULL && a->dir == NULL)
    {
        res = 1;
    }
    else
    {
        res = nFolhas(a->esq) + nFolhas(a->dir);        
    }
    return res;
}

ABin maisEsquerda (ABin a) {
    ABin res;
    if (a == NULL)
    {
        return NULL;
    }  
    while (a->esq != NULL)
    {
        a = a->esq;
        res = a;
     }
    return res;
}

void imprimeNivel (ABin a, int l){
    ABin esqaux, diraux;
    if (a == NULL)
    {
        printf("ERRO\n");
    }
    
    else if(l == 0)
    {
        printf("%d\n", a->valor);
    }
    else
    {
       esqaux = a->esq;
       diraux = a->dir;
       imprimeNivel(esqaux, l-1);
       imprimeNivel(diraux, l-1);
    }
}

int procuraE (ABin a, int x){
    int res = 0;
    ABin esqaux, diraux;
    while (a != NULL )
    {
        if ( a->valor == x)
        {
            res = 1;
        }
        else
        {
            esqaux = procuraE(a->esq,x);
            diraux = procuraE(a->dir,x);
        }
    }  
    return res;
}

struct nodo *procura (ABin a, int x){
    ABin esqaux, diraux;
    int res;
    if ( a == NULL)
    {
        return NULL;
    }
    if (a->valor == x)
    {
        return a;
    }
    else if(a-> valor < x)
    {
        return diraux = procuraE(a->dir,x);       
    }
    else
    {
       return esqaux = procuraE(a->esq,x);
    }
}       
// mal feita
int nivel (ABin a, int x){
    int n = 0;
    while (a != NULL && a->valor != x) {
        a = (a->valor > x) ? a->esq : a->dir;
        n++;
    }
    
    return (a == NULL) ? -1 : n;
}

void imprimeAte (ABin a, int x){

}

int main(void) {
    /* monta esta árvore:
           15
         /    \
       10      20
      /  \    /  \
     5   12  17  25
    */
    ABin a = newABin(15,
                newABin(10,
                    newABin(5, NULL, NULL),
                    newABin(12, NULL, NULL)
                ),
                newABin(20,
                    newABin(17, NULL, NULL),
                    newABin(25, NULL, NULL)
                )
             );

    printf("Altura: %d\n", altura(a));
    printf("Numero de folhas: %d\n", nFolhas(a));

    ABin me = maisEsquerda(a);
    if (me) printf("Mais à esquerda: %d\n", me->valor);

    printf("Nodos ao nivel 2: ");
    imprimeNivel(a, 2);
    printf("\n");

    printf("procuraE(17): %s\n", procuraE(a,17) ? "encontrado" : "não encontrado");
    printf("procuraE(30): %s\n", procuraE(a,30) ? "encontrado" : "não encontrado");

    struct nodo *p;
    p = procura(a, 12);
    printf("procura(12): %s\n", p ? "encontrado" : "não encontrado");
    p = procura(a,  8);
    printf("procura(8): %s\n", p ? "encontrado" : "não encontrado");

    printf("nivel(25): %d\n", nivel(a,25));
    printf("nivel( 5): %d\n", nivel(a, 5));
    printf("nivel(99): %d\n", nivel(a,99));  /* -1 = não existe */

    return 0;
}