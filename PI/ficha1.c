#include <stdio.h>
/*int main() {
for (int i = 0; i <6; i++)
   {
    for (int j = 0; j < 6; j++)
    {putchar('*');
    
    }
    putchar('\n');
   } 

return 0;


}
*/
/// 2
 /// feito a ladrão 
/*
int main(){

   for(int i = 0; i < 5; i++)
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
   return 0;

}

/// feito direito

int main(){
      int n = 5;
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
   return 0;

}


*/
/// 3

int main(){
 int i,j,n = 5;
for(i = 0; i < n; i++)
   {
      for(j = 0;j < i +1; j++)
      {
         putchar('#');

      }

      putchar('\n');
   }

}