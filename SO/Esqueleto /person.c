#include "pessoas.h"

int inserePessoa(char *nome, int idade){

    Pessoa p;
    p.idade = idade;
    strcpy(p.nome,nome);

    int fd = open(bd, O_CREAT |O_WRONLY | O_APPEND, 0640);
    ssize_t bytes_escritos = write(fd, &p ,sizeof(Pessoa));
    printf("%ld\n",bytes_escritos);

    close(fd);

    return bytes_escritos;
}

int listaPessoas(int n){
    Pessoa p;

    int fd = open(bd, O_RDONLY, 0600);
    
    for(int r = 0; r < n && read(fd, &p, sizeof(Pessoa)) > 0; r++)
    {
        printf("Registo: %d ---- Nome: %s ---- idade: %d\n",r,p.nome,p.idade);
    }

    close(fd);
    return 0;

}


int atualizaPessoa (char*nome, int idade){

    Pessoa p;

    int fd = open(bd,O_RDWR,0600);
            while(read(fd, &p, sizeof(Pessoa))) {
                if (!strcmp(nome,p.nome)) {
                    lseek(fd, -sizeof(Pessoa), SEEK_CUR);
                    write(fd,nome/*o problema esta para aqui*/, sizeof(Pessoa));
                
                }
            }


            close(fd);
            return 0;
}

