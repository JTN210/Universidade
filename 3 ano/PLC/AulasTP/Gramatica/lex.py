import ply.lex as lex 
import re 

tokens = {
    
"READ",
"IF",
"MAIOR",
"MENOR",
"IGUAL",
"WRITE",
"PA",
"PF",
"MULT",
"SOMA",
"MENOS",
"WHILE",
"VAR"
}

t_ignore = r'\t'
t_read = r'read'
t_if = r'if'
t_maior = r'>'
t_menor = r'<'
t_igual = r'='
t_mult = r'\*'
t_soma = r'\+'
t_menos = r'-'
t_while = r'while'
t_write = r'write'
t_pa = r'\('
t_pf = r'\)'
t_nums = r'\d+'


def t_var(t):
    r'[a-z][a-zA-Z_0-9]*' 
    t.value = t.value.lower()
    t.type = tokens.get(t.value, 'VAR')
    return t

def t_newline(t):
    r'\n+'
    t.lexer.lineno += len(t.value)


def t_error(t):
    print(f"Caractere ilegal: {t.value[0]!r}")
    t.lexer.skip(1)

lexer = lex.lex()
    
    