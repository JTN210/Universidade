import Data.Char
import Data.List

length :: [Int] -> Int
length [] = 0
length (h:t) = 1 + length t 


reverse :: [Int] -> [Int]
reverse [] = []
reverse(x:y) = (y:x)
reverse (h:t) = h : reverse t 

