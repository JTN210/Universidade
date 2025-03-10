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
    
    for (int i = 1; i < N; i++)
    {
        if(v[i] > *m)
        {
            *m = v[i];
        }
    }
    

    return 0;
}

void quadrados(int q[],int N){

    for (int i = 0; i <= N; i++)
    {
        q[i] = i*i;
    }
    
}

// Função que preenche o vetor v com a N-ésima linha do Triângulo de Pascal
void pascal(int v[], int N) {
    // Inicializa todos os elementos do vetor com 0
    for (int i = 0; i < N; i++) {
        v[i] = 0;
    }

    v[0] = 1; // A primeira posição sempre é 1

    // Construindo as linhas do triângulo de Pascal até a linha N
    for (int linha = 1; linha < N; linha++) {
        // Atualiza os valores de trás para frente
        for (int i = linha; i > 0; i--) {
            v[i] = v[i] + v[i - 1];
        }
    }
}

// Função para imprimir as N primeiras linhas do Triângulo de Pascal
void imprimeTrianguloPascal(int N) {
    int v[N];  // Vetor temporário para armazenar cada linha

    v[0] = 1;  // A primeira linha começa sempre com 1

    for (int linha = 0; linha < N; linha++) {
        // Imprimir espaços para alinhar o triângulo (opcional, para melhor visualização)
        for (int k = 0; k < N - linha - 1; k++) {
            printf(" ");
        }

        // Atualizar os valores do vetor de trás para frente
        for (int i = linha; i > 0; i--) {
            v[i] = v[i] + v[i - 1];
        }

        v[linha] = 1;  // Último elemento da linha sempre é 1

        // Imprimir a linha atual
        for (int i = 0; i <= linha; i++) {
            printf("%d ", v[i]);
        }
        printf("\n");  // Nova linha
    }
}


int main(){
int v[10] = {1,2,3,4,5,6,7,8,9,10};
int x = 5;
int y = 3;
/*printf("Antes do SwapM\n x = %d , y = %d\n", x, y);
swapM(&x,&y);
printf("Depois do SwapM\n x = %d , y = %d\n", x,y);

printf("Array inicial:\n");
 for (int i = 0; i < 10; i++)
 {
     printf("%d ", v[i]);
 }
     printf("\n");
swap(v, 1, 2);
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

int max;
maximum(v, 10, &max);
printf("Maior elemento do array: %d\n",max);

quadrados(v,9);
printf("Array dos Quadrados:\n");
for (int i = 0; i < 10; i++)
{
    printf("%d ", v[i]);
}
    printf("\n");

 int n = 4;
pascal(v,n);
printf("Array Pascal:\n");
for (int i = 0; i < n; i++)
{
    printf("%d ", v[i]);
}
    printf("\n");

int N = 5;
imprimeTrianguloPascal(N);

return 0;
*/
}