from analex import lexer

prox_simb = None

def parserError(simb):
    print("Erro sintático, token inesperado:", simb)

def processa_term(simb):
    global prox_simb
    if prox_simb and prox_simb.type == simb:
        prox_simb = lexer.token()
    else:
        parserError(prox_simb)

# Ideia da gramática:
'''
P1  → T P2
P2 → + T P2 
    | - T P2 
    | ε
T  → F T2
T2 → * F T2 
    | / F T2 
    | ε
F  → NUM 
    | ( P1 )
'''       
def processa_P1():
    print("Derivando por: P1 → T P2")
    processa_T()
    processa_P2()
    print("Reconheci: P1 → T P2")

def processa_P2():
    global prox_simb
    if prox_simb and prox_simb.type == 'PLUS':
        print("Derivando por: P2 → + T P2")
        processa_term('PLUS')
        processa_T()
        processa_P2()
        print("Reconheci: P2 → + T P2")
    elif prox_simb and prox_simb.type == 'MINUS':
        print("Derivando por: P2 → - T P2")
        processa_term('MINUS')
        processa_T()
        processa_P2()
        print("Reconheci: P2 → - T P2")
    else:
        print("Derivando por: P2 → ε (vazio)")

def processa_T():
    print("Derivando por: T → F T2")
    processa_F()
    processa_T2()
    print("Reconheci: T → F T2")

def processa_T2():
    global prox_simb
    if prox_simb and prox_simb.type == 'MUL':
        print("Derivando por: T2 → * F T2")
        processa_term('MUL')
        processa_F()
        processa_T2()
        print("Reconheci: T2 → * F T2")
    elif prox_simb and prox_simb.type == 'DIV':
        print("Derivando por: T2 → / F T2")
        processa_term('DIV')
        processa_F()
        processa_T2()
        print("Reconheci: T2 → / F T2")
    else:
        print("Derivando por: T2 → ε (vazio)")

def processa_F():
    global prox_simb
    if prox_simb is None:
        parserError(prox_simb)
        return
    if prox_simb.type == 'NUM':
        print("Derivando por: F → NUM")
        processa_term('NUM')
        print("Reconheci: F → NUM")
    elif prox_simb.type == 'PA':
        print("Derivando por: F → ( P1 )")
        processa_term('PA')
        processa_P1()
        processa_term('PF')
        print("Reconheci: F → ( P1)")
    else:
        parserError(prox_simb)

def rec_Parser(data):
    global prox_simb
    lexer.input(data)
    prox_simb = lexer.token()
    processa_P1()
    print("Análise concluída!")