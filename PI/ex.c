int main(){
    int i,j,*a,*b;
    i = 3;
    a = &I;
    j = 5;
    b = &j;
    i++;
    j = i + *b;
    b = a;
    j = j + *b;
    printf("%d\n", j);
    return 0;
}