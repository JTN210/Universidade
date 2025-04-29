#include <stdio.h>
#include <string.h>
#include <stdlib.h>

typedef struct slist {
    int valor;
    struct slist * prox;
    } * LInt;
    LInt newLInt (int x, LInt xs) {
    LInt r = malloc (sizeof(struct slist));
    if (r!=NULL) {
    r->valor = x; r->prox = xs;
    }
    return r;
    }
    //// to do