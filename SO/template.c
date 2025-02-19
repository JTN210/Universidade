#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>

int main(int argc, char* argv[]){

    int dest = open (argv[2], O_CREAT | O_WRONLY, 0666);

    ssize_t bytes_written = write (dest, argv[1], strlen(argv[1]));

    lseek (dest, -bytes_written, SEEK_CUR);

    ssize_t bytes_read = 0;
    char*buffer = (char*) malloc(sizeof(char)*1024);
    read (dest, buffer, bytes_written);

    printf("Mensagem lida: %s\n", buffer);

    free(buffer);

    
    return 0;
}