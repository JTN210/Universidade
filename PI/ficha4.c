#include <stdio.h>


int tamanho (char *s){
    int i =0;
    while (s[i]!= '\0')
    {
        i++;
    }
    return i;
}
int contaVogais(char *s){
    int num = 0;
    while (*s != '\0')
    {
        if (*s == 'a' || *s == 'A' ||
            *s == 'e' || *s == 'E' ||
            *s == 'i' || *s == 'I' ||
            *s == 'o' || *s == 'O' ||
            *s == 'u' || *s == 'U')
            {
                num++;
            }
        s++;
    }    
    return num;
}

 // *a, "o conteudo do endereço de memoria a"
 // quando existe \0 significa que a string acabou
 int  SerVogal(char s){
    if (s == 'a' || s == 'A' ||
        s == 'e' || s == 'E' ||
        s == 'i' || s == 'I' ||
        s == 'o' || s == 'O' ||
        s == 'u' || s == 'U')
        {

            return 1;
        }
        else
        {
            return 0;
        }
 }
int retiraVogaisRep(char *s){
    //int t = tamanho(s);
    char auxiliar[400000];
    int inicial,novo,i;

    for (int i = 0; s[i] != '\0'; i++)
    {
        if (SerVogal(s[i]) != 1)
        {
            auxiliar[i] = s[i];
            inicial++;
            novo++;
        }
        else
        {
            if(s[i] != s[i+1])
            {
               auxiliar[i] = s[i];
                i++;
                inicial++;
                novo++;
            }
            else
            {
                inicial++;
            }
        }     
    } 
    int m;
    for ( m = 0; m < novo; m++)
    {
        s[m] = auxiliar[m];
    }
    s[m] = '\0';
     
    return inicial-novo;
}

int retiraVogaisRep2(char *s){

    for (int i = 0; s[i] != '\0'; i++)
    {
        if (SerVogal(s[i]) == 1)
        {
            if(s[i] == s[i+1])
            {
                s[i] = s[i+1];
            }
            else
            {
                s[i] = s[i];
            }

        }     
    } 
    return *s;
}

int main(){
    char c[] = "proograamaacao";
    printf("%d\n",retiraVogaisRep(c));
    printf("%s\n",c);
    return 0;
}