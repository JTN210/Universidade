#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#define MAX 10
struct staticStack
{
    int sp;
    int values [MAX];
};
typedef struct staticStack STACK, *SStack;


void SinitStack(SStack s){

    s -> sp = 0;    
}

int SisEmpty(SStack s){

    return s -> sp == 0;
}

int Spush (SStack s, int x){
    int res = 0;
    if (s -> sp == MAX)
    {
        res = 1;
    }
    else
    {
        s -> values[(s -> sp)] = x;
        s -> sp++;
    }
    return res;
}

int Spop(SStack s, int *x){
    int res = 0;

    if (s -> sp == 0)
    {
        res = 1;        
    }
    else
    {
        s -> sp--;
        *x = s -> values[s -> sp];   
    }    
    return res;
}
 
int Stop(SStack s, int *x){
    int res = 0;
    if (s -> sp == 0)
    {
        res = 1;        
    }
    else
    {

        *x = s -> values[s->sp-1];
    }
    return res;
}

struct staticQueue {
    int front;
    int length;
    int values [MAX];
};
typedef struct staticQueue *SQueue;


void SinitQueue (SQueue q){

    q -> front = 0;
    q -> length = 0;
}

int SisEmptyQ (SQueue q){
    int res = 0;

    if (q -> length != 0)
    {
        res = 1;
    }
    return res;
}

int Senqueue (SQueue q, int x){
    int res = 0;
    if (q -> length == MAX)
    {
        res = 1;
    }
    int Add_end = ((q->front + q->length) % MAX);  
    q ->values[Add_end] = x;
    q->length++;
    return res;
}

int Sdequeue (SQueue q, int *x){
    int res = 0;
    if (q->length == 0)
    {
        res = 1;
    }
    *x = q->values[q->front];
    q->front = (q->front+1) % MAX;
    q->length--;
    return res;
}

int Sfront (SQueue q, int *x){
    int res = 0;
    if (q->length == 0)
    {
        res = 1;
    }
    *x = q->values[q->front];
    return res;
}
