import System.Random (randomRIO)


data Aposta = Ap [Int] (Int, Int)
    deriving (Show)
{- bingo :: IO ()
bingo = do
            x <- randomRIO(1,90)
            print x 
            getline -- espera que o utilizador carregue no ENTER
            bingo 


bingo=bingoA []
bingoA :: [Int] -> IO ()
bingoA l  | length l == 90 = return ()
bingoA l = do 
            x <- randomRIO(1,90)
            if ( elem x l) then bingoA l
            else do print x 
            getline 
            bingoA (x:l)
 

bingo = bingoB [1..90]
bingoB :: [Int] -> IO ()
bingoB [] = return ()
bingoB l= do 
    x <- randomRIO(1,90)
     if elem x l
        then do  
            print x
-} 



{- bingo = bingoB [1..90]
bingoB :: [Int] -> Int -> IO () -- recebe a lista e o comprimento da lista n
bingoB [] _  = return ()
bingoB l n = do i <- randomRIO (0, n-1)
                let ( a,x:b) = splitAt i l
                putStrLn (show x)
                getLine
                bingoB (a ++ b) (n-1) 

main :: IO()
main = bingoB [1..90] 90



wordle :: String -> IO Int 
wordle x = wordleC 1 x 
wordleC :: Int -> String -> IO Int 
wordleC n x = do 
          y <-  getLine 
        if x == y then  do 
                        putStrLn "Parabens"
                        return n -- n= numero de tentativas em que acertou
        else do let r = compareStrings x y 
                    putStrLn r 
                    wordleC (n+1) x 



compareStrings :: String -> String -> String
compareStrings [] [] = []
compareStrings (x:xs) (y:ys)
    | x == y    = toUpper y : compareStrings xs ys
    | x != y && elem y (x:xs) = y : compareStrings xs ys   
    | otherwise = "*" : compareStrings xs ys     -}       

---- tem uma cena mal porque se for tipo tudo "casa" "aaaa" vai dar "aAaA" e devia dar (*A*A)

-- no teste pode saie função que multiplique matrizes 



valida :: [Int] -> (Int,Int) -> Bool
-- ver se tem 5 numeros/ 2 estrelas, ver se ta dentro de 1/50 e 1/9 e ver se n existe repetições  
valida (x:xs) (a,b)    |  a < 1 || b < 1 || a > 9 || b > 9  = False 
                       | a == b = False 
                       | length (x:xs) > 5 || length (x:xs) < 5 = False 
                       | not (verifica (x:xs)) = False 
                       | not (tamanho (x:xs) ) = False 
                       | otherwise = True 
 

verifica :: [Int] -> Bool
verifica [] = True 
verifica (x:xs) | elem x xs = False
                | otherwise = verifica xs

tamanho :: [Int] -> Bool
tamanho [] = True
tamanho (x:xs)  | x < 1 || x > 50 = False 
                | otherwise = tamanho xs 


comuns :: Aposta -> Aposta -> (Int,Int)
--  que dada uma aposta e uma chave, calcula quantos n´umeros e quantas estrelas existem em comum nas duas apostas
comuns (Ap (x:xs) (a,b)) (Ap (y:ys) (c,d)) = (comparaA (x:xs) (y:ys),comparaB (a,b) (c,d) )


comparaA :: [Int] -> [Int] -> Int 
comparaA [] _ = 0
comparaA _ [] = 0
comparaA (x:xs) (y:ys) | elem x (y:ys) = 1 + comparaA xs (y:ys)
                       | otherwise = comparaA xs (y:ys)



comparaB :: (Int,Int) -> (Int,Int) -> Int 
comparaB (a,b) (c,d) | ((a == c) || (a == d)) && ((b == c) || (b == d)) = 2  
                     | (a == c) || (a == d) || (b == c) || (b == d) = 1
                     | otherwise = 0



 {-   instance Eq Aposta where
    (==) :: Aposta -> Aposta -> Bool
    (Ap nums1 (a1, b1)) == (Ap nums2 (a2, b2)) =
        nums1 == nums2 && (a1 == a2 && b1 == b2 || a1 == b2 && b1 == a2) 

-- mas a utilizar a função comuns fica 
(Ap nums1 (a1, b1)) == (Ap nums2 (a2, b2)) =
comuns (Ap nums1 (a1, b1))  (Ap nums2 (a2, b2)) == (5,2) -}


premio :: Aposta -> Aposta -> Maybe Int
premio (Ap (x:xs) (a,b)) (Ap (y:ys) (c,d)) | comuns (Ap (x:xs) (a,b)) (Ap (y:ys) (c,d)) == (5,2) = Just 1
                                           | comuns (Ap (x:xs) (a,b)) (Ap (y:ys) (c,d)) == (5,1) = Just 2
                                           | comuns (Ap (x:xs) (a,b)) (Ap (y:ys) (c,d)) == (5,0) = Just 3
                                           | comuns (Ap (x:xs) (a,b)) (Ap (y:ys) (c,d)) == (4,2) = Just 4
                                           | comuns (Ap (x:xs) (a,b)) (Ap (y:ys) (c,d)) == (4,1) = Just 5
                                           | comuns (Ap (x:xs) (a,b)) (Ap (y:ys) (c,d)) == (4,0) = Just 6
                                           | comuns (Ap (x:xs) (a,b)) (Ap (y:ys) (c,d)) == (3,2) = Just 7
                                           | comuns (Ap (x:xs) (a,b)) (Ap (y:ys) (c,d)) == (2,2) = Just 8
                                           | comuns (Ap (x:xs) (a,b)) (Ap (y:ys) (c,d)) == (3,1) = Just 9   
                                           | comuns (Ap (x:xs) (a,b)) (Ap (y:ys) (c,d)) == (3,0) = Just 10
                                           | comuns (Ap (x:xs) (a,b)) (Ap (y:ys) (c,d)) == (1,2) = Just 11
                                           | comuns (Ap (x:xs) (a,b)) (Ap (y:ys) (c,d)) == (2,1) = Just 12
                                           | comuns (Ap (x:xs) (a,b)) (Ap (y:ys) (c,d)) == (2,0) = Just 13
                                           |otherwise = Nothing 


-- a função words :: String -> [String] transforma "1 2 3 4 5" em ["1", "2", "3", "4", "5"].
-- a instancia read basicamente passa uma String lista de strings em coisas neste caso em inteiros


-- Função principal que lê e valida uma aposta
{- leAposta :: IO Aposta
leAposta = do
  putStrLn "Digite 5 números distintos entre 1 e 50 (separados por espaço):"
  numerosInput <- getLine
  putStrLn "Digite 2 estrelas distintas entre 1 e 9 (separadas por espaço):"
  estrelasInput <- getLine

  -- Usando let para calcular os números e as estrelas
  let numeros = map read (words numerosInput) :: [Int] -- Converte a entrada para uma lista de inteiros
      [a, b] = map read (words estrelasInput) :: [Int] -- Converte a entrada para duas estrelas

  -- Verificar se a aposta é válida
  if valida numeros (a, b)
    then do
      putStrLn "Aposta válida registada!"
      return (Ap numeros (a, b))
    else do
      putStrLn "Aposta inválida. Tente novamente."
      leAposta



joga :: Aposta -> IO ()
joga chave = do 
    putStrLn $ "Faça a sua Aposta:"
    aposta <- leAposta
    let (numerosComuns,estrelasComuns) = comuns aposta chave 
    putStrLn $ "Numeros iguais: " ++ show numerosComuns
    putStrLn $ "Estrelas iguais " ++ show estrelasComuns
    putStrLn $ "O seu premio é " ++ show (premio aposta chave) -}


geraChave :: IO Aposta
geraChave = do
            numeros <- geraNumeros 5 (1,50)
            estrelas <- geraNumeros 2 (1,9)
            return (Ap numeros (head estrelas, estrelas !! 1))
            

geraNumeros :: Int -> (Int,Int) -> IO [Int]
geraNumeros 0 _ = return []
geraNumeros n x = do
                    num <- randomRIO x 
                    resto <- geraNumeros (n-1) x 
                    if elem num resto then geraNumeros n x 
                    else return (num : resto)

main :: IO ()
main = do
    chave <- geraChave
    putStrLn $ "Chave gerada: " ++ show chave
