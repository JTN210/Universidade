int main(void) {
    while (1) {
        if (fork() < 0) {
            // Se falhar ao criar novo processo, sai
            exit(0);
        }
    }
    return 0;
}
