#include <stdio.h>
#include <stdlib.h>
#include <windows.h>
#include <string.h>

// mycat(read,write,open,close)
// 

int main(int argc, char* argv[]){
    
    ssize_t bytes_read =0;
    DWORD bytes_read = 0;
    char* buffer = (char*) malloc(sizeof(char) * 1024);
    HANDLE hStdin = GetStdHandle(STD_INPUT_HANDLE);
    HANDLE hStdout = GetStdHandle(STD_OUTPUT_HANDLE);
    while (ReadFile(hStdin, buffer, 1024, &bytes_read, NULL) && bytes_read > 0)
    {
        DWORD bytes_written;
        WriteFile(hStdout, buffer, bytes_read, &bytes_written, NULL);
    }

    free(buffer);
}