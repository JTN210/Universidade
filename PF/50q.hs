import Data.Char
import Data.List

--1 
enumFromTo :: Int -> Int ->[Int]
enumFromTo x y | x > y = []
               | otherwise = x : enumFromTo x + 1

--2
enumFromThenTo :: Int -> Int -> Int -> [Int]               
--enumFromThenTo  1 3 10 = 13 5 7 9 
enumFromThenTo start next end
    | start > end && next >= start || start < end && next < start = []
    | otherwise = start : enumFromThenTo next (2 * next - start) end

--3
(++) :: [a] -> [a] -> [a]
(++) = [] y = y
(++) = (h:t) y = h : (++) t y

--4
 (!!) :: [a] -> Int -> a
 (!!) [] _ = []
 (!!) (h:t) x | x == 0 = h
              | otherwise = (!!) t x-1

--5 
reverse :: [a] -> [a]
reverse [] = []
reverse (x:y) = (y:x)
reverse (h:t) reverse t : h

--6
take :: Int -> [a] -> [a]
take _ [] = []
take 0 _ = []
take x (h:t) = h : take (x-1) t

--7
drop :: Int -> [a] -> [a]
drop _ [] = []
drop 0 y = y 
drop x (h:t) = drop (x-1) t

--8
zip :: [a] -> [b] -> [(a,b)]
zip  [] [] = []
zip [x] [] [(x,[])]
zip [] [y] [([],y)]
zip (x:xs) (y:ys) = (x,y) : zip xs ys 

--9
replicate :: Int -> a -> [a]
replicate 0 _ = []
replicate x y = y : replicate (x-1) y

--10
intersperse :: a -> [a] -> [a]
intersperse x [] = []
intersperse x [y] = [y]
intersperse x (h:t) = h : x : intersperse x t

--11
group :: Eq a => [a] -> [[a]]
group [] = []
group (h:t) | elem h ( head group t) = (h:(head group t)) : (tail group t)
            | otherwise = [h] : group t

--12
concat :: [[a]] -> [a]
concat [[]] = []
concat [[x]] = [x]
concat (h:t) =  h ++ concat t

 --13
inits :: [a] -> [[a]]
inits [] = [[]]
inits [x] = [] : [x]
inits l = inits (init l) ++ [l]

--14
tails :: [a] -> [[a]]
tails [] = [[]]
tails [x] = [[x] : []]
tails (h:t) = (h:t) : tails t

--15
heads :: [[a]] -> [a]
heads [] = []
heads (h:t) = head h : heads t

--16
total :: [[a]] -> Int 
total [] = 0
total (h:t) = lenght h + total t

--17
fun :: [(a,b,c)] -> [(a,c)]
fun [] = []
fun ((x,y,z):t) = ((x,z)) : fun t

--18
cola :: [(String,b,c)] -> String
cola [] = []
cola ((x,y,z):t) = x ++ cola t

--19
idade :: Int -> Int -> [(Sring, Int)] -> [String]
idade _ _ [] = []
idade a b ((x,xs):t) | 
                     | (a-xs) >= b = x : idade a b t  
                     |otherwise = idade a b t 

--20
powerEnumFrom :: Int -> Int -> [Int]
powerEnumFrom x 0 = []
powerEnumFrom x 1 = [1] 
powerEnumFrom x y | powerEnumFrom x (y-1) ++ [x^(y-1)]
                  | otherwise = []

--21
isPrime :: Int -> Bool
...

--22
isPrefixOf :: Eq a => [a] -> [a] -> Bool
isPrefixOf [] _ = True
isPrefixOf _ [] = False
isPrefixOf (h:t) (h':t') | h /= h' = False 
                         | head t /= head t' = False 
                         | head t == head t' = isPrefixOf t t' 
                         | otherwise = True 

--23
isSuffixOf :: Eq a => [a] -> [a] -> Bool
isSuffixOf [] _ = True 
isSuffixOf _ [] = False
isSuffixOf (h:t) (h':t') | h == h' = False 
                         | h /= head t' = False
                         | h /= h' && h == head t' = isSuffixOf  t t'

--24
isSubsequenceOf :: Eq a => [a] -> [a] -> Bool
isSubsequenceOf [] _ = True 
isSubsequenceOf _ [] = False
isSubsequenceOf (h:t) (h':t') | h == h' && isSubsequenceOf t t' || isSubsequenceOf (h:t) t' 

--25
elemIndices :: Eq a => [a] -> [a] -> [Int]
elemIndices _ [] = []
elemIndices x (h:t) | x == h = 0 : map(+1) (elemIndices x t)
                    | otherwise = map(+1)  elemIndices x t 

--26
nub :: Eq a => [a] -> [a]
nub [] = []
nub (h:t) | h elem t =  nub t
          | otherwise = h : nub t

--27
delete :: Eq a => a -> [a] -> [a]
delete _ [] = []
delete x (h:t) | x == h = t 
               | otherwise = h : delete x t





--ja foi 50 questão 
catMaybe :: [Maybe a] -> [a]
catMaybe [] = []
catMaybe (Nothing x:t) = catMaybe t 
catMaybe (Just x :t) = x : catMaybe t 

--35
lookup :: Eq a => a -> [(a,b)] -> Maybe b
 --lookup 4 [(2,"a"),(4,"b"),(5,"c")] = Just b
lookup _ [] = Nothing 
lookup x ((y,ys):t) | x == y = Just ys
                    | otherwise = lookup x t