type Mat a = [[a]]

{- zipWith :: (a->b->c) -> [a] -> [b] -> [c]
zipWith f [] [] = []
zipWith f _ [] = []
zipWith f [] _ = []
zipWith f (x:xs) (y:ys) = (f x y) : zipWith f xs ys 

takeWhile :: (a->Bool) -> [a] -> [a]
takeWhile f l = auxtake f [] l
                   
auxtake :: (a->Bool) -> [a] -> [a] -> [a] 
auxtake f x [] = x
auxtake f x (h:t) | (f h) == False = x
                  | otherwise = auxtake f (x:h)  t

dropWhile :: (a->Bool) -> [a] -> [a]
dropWhile f [] = []
dropWhile f (h:t) | (f h) = dropWhile f t
                  | otherwise = (h:t)
            


--2
type Polinomio = [Monomio]
type Monomio = (Float,Int)

selgrau :: Int -> Polinomio -> Polinomio











--3 
type Mat a = [[a]]

dimOK :: Mat a -> Bool
dimOK [] = True
dimOK (x:xs) = auxOK (lenght x) xs 


auxOK :: Int -> Mat a -> Bool
auxOK x [] = True 
auxOK x (h:t) | (lenght h) != x = False 
              | otherwise = auxOK x t


dimMat :: Mat a -> (Int,Int)
dimMat (x:xs) = dimMataux (lenght x,0) xs

dimMataux :: (Int,Int) -> Mat a -> (Int,Int)
dimMataux (a,b) [] = (a,b)
dimMataux (a,b) (x:xs) = dimMataux (a,b+1) xs 

-- esta ta mal porque no escolhe n t, é uma lista de listas e n uma lista
transposta :: Mat a -> Mat a 
transposta [] = []
transposta (h:t) = aux 0 (h:t) 

aux :: Int -> Mat a -> Mat a 
aux _ [] = []
aux n (h:t) = (escolhe n h : escolhe n t) : aux (n+1) (h:t) 

escolhe :: Int -> [Int] -> Int 
escolhe n (h:t) | n == 0 = h 
                | n > 0 = escolhe (n-1) t -}

transposta :: Mat a -> Mat a 
transposta [] = []
transposta ([]:_) = []
transposta m = (map head m) : transposta (map tail m)

--Elas estao distribuidas por linhas só que nos queremos as linhas da primeira e as colunas da segunda, então na segunda fazemos a transposta
produto ::Num a => Mat a -> Mat a -> Mat a 
produto x y = let m1 = x 
                  m2 = transposta y 
                  in [[sum (zipWith (*) linha coluna) | coluna <- m2] | linha <- m1 ]