#include <stdio.h>
#include <stdlib.h>

void swapM(int *x, int*y){
    int temp;
    temp = *x;
    *x = *y;
    *y = temp; 
    
}

void swap(int v[], int i, int j){

    int temp = v[i];
    v[i] = v[j];
    v[j] = temp;
}

int soma(int v[],int N){

    int res = 0;
    for (int i = 0; i < N ; i++)
    {
        res +=v[i];
    }
    return res;
}


void inverteArray(int v[], int N){
    int i = 0;
    int j = N-1;
    while( i < j)
    {
        swap(v, i, j);
        i++;
        j--;
    }
    
}

int maximum(int v[], int N, int *m){
    if(N <= 0){
        return -1;
    }
    *m = v[0];
    
    for (int i = 0; i < N; i++)
    {
        if(v[i] > *m)
        {
            *m = v[i];
        }
    }
    

    return 0;
}

void quadrados(int q[],int N){

    
}


int main(){
int v[10] = {1,2,3,4,5,6,7,8,9,10};
int x = 5;
int y = 3;
/*printf("Antes do SwapM\n x = %d , y = %d\n", x, y);
swapM(&x,&y);
printf("Depois do SwapM\n x = %d , y = %d\n", x,y);
*/
printf("Array inicial:\n");
 for (int i = 0; i < 10; i++)
 {
     printf("%d ", v[i]);
 }
     printf("\n");
/*swap(v, 1, 2);
printf("Array atualizado:\n");

for (int i = 0; i < 10; i++)
{
    printf("%d ", v[i]);
}
    printf("\n");

printf("soma:%d\n", soma(v,4));

inverteArray(v, 10);
printf("Array invertido:\n");
for (int i = 0; i < 10; i++) {
    printf("%d ", v[i]);
}
printf("\n");
*/
int max;
maximum(v, 10, &max);
printf("Maior elemento do array: %d\n",max);














return 0;
}

