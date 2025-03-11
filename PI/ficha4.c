#include <stdio.h>
#include <string.h>
int tamanho(char *s)
{
    int i = 0;
    while (s[i] != '\0')
    {
        i++;
    }
    return i;
}
int contaVogais(char *s)
{
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
int SerVogal(char s)
{
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
int retiraVogaisRep(char *s) {
    int t = strlen(s);
    char auxiliar[t + 1]; // +1 para o '\0'
    int novo = 0;
    int removidas = 0;

    for (int i = 0; s[i] != '\0'; i++) {
        if (SerVogal(s[i])) {
            // Se for vogal e diferente da vogal anterior, copia
            if (i == 0 || s[i] != s[i - 1]) {
                auxiliar[novo] = s[i];
                novo++;
            } else {
                removidas++; // vogal repetida, não copia
            }
        } else {
            // Se não for vogal, copia
            auxiliar[novo] = s[i];
            novo++;
        }
    }

    auxiliar[novo] = '\0'; // terminar a string

    // Copiar de volta para s
    strcpy(s, auxiliar);

    return removidas;
}


int retiraVogaisRep2(char *s){
    int removidas = 0, novo =0, atual = 0;

    while (s[atual] != '\0')
    {
        if (SerVogal(s[atual]) && s[atual] == s[atual+1])
        {
            atual++;
            removidas++;
        }
        else
        {
            s[novo]= s[atual];
            atual++;
            novo++;
        }
    }    
    s[novo] = '\0'; 
    return removidas;
}


int duplicaVogais(char *s){
    int duplicadas = 0,novo = 0;
    int t = strlen (s);
    char auxiliar [BUFSIZ];
    for (int i = 0; s[i] != '\0'; i++)
    {
        if (SerVogal(s[i]) && (s[i] == s[i-1]) ||(s[i] == s[i+1]) )
        {
            auxiliar[novo] = s[i];
            novo++;
        }
        else if (!SerVogal(s[i]))
        {
            auxiliar[novo] = s[i];
            novo++;
        }
        else
        {
            auxiliar[novo] = s[i];
            novo++;
            auxiliar[novo] = s[i];
            novo++;
            duplicadas++;
        }
        
    }
    auxiliar[novo] = '\0';


    strcpy(s,auxiliar);
    return duplicadas;
}

int duplicaVogais2(char *s){


    return 0;
}
int main()
{
    char c[BUFSIZ] = "Esta e uma string com duplicados";
    printf("%d\n", duplicaVogais(c));
    printf("%s\n", c);
    return 0;
}