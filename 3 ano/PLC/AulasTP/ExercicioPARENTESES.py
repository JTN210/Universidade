import ply.lex as lex


'''
Exercicio da Aula 

Implementar o parsing para os ()

  p1: '(' p1 ')' p1 | vazio

  First [ '(' p1 ')' p1 ] = { '(' }
  First Vazio = { Vazio }

  Follow [ p1 ] = { ')' , Vazio }

'''
tokens = ('PA', 'PF')

t_PA = r'\('
t_PF = r'\)'

def t_newline(t): 
    r'\n+' 
    t.lexer.lineno += len(t.value)
    
t_ignore = '\t '

def t_error(t): 
    print('Carácter desconhecido: ', t.value[0], 'Linha: ', 
t.lexer.lineno) 
    t.lexer.skip(1) 
 
lexer = lex.lex()

prox_simb = None 

def parserError(simb):
    print(f"Erro sintático, token inesperado: {simb}")

def processa_terminal(simb):
    global prox_simb
    if prox_simb and prox_simb.type == simb:
        prox_simb = lexer.token()
    else:
        parserError(prox_simb)
        
def processa_P1():
    global prox_simb
    if prox_simb and prox_simb.type == 'PA':
        print("Derivando por P1 → ( P1 ) P1")
        processa_terminal('PA')
        processa_P1()
        if prox_simb and prox_simb.type == 'PF':
            processa_terminal('PF')
            processa_P1()
        else:
            parserError(prox_simb)
    else:
        print("Derivando por P1 → ε")

def rec_Parser(data): 
    global prox_simb 
    lexer.input(data) 
    prox_simb = lexer.token()
    processa_P1() 
    print("E a tua mãe Caralho!") 


linha = "(((((((((((())))))))))))"
rec_Parser(linha)