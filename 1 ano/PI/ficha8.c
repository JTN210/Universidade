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

    typedef LInt Stack;

    typedef struct {
        LInt inicio,fim;
        } Queue;



    void initStack (Stack *s) {
        *s = NULL;
    }
    int SisEmpty (Stack s) {
        return s == NULL;
    }

    int push (Stack *s, int x){

        *s = newLInt( x, *s);

        return (*s)!= NULL;
    }


    int pop(Stack *s, int *x){

        if (*s == NULL)
        {
            return 1;
        }
        
        *x = (*s) -> valor;

        *s = (*s) -> prox;
    }

    int top(Stack s, int *x){
        if (s == NULL)
        {
            return 1;
        }
        
        *x = s -> valor;
    }

    void initQueue (Queue *q){

        q -> inicio = NULL;
        q -> fim = NULL;
    }

 int QisEmpty (Queue q){

    return q.inicio == NULL;
 }


 int enqueue (Queue *q, int x){

    LInt temp = newLInt(x,NULL);

    if (q -> inicio == NULL)
    {
        q -> inicio = temp;
        q -> fim = temp;
    }
    else
    {
        q->fim -> prox = temp;
        q -> fim = temp;
    }
 }

 int dequeue (Queue *q, int *x){
    if (q == NULL)
    {
        return 1;
    }
    *x = q -> inicio -> valor;
    q -> inicio = q -> inicio -> prox;

    return 0;
 }
 int front (Queue q, int *x){

    if (q == NULL)
    {
        return 1;
    }
    else
    {
        *x = q.inicio ->valor;
    }
    return 0;
 }