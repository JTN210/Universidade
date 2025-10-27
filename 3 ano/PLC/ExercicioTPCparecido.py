'''
Form': Form2 Form

Form:  v Form' 
    | Vazio

Form2':   ∧ Form2
      | Vazio
      
Form2: Literal  Form2'
    
Literal: Const 
       | Id
       
'''