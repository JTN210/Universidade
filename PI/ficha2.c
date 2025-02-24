#include <stdio.h>
#include <math.h> 
#include <stdlib.h>
#include <assert.h>
float prodEx1 (int n,float m){
int i;
float k = 0;

    for(i= 0; i <n;i++)
    {
        k += m;
    }
  return k;
}
float prodEx2(int N,float m){
    float r = 0;
    while (N !=0)
    {
        if (N %2 != 0)
        {
            r += m;
        }
        N = N / 2; // N = N >> 1 12 = 1,2 mas como tamos a tratar de inteiros 12 = 1,0
        m = m*2;  // m = m << 1 avança uma casa para a esquerda 25 = 250
    }
    return r;  

}


int mdc1(int a,int b){
    int i, menor;
    if (a < b)
    {
        menor = a;
    }
    else
    {
        menor = b;
    }
    for (i = menor; i >= 1; i--)
    {
        if (a % i == 0 && b % i == 0)
        {
            return menor;
        }
        else
        {
            menor--;
        }
        
    }
    
    return 1;
}


int mdc2(int a, int b){

    while (a != 0 && b !=0)
    {
        if (a > b)
        {
            a = a - b;
        }
        else
        {
            b = b - a;
        }
        
    }
    if (a == 0)
    {
        return b;
    }
    else
    {
        return a;
    }

}


void ex5(int a, int b){
    int maior;

    while (a != 0 && b != 0)
    {
        if (a > b)
        {
            a = a % b;
        }
        else
        {
            b = b % a;
        }

    }
    return (a+b);
}

int escDiv(int 0, intv[]){
    int r = 0;
    int v[n];
    for (int i = 1; i <= n/2;i++)
    {
        if (n % i == 0 )
        {
            v[r] = i;
            r++;
        }
        
    }
    return 0;
}


int main(){

    //printf("\nMDC: %d\n", mdc2(45,18));
    assert(mdc1(45,18) == 9);
    assert(mdc2(45,18) == 9); /// o assert é como se fosse um teste, e se tiver bem n aparece nada se tiver mal para de correr o codigo 
    assert(prodEx2(10,42.5) == 425);
    printf("%d\n", escDiv(28));
    return 0;
}

