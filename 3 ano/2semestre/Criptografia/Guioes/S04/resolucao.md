### QUESTÃO: Q1

Ao executar o chacha20_int_attack.py sobre um ficheiro gerado pelo chcha20_poly1305, o ataque tentará alterar bits do conteúdo. Quando se tentar decifrar, a biblioteca detetará que o MAC não coincide.
O programa exibirá a mensagem de erro de integridade e quem estiver a tentar fazer o ataque não vai conseguir manipular o conteúdo de forma invisível.

### QUESTÃO: Q2

O CBC-MAC com IV aleatório é vulnerável porque o atacante controla a entrada da primeira função de cifragem, ao aplicar um XOR entre o IV original, o bloco original e o bloco malicioso, obtém-se um novo IV que mantém a cadeia de cifragem inalterada.Isso permite a falsificação existencial de mensagens sem conhecimento da chave secreta.
