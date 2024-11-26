{- import System.Random 
import Data.List (delete)
--randomIO :: Random a => IO a
--randomRIO :: Random a => (a,a) -> IO a

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



bingo = bingoB [1..90]
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
    | otherwise = "*" : compareStrings xs ys           

---- tem uma cena mal porque se for tipo tudo "casa" "aaaa" vai dar "aAaA" e devia dar (*A*A)

-- no teste pode saie função que multiplique matrizes -}


data Aposta = Ap [Int] (Int,Int)


valida :: [Int] -> (Int,Int) -> Bool
-- ver se tem 5 numeros/ 2 estrelas, ver se ta dentro de 1/50 e 1/9 e ver se n existe repetições
valida [] _ = False  
valida (x:xs) (a,b) |  a < 1 || b < 1 || a > 9 || b > 9  = False 
                       | a == b = False 
                       | length (x:xs) > 5 || length (x:xs) < 5 = False 
                       | not (verifica (x:xs)) = False 
                       | not (tamanho (x:xs) ) = False 
 

verifica :: [Int] -> Bool
verifica [] = True 
verifica (x:xs) | elem x xs = False
                | otherwise = verifica xs

tamanho :: [Int] -> Bool
tamanho [] = True
tamanho (x:xs)  | x < 1 || x > 50 = False 
                | otherwise = tamanho xs 


