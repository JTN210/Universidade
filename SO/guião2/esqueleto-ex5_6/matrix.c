#include "matrix.h"


int **createMatrix() {

    // seed random numbers
    srand(time(NULL));

    // Allocate and populate matrix with random numbers.
    printf("Generating numbers from 0 to %d...", MAX_RAND);
    int **matrix = (int **) malloc(sizeof(int*) * ROWS);
    for (int i = 0; i < ROWS; i++) {
        matrix[i] = (int*) malloc(sizeof(int) * COLUMNS);
        for (int j = 0; j < COLUMNS; j++) {
            matrix[i][j] = rand() % MAX_RAND;
        }
    }
    printf("Done.\n");

    return matrix;
}

void printMatrix(int **matrix) {

    for (int i = 0; i < ROWS; i++) {
        printf("%2d | ", i);
        for (int j = 0; j < COLUMNS; j++) {
            printf("%7d ", matrix[i][j]);
        }
        printf("\n");
    }
}

// ex.5
int valueExists(int **matrix, int value) {
    pid_t pid;
    int status;
    int res = 0;
    for (int i = 0; i < ROWS; i++)
    {
        pid = fork();
        if (pid == 0)
        {
            for (int j = 0; j < COLUMNS; j++)
            {
                if(matrix[i][j] == value)
                {
                    _exit(0);
                }
            }
            _exit(-1);
        }
    }
    for (int i = 0; i < ROWS; i++)
    {
        pid = wait(&status);
        if (WIFEXITED(status))
        {
            if (WEXITSTATUS(status)==0)
            {
                printf("O Processo %d encontrou o valor %d\n",pid,value);
                return 1;
            }
        }
    }
    printf("O valor não foi encontrado na matriz.\n");
    return res;
}

// ex.6
void linesWithValue(int **matrix, int value) {
    int status, matches[ROWS];
    // Inicializa o array matches com 0 (nenhuma linha encontrada ainda)
    for (int i = 0; i < ROWS; i++) 
    {
        matches[i] = 0;
    }
    for (int i = 0; i < ROWS; i++)
    {
        if (fork() == 0)
        {
            for (int j = 0; j < COLUMNS; j++)
            {
                if (matrix[i][j] == value)
                {
                    _exit(i);
                }
            }
            _exit(-1);
        }
    }
    for (int i = 0; i < ROWS; i++)
    {
        pid_t pid = wait(&status);
        int linha = WEXITSTATUS(status);
        if (linha != 255)
        {
            matches[linha] = 1;
        }
    }
    printf("\n");
    int found = 0;
    for (int i = 0; i < ROWS; i++)
    {
        if (matches[i])
        {
            printf("Encontrado na linha %d\n", i);
            found = 1;
        }
    }
    if (!found) 
    {
        printf("Perde-mos Familia, não encontra-mos o valor.\n");
    }
}
