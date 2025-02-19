#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>

int main(int argc, char* argv[]){

    int src = open (argv[1], O_RDONLY);
    int dest = open(argv[2], O_CREAT | O_WRONLY, 0666);

    off_t pos = lseek(dest, 0, SEEK_END);
    int buffer_size = atoi(argv[3]);

    ssize_t bytes_read = 0;
    char* buffer = (char*) malloc(sizeof (char)*buffer_size);
    while ((bytes_read = read(src, buffer,buffer_size))>0)
    {
        write(dest,buffer, bytes_read);
    }
    

    free (buffer);
    close (src);
    close (dest);

    return 0;
}