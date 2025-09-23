#include <stdio.h>

void quadrado(int n) {
for (int i = 0; i <n; i++)
   {
    for (int j = 0; j < n; j++)
    {putchar('*');
    
    }
    putchar('\n');
   } 
}


/// 2
/// feito a ladrão 
void xadrez(int n){

   for(int i = 0; i < n; i++)
   {
     
      for(int j = 0; j < 1; j++)
      {
         if( i % 2 == 0 )
         {
            printf("#_#_#");
         }
         else 
         {
            printf("_#_#_");
         }
         
      }

      putchar('\n');

   }
}

/// feito direito

void Xardrez1(int n){
   for(int i = 0; i < n; i++)
   {
     
      for(int j = 0; j < n; j++)
      {
         if( (j+i) % 2 == 0 )
         {
            putchar('#');
         }
         else 
         {
            putchar('_');
         }
         
      }

      putchar('\n');

   }
}


// 3 n percebi como se faz a segunda metade 

void triangulo_deitado (int n){
 int i,j;
for(i = 0; i < n; i++)
   {
      for(j = 0;j < i + 1; j++)
      {
         putchar('#');

      }

      putchar('\n');
   }
for (i = n-1 ;i >0; i--)
   {
      for (j = 0;j < i; j++)
      {
         putchar('#');

      }
      putchar('\n');

   }
}

//// tambem n sei como se faz

void triangulo(int n){
   int i,j;

   for (int i = 1; i <= n; i++) {
      for (int j = 0; j < n - i; j++) {
          putchar(' ');
      }
      for (int j = 0; j < (i*2-1); j++) {
          putchar('#');
      }
      putchar('\n');
  }


}


/// feito por mim mas mais melhor aprendido triangulo vertical
void triangulo_vertical(int n){
   int j,i,N;
    for(i = 0; i < N; i++){
        for(j = 0; j < i + 1; j++){

            putchar('#');
        }
    
        putchar('\n');
    }

    for(i= 0; i < N ; i++){
        for(j= 0; j < N - i-1 ; j++){
                putchar('#');

        }

                putchar('\n');
    }
}

/// triangulo feito like a doctor 
    void triangulo_doutor(int n){
        int i,N;
        for( i= 0; i < N; i++){
            for (int j = 0; j < N - i - 1; j++)
            {
                putchar(' ');
            }
            for ( int j = 0; j <i + 1; j++)
            {
                putchar('#');
            }
            
            for ( int j = 1; j < i + 1; j++)
            {
                putchar('#');
            }
            
           putchar('\n');
        }

    }

int desenha_circulo(int raio) {
    int x, y, count = 0;
    
    // Dimensão da matriz 2D (consideramos um quadrado de lado 2*raio)
    int diametro = 2 * raio;

    for (y = -raio; y <= raio; y++) {
        for (x = -raio; x <= raio; x++) {
            // Verifica se o ponto (x, y) está dentro do círculo
            if (x * x + y * y <= raio * raio) {
                printf("#");
                count++;
            } else {
                printf(" ");
            }
        }
        printf("\n");
    }

    return count;
}

int main() {
    int raio;
    
    // Pede o raio ao usuário
    printf("Digite o raio do círculo: ");
    scanf("%d", &raio);

    // Chama a função e imprime o número de caracteres
    int num_chars = desenha_circulo(raio);
    printf("\nTotal de '#' impressos: %d\n", num_chars);

    return 0;
}
