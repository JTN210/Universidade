#include <stdio.h>
#include <math.h> 
#include <stdlib.h>

float prodEx1 (int n,float m){
int i,N= 2,m = 5,k = 0;

    for(i= 0; i <N;i++)
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
 


}
