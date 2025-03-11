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
    int novo = 0,atual = 0, duplicadas = 0;

    while (s[atual] != '\0')
    {
        if (!SerVogal(s[atual]))
        {
            atual++;
        }
        else if (SerVogal(s[atual]) && ((s[atual] == s[atual-1]) ||(s[atual] == s[atual+1])))
        {
            atual++;
        }
        else
        {
            atual++;
            duplicadas++;
        }
        
    }
    return duplicadas;
}



int ordenado (int v[], int N){
    int res = 1, i = 0;
    while ( i < N)
    {
        if ((v[i] > v[i+1]) )
        {
            res = -1;
        }
        i++;
    }
    return res;
}

void merge(int a[], int na, int b[], int nb, int r[]) {
    int N = na + nb;
    int pA = 0, pB = 0;

    for(int total = 0; total < N; total++) {
        if (pB >= nb) r[total] = a[pA++];
        else if (pA >= na) r[total] = b[pB++];
        else if (b[pB] > a[pA]) r[total] = a[pA++];
        else r[total] = b[pB++];
    }
}
int partition(int v[], int N, int x){
    int novo = 0;
    int auxiliar[BUFSIZ];
    for(int i = 0; i < N; i++)
    {
        if (v[i] <= x)
        {
        auxiliar[novo] = v[i];
        novo++;
        }
    }
    int Segundametade = novo;
    for (int i = 0; i < N; i++)
    {
        if (v[i] > x)
        {
            auxiliar[Segundametade] = v[i];
            Segundametade++;
        }
    }
    for (int i = 0; i < N; i++)
    {
        v[i] = auxiliar[i];
    }
    return novo;
}
int main()
{
    /* char c[BUFSIZ] = "Esta e uma string com duplicados";
    printf("%d\n", duplicaVogais2(c));
    printf("%s\n", c); 
    int v[] = {1, 2, 3, 4, 5, 6, 7, 8};
    int N = sizeof(v)/sizeof(v[0]);
    int x = 5;
    int pos = partition(v, N, x);
    printf("Array apos partition:\n");
    for (int i = 0; i < N; i++) {
        printf("%d ", v[i]);
    }
    printf("\n");  
    printf("Numero de elementos <= %d = %d\n", x, pos);
    */
    return 0;
}