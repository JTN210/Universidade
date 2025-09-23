import Data.Char



soDigitos :: [Char] -> [Char]

soDigitos [] = []
soDigitos (h:t) | h >= 0 && h <= 9 = (h : soDigitos t)
                |otherwise = soDigitos t

minusculas :: [Char] -> Int
minusculas [] = []
minusculas (h:t) | h >= "a" && h <= "z" = 1 + minusculas t
                 | otherwise = minusculas t

nums :: String -> [Int]
nums [] = []
nums (h:t) | h >= 0 && h <= 9 = (h : nums t)
           | otherwise = nums t

type Polinomio = [Monomio]
type Monomio = (Float,Int)

conta :: Int -> Polinomio -> Int
conta [] _ = 0
conta _ [] = 0
conta x ((y,ys):t) | x == ys = 1 + conta x t
                   | otherwise = conta x t

grau :: Polinomio -> Int
grau [] = 0
grau [(x,xs)] = xs
grau ((x,xs):(y,ys):t) | xs >= ys = grau ((x,xs):t)
                       | otherwise = grau ((y,ys):t)

selgrau :: Int -> Polinomio -> Polinomio
selgrau _ [] = []
selgrau j ((x,xs):t) | j == xs = (x,xs) : selgrau j t
                     | otherwise selgrau j t

deriv :: Polinomio -> Polinomio
deriv [] = []
deriv ((x,xs):t) | xs == 0 = deriv t
                 | otherwise = (x*xs,xs-1):deriv t 

calcula :: Float -> Polinomio -> Float
calcula n sei o que tenho de Fazer

simp :: Polinomio -> Polinomio
simp [] = []
simp ((x,xs):t) | xs == 0 = simp t
                | otherwise = (x,xs) : simp t

mult :: Monomio -> Polinomio -> Polinomio
mult _ [] = []
mult (x,xs) ((y,ys):t) | xs == 0 = (y*x,ys) : mult (x,xs) t
                       | otherwise = (y*x,ys*xs) : mult (x,xs) t

normaliza :: Polinomio -> Polinomio
normaliza [] = []
normaliza ((x,xs):(y,ys):t)| xs == ys = normaliza (x+y,xs) t 
                           | otherwise = normaliza (x,xs) t : normaliza (y,ys) t

soma :: Polinomio -> Polinomio -> Polinomio
soma [] [] = []
soma x y = normaliza ((x) ++ (y))

produto :: Polinomio -> Polinomio -> Polinomio
produto _ [] = []
produto [] _ = []
produto ((a,b):t) ((x,xs):t) | b == 0 = (x*a,xs) : produto ((a,b):t) t + produto t ((x,xs):t)
                             | otherwise = (x*a,xs+b) : produto ((a,b):t) t + produto t ((x,xs):t)


