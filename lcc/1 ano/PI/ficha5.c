#include <stdio.h>
#include <string.h>


typedef struct aluno {
    int numero;
    char nome[100];
    int miniT [6];
    float teste;
    } Aluno;

void printAluno(Aluno a) {
        printf("Numero: %d\n", a.numero);
        printf("Nome: %s\n", a.nome);
        printf("miniT: ");
        for (int i = 0; i < 6; i++) {
            printf("%d ", a.miniT[i]);
        }
        printf("\n");
        printf("Teste: %.2f\n", a.teste);
        printf("------------------\n");
}
/* 
A avaliação tem duas alternativas:
por frequência (mini-testes (20%) com nota mínima de 25% + teste final (80%))
3 mini-testes online (via blackboard) nos dias 6.Março, 10.Abril e 24.Abril às 19:00
2 mini-testes nas aulas TP nas semanas que se iniciam a 24.Março e 5.Maio
teste final no dia 23.Maio
Exame de recurso (100%) no dia 13.Junho
*/
int nota (Aluno a){ 
    int i = 0, total = 0;
    int resultado = 0;

    for ( i = 0; i < 6; i++)
    {
        total += a.miniT[i];
    }
    total = (total *2);
    if (total < 5 )
    {
       resultado = -1; 
    }
    total = (total *0.2) + (a.teste * 0.8);

    if (total < 9.5)
    {
        resultado = -1;
    }
    
    
    return resultado;
}

int procuraNum (int num, Aluno t[], int N){
    Aluno a;
    int resultado = -1,Numero = N/2;
    if (t[Numero].numero < num )
    {
        for (int i = Numero; i < N; i++)
        {
            if (num == t[i].numero)
            {
                resultado = i;
                break;
            } 
        }
    }
    else
    {
        for (int i = Numero; i >= 0 ; i--)
        {
            if (num == t[i].numero)
            {
                resultado = i;
                break;
            }   
        }
    }
    return resultado;
}

void swap(Aluno *x, Aluno *y) {
    Aluno t = *x;
    *x = *y;
    *y = t;
}
void ordenaPorNum(Aluno t[], int N) {
    int i,j;
    for (i = 0; i < N-1; i++) 
    {
        for (j = i+1; j < N; j++) 
        {
            if (t[j].numero < t[i].numero)
            {
                swap(t+i, t+j);
            } 
        }
    }
}

void criaIndPorNum(Aluno t [], int N, int ind[]){
    int indices[N];
    for (int i = 0; i < N; i++)
    {
        indices[i] = i;
    }
    for (int i = 0; i < N; i++)
    {
        for (int j = 0; i < N; j++)
        {
            if (t[j].numero < t[i].numero)
            {
                swap(indices+i, indices+j);
            }    
            ind[indices[i]] = i;
        }   
    }   
}


void imprimeTurma (int ind[], Aluno t[], int N){
    for (int i = 0; i < N; i++)
    {
        int idx = ind[i];
        printf("Numero: %d Nome: %s Teste: %d MiniTeste: ", t[idx].numero, t[idx].nome, t[idx].teste);
        for (int j = 0; i < 6; j++)
        {
            printf("%d ", t[idx].miniT);
        }
    }
}
int main(){
Aluno turma[5] = {
    {1,  "Ana"  ,   {1,1,1,1,1,1}, 14.5},
    {2,  "Bruno",   {2,2,2,2,2,2}, 12.3},
    {3,  "Carla",   {3,3,3,3,3,3}, 10.2},
    {4,  "Diogo",   {4,4,4,4,4,4}, 16.5},
    {5,  "Eduardo", {5,5,5,5,5,5}, 18.0}
};
    printf("%d\n",nota(turma[1])); 
    printf("%d\n",procuraNum(1,turma, 5));
    ordenaPorNum(turma,5);
    printf("\nDepois de ordenar:\n");
    for (int i = 0; i < 5; i++) 
    {
        printAluno(turma[i]);
    }
    return 0;
}