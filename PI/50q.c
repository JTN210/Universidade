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
int main(){
   // q1(99999999);
   // q2(99999999);
      q3(99999999);
    return 0;
}