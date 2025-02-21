#include <stdio.h>
#include <math.h> 
#include <stdlib.h>

float prodEx1 (int n,float m){
int i,k = 0;

    for(i= 0; i <n;i++)
    {
        k += m;
    }
  return k;
}
float prodEx2(int N,float m){
    int r = 0;
    while (N !=0)
    {
        if (N %2 != 0)
        {
            r += m;
        }
        N = N / 2;
        m = m*2;
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


int main(){

    printf("\nMDC: %d\n", mdc1(45,18));
    return 0;
}