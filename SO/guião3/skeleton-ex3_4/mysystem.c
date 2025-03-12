#include "mysystem.h"

// recebe um comando por argumento
// returna -1 se o fork falhar
// caso contrario retorna o valor do comando executado
int mysystem (const char* command) {
	int res = -1;
	int i = 0;
	
	char *comandos = strdup(command);
	while (comandos[i] != '\0')
	{
		strsep(&comandos," ");
		i++;
	}	

	return res;
}