Exercicio 1

Especifique uma expressão regular que faça match com qualquer string binária desde que esta não contenha a substring "011".


Exemplos válidos:
1111111
000001
1111010101000


Exemplos inválidos:
111010110111
011
00000001100000000


Resposta: 


^(?!.*011)[01]*$





![Foto de João Carlos Teixeira Neiva](../photo.jpeg)


João Neiva, A108579


