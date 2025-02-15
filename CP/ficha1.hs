import Data.Char
import Data.List

lengtho :: [Int] -> Int
lengtho [] = 0
lengtho (h:t) = 1 + lengtho t 


reverso :: [a] -> [a]
reverso [] = []
reverso (h:t) = reverso t ++ [h]

