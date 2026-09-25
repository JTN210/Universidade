import ply.yacc as yacc
from calc_lex import lexer, tokens, literals

def p_program(t):
    """
    Program: Program Instructions
           | Instruction 
           
    Instruction: "%" VAR
               | "!" Exp
               | VAR "=" Exp 
               | "#"
    
    Exp: Exp "+" Term
       | Exp "-" Term
       | Term
       
    Term: Term "+" Factor 
        | Term "/" Factor
        | Factor 
    
    Factor: NUM
          | VAR
          | "(" Exp ")" 

    Cond: Cond | Conj
        | Conj
        
    Conj: Conj & Comp
        | Comp
        
    Comp: Exp > Exp 
        | Exp < Exp 
    
    """
    
    
    
    
    
def p_error(t):
    parser.error = f"Syntax error: {t}"