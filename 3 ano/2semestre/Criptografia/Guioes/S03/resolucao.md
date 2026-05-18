### QUESTÃO: Q2

Qual o impacto de se considerar um *NONCE* fixo (e.g. tudo `0`)? Que implicações terá essa prática na segurança da cifra?

#### RESPOSTA: Q2
O impacto é a anulação da segurança da cifra. A utilização de um NONCE fixo torna a encriptação vulnerável a ataques de reutilização de keystream, permitindo que um atacante recupere o conteúdo original através da comparação de diferentes criptogramas (XOR), sem sequer precisar de conhecer a chave.

## Integridade

A cifra `ChaCha20`, por si só, não garante integridade dos dados. Por outro lado, por se tratar de uma **cifra sequencial síncrona**, não promove difusão da influência de troca de bits do criptograma.

### QUESTÃO: Q3

Pode todo o conteúdo do ficheiro ser adulterado por troca de um único bit do criptograma (i.e. do conteúdo do ficheiro `<fich>.enc`)? Justifique.

#### RESPOSTA: Q3
Não, pois algoritmo ChaCha20 é uma cifra sequencial síncrona. Isto significa que a cifragem é realizada ao gerar uma sequência pseudoaleatória de bits (a keystream) que é depois combinada com o texto-limpo através de uma operação exclusiva (XOR), bit a bit ou byte a byte.

Numa cifra sequencial, não existe difusão. Se for alterado um único bit no criptograma, quando o ficheiro for decifrado, apenas o bit correspondente na mesma exata posição do texto-limpo será alterado. O resto da keystream mantém-se perfeitamente sincronizada, e todos os restantes bits e bytes do ficheiro decifrado permanecerão intactos e originais.