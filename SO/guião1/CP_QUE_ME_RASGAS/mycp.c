#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>


#define SIZE 1024
int main(int argc, char *argv[])
{   

    int src = open(argv[1], O_RDONLY,0600);
    int dest = open(argv[2], O_CREAT | O_WRONLY, 0666);
    ssize_t n_read = 0;
    char buffer[SIZE];

    while((n_read = read(src, &buffer, SIZE)) != 0)
    {
		  write(dest, &buffer, n_read);
    }

    close(src);
    close(dest);

    return 0;
}