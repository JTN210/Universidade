import Data.Char
import Data.List

fromDigits :: [Int] -> Int 
-- [1,2,3,4] = 1234
fromDigits [] = 0
fromDigits l = aux (lenght l - 1) l 

aux :: Int -> [Int] -> Int 
aux e [] = 0
aux e (h:t) = h * 10^e + aux (e-1) t 

fromDigits :: [Int] -> Int 
-- [1,2,3,4] = 1234
fromDigits [] = 0
fromDigits l = aux (10^(lenght l - 1)) l 

aux :: Int -> [Int] -> Int 
aux e [] = 0 
aux e (h:t) = h * e + aux (div e 10) t 


fromDigits :: [Int] -> Int 
-- [1,2,3,4] = 1234
fromDigits l = aux 0 l  

aux :: Int -> [Int] -> Int 
aux acc [] = acc 
aux acc (h:t) = aux (acc*10 + h) t 


toDigitos :: Int -> [Int]
--  1432 = [1,4,3,2]
-- mod 1432 10 = 2
-- div 1432 10 = 143
-- divMod 1432 10 = (143,2)
toDigitos l | l < 10 = [l]
            | otherwise = toDigitos x ++ [y]
        where (x,y) = divMod l 10 


--1 

digitAlpha :: String -> (String,String)
-- vai dividir os caracteres em numeros e letras
-- digitALpha "a,2b3;4" = ("234","ab")
import Data.Char (isDigit, isAlpha)
digitAlpha str = foldl separar ("", "") str
  where
    separar (letters, digits) char
      | isAlpha char = (letters ++ [char], digits)   -- Se é letra, adiciona a `letters`
      | isDigit char = (letters, digits ++ [char])   -- Se é dígito, adiciona a `digits`
      | otherwise    = (letters, digits)             -- Ignora outros caracteres


--2 
nzp :: [Int] -> (Int,Int,Int)

nzp l = nzpaux (0,0,0) l

nzpaux :: (Int,Int,Int) -> [Int] -> (Int,Int,Int)
nzpaux (x,y,z) [] = (x,y,z)
nzpaux (x,y,z) (h:t) | h == 0 = nzpaux (x,y+1,z) t
                     | h < 0 = nzpaux (x+1,y,z) t
                     | otherwise = nzpaux (x,y,z+1) t

--3 
divMod :: Integral a => a -> a -> (a, a)
-- fazer
--4

fromDigits :: [Int] -> Int
fromDigits [] = 0
fromDigits (h:t) = h*10^(lenght t) + fromDigits t


fromDigits :: [Int] -> Int
fromDigits l = aux 0 (lenght l-1) l  

aux :: Int -> [Int] -> Int
aux x  y [] = x
aux x  y (h:t) = aux (x + h*10^y) y-1 t 






--5 se for numero negativo a aux do maxsuminit funciona? perguntar segunda se posso utilizar 0
maxSumInit :: (Num a, Ord a) => [a] -> a
maxSumInit l = maximum [sum m | m <- inits l]

maxSumInit l = aux (head l) (ints l)

aux :: (Num a, Ord a) => a -> [[a]] -> a
aux x [] = x
aux x (h:t) | x >= sum h = aux x t
            | otherwise = aux (sum h) t


sum :: (Num a, Ord a) => [a] -> a
sum l = auxsum 0 l
  
auxsum :: (Num a, Ord a) => a -> [a] -> a
auxsum x [] = x
auxsum x (h:t) = auxsum (x+h) t 
--7
intToStr :: Integer -> String
intToStr n
  | n < 0     = '-' : intToStrAux (-n) ""  -- Se o número é negativo, adiciona '-' e converte o valor positivo
  | n == 0    = "0"                        -- Caso especial para o número 0
  | otherwise = intToStrAux n ""           -- Para números positivos, chama a função auxiliar

-- Função auxiliar que converte um número positivo em uma string
intToStrAux :: Integer -> String -> String
intToStrAux 0 acc = acc                    -- Quando o número é 0, retorna o acumulador (inverte o número)
intToStrAux num acc = intToStrAux (num `div` 10) (toEnum (fromEnum '0' + fromIntegral (num `mod` 10)) : acc)


--8 a 
[x | x <- [1..20], mod x 2 == 0, mod x 3 == 0]
  == [6,12,18]
-- alternativas mais "eficientes"
[x | x <- [1..20], mod x 6 == 0]




 --c
[(x,y) | x <- [0..20], y <- [0..20], x+y == 30]
 == [(10,20),(11,19),(12,18),(13,17),(14,16),(15,15),(16,14),(17,13),(18,12),(19,11),(20,10)] 
-- alternativa
 [(x,30-x)| x <- [1..20]]

--d
[sum [y | y <- [1..x], odd y] | x <- [1..10]]  -- odd diz se  Nº é impar True ou False
[sum [1], sum [1],sum[1,3], sum [1,3], sum [1,3,5], sum[1,3,5], sum[1,3,5,7], sum[1,3,5,7], sum[1,3,5,7,9], sum,[1,3,5,7,9]]
== [1,1,4,4,9,9,16,16,25,25]

--9
[1,2,4,8,16,32,64,128,256,512,1024]
[2^x | x <- [1..12] ]

--c
[[1],[1,2],[1,2,3],[1,2,3,4],[1,2,3,4,5]]
[  [y | y <- [1..x]]| x <- [1..5]]

--e
[1,2,6,24,120,720]
[prod [y | y <- [1..x]] | x <- [1..5]]
