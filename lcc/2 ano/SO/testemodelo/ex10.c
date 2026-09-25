#include <unistd.h>
#include <stdio.h>
#include <sys/wait.h>
#include <fcntl.h>

#define N 5
int main (int argc, char *argv[]){

    int pipes [2][2];

    pipe(pipes[0]);

    pid_t pid1 = fork();
    if (pid1 == 0) //filter
    {
        close(pipes[0][0]);
        dup2(pipes[0][1],1);
        close(pipes[0][1]);

        execlp("filter","filter",argv[1],NULL);
        _exit(0);
    }
    else
    {
        close(pipes[0][1]);
    }

    pipe(pipes[1]);

    pid_t pid2 = fork();
    for (int i = 0; i < N; i++)
    {
        if (pid2 == 0)
        {
            // redirecionar filter-execute
            dup2(pipes[0][0],0);
            close(pipes[0][0]);

            //redirecionar execute-merge
            close(pipes[1][0]);
            dup2(pipes[1][1],1);
            close(pipes[1][1]);

            execlp("execute","execute",argv[1],NULL);
            _exit(0);
        }

    }
 close(pipes[1][1]);
 pid_t pid3 = fork();
 if (pid3 == 0)
 {
    dup2(pipes[1][0],0);
    close(pipes[1][0]);

    execlp("merge","merge",argv[1],NULL);
    _exit(0);
 }
 
    
    
}