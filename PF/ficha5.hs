zipWith :: (a->b->c) -> [a] -> [b] -> [c]
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
+











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