



data Frac = F Integer Integer

normaliza :: Frac -> Frac
-- normaliza (F x y) = (F div (abs x  mdc x y) div (abs y mdc x y)) ta a dar erro 

                = let mx = abs x
                        my = abs y 
                        s = signum (x * y)
                        d = mdc mx my
                    in  F ( (s * (div mx d) (div my d)) ) 
mdc :: Integer -> Integer -> Integer
mdc 0 x = x
mdc x 0 = x
mdc x y | x > y = mdc (mod x y) y
        | otherwise = mdc x (mod y x)

{- intORD :: Ord a => [a] -> [a] -> [a]
intORD [] _ = []
intORD _ [] = []
intORD (x:xs) (y:ys) | x == y = x : intORD xs ys 
                     | x > y  =  intORD x ys 
                     | otherwise = intORD xs (y:ys)
 -}



 -- DEFINIR COM A CLASSE EQ == 

instance Eq Frac where
(==) :: Frac -> Frac -> Bool
 (F x y) == (F a b) = (x * b) == (y * a)


-- DEFINIR COM A CLASSE ORD <= 
instance Ord Frac where
 (<=) :: Frac -> Frac -> Bool

 a <= b = 
          let (F x y) = normaliza a
              (F w z) = normaliza b 
          in  x * w <= z * y 


-- DEFINIR COM A CLASSE SHOW 
instance show Frac where
show :: Frac -> String
show (F n d) = show n ++ "/" ++ show d

--DEFINIR COM A CLASSE NUM 
-- usas o negate o ou -, negate é o simetrico
class (Eq a, Show a) => Num a where
(+), (*), (-) :: a -> a -> a
negate, abs, signum :: a -> a
fromInteger :: Integer -> a


(+) :: Frac -> Frac -> Frac 
(+) (F x y) + (F a b) =  (F (x*b + (a*y)) (y*b))

(*) :: Frac -> Frac -> Frac 
(*) (F x y) * (F a b) = (x*b) + (a*y)

(negate) :: Frac -> Frac
negate (F x y) = (F (negate x) y)

signum :: Frac -> Frac
signum (F x y) = F signum ( x * y) 1

abs :: Frac -> Frac 
abs (F x y) = F (abs x) ( abs y)


fromInteger :: Integer -> a
fromInteger x =  F (fromInteger x) 1 


