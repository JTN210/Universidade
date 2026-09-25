import Data.Char
import Data.List

primUlt – que recebe uma lista e devolve um par com o primeiro e o ultimo
elemento dessa lista.

primult:: [Int] -> (Int,Int)

primUlt[h,t] = (h,t)
primult (h:t) = (h,tail t)

tail :: [Int] -> int
tail [x] = x
tail (h:t) = tail t 

truncaImpar  que recebe uma lista e, se o comprimento da lista for ımpar retira-
lhe o primeiro elemento, caso contrario devolve a propria lista

truncaImpar:: [Int] ->[Int]
truncaImpar [] = []
truncaimpar [x] = []
truncaimpar (h:t) = 
    if ( lenght (h:t) % 2 == 0 ) then (h:t)
    else t

lenght:: [Int]-> int 
lenght [] = 0
lenght (h:t) = 1 + lenght t 


Maior numero de uma [int]

 mint:: [INT] -> Int

mint [x] = x
mint (h:t) = if (h > mint t) then h
            else mint t 

mint2:: [Int] -> Int

mint2 [x]= x
mint2 (h:t) = if (aux h t) then h
             else mint2 t

aux:: Int -> [Int] -> Bool 

aux x [] = True
aux x (h:t) = if(x > h) then aux x t
              else False 



(a) testar se um par de inteiros representa uma hora do dia v´alida;
(b) testar se uma hora ´e ou n˜ao depois de outra (compara¸c˜ao);
(c) converter um valor em horas (par de inteiros) para minutos (inteiro);
(d) converter um valor em minutos para horas;

data Hora = H Int Int deriving (Show,Eq)
(c)
intmin:: Hora -> Int

intmin (H 0 y) = y
intmin (H x 0) = x * 60
intmin (H x y) = intmin (H x 0) + intmin (H 0 y)

Considere o seguinte tipo de dados para representar os poss´ıveis estados de um sem´aforo:
(a) Defina a fun¸c˜ao next :: Semaforo -> Semaforo que calcula o pr´oximo estado
de um sem´aforo.
(b) Defina a fun¸c˜ao stop :: Semaforo -> Bool que determina se ´e obrigat´orio parar
num sem´aforo.
(c) Defina a fun¸c˜ao safe :: Semaforo -> Semaforo -> Bool que testa se o estado
de dois sem´aforos num cruzamento ´e seguro.

data Semaforo = Verde | Amarelo | Vermelho deriving (Show,Eq)

next :: Semaforo -> Semaforo
next Verde = Amarelo
next Amarelo = Vermelho
next Vermelho = Verde

stop :: Semaforo -> Bool
stop Verde = False
stop Amarelo = True
stop Vermelho = True

safe :: Semaforo -> Semaforo -> Bool

safe x y | x == Verde && y == Verde = True 
         | x == verde && (y == Amarelo || y == Vermelho) = True 
         | otherwise = False



6 7 8 Fazer TPC












