



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


--2
data Exp a = Const a
           | Simetrico (Exp a)
           | Mais (Exp a) (Exp a)
           | Menos (Exp a) (Exp a)
           | Mult (Exp a) (Exp a)


instance show Exp  where
show :: Exp a -> String
show (Const a) = show a 
show (Simetrico x) = "-" ++ show x
show (Mais e1 e2) = "(" ++ show e1 ++ " + " ++ show e2 ++ ")"
show (Menos e1 e2) = "(" ++ show e1 ++ " - " ++ show e2 ++ ")"
show (Mult e1 e2) = "(" ++ show e1 ++ " * " ++ show e2 ++ ")"


instance Eq Exp a where
(==) :: Exp a -> Exp a -> Bool
 (Const a) == (Const b) = a == b
(Simetrico x) == (Simetrico y) = x == y
(Mais e1 e2) == (Mais e1' e2') = e1 == e1' && e2 == e2'
(Menos e1 e2) == (Menos e1' e2') = e1 == e1' && e2 == e2'
(Mult e1 e2) == (Mult e1' e2') = e1 == e1' && e2 == e2'
_ == _ = False

class (Eq a, Show a) => Num a where
(+), (*), (-) :: a -> a -> a
negate, abs, signum :: a -> a
fromInteger :: Integer -> a

instance Num a => Num (Exp a) where
(+) e1 e2 = Mais e1 e2          -- Soma
(-) e1 e2 = Menos e1 e2         -- Subtração
(*) e1 e2 = Mult e1 e2          -- Multiplicação
negate e = Simetrico e          -- Negativo
abs e = e                       -- Mantém a expressão (abs é arbitrário aqui)
signum e = e                    -- Mantém a expressão (signum é arbitrário aqui)
fromInteger n = Const (fromInteger n) -- Constantes a partir de inteiros



--3
data Movimento = Credito Float | Debito Float
data Data = D Int Int Int
data Extracto = Ext Float [(Data, String, Movimento)]

instance Ord Data where
(<=) :: Data -> Data -> Bool
--2024 12 12       2024 12 13
 (D a1 m1 d1) <= (D a2 m2 d2) | a1 == a2 && m1 == m2 && d1 <= d2 = True
                              | a1 == a2 && m1 < m2 = True 
                              | a1 < a2 = True
                              | otherwise = False 
                            

instance Show Data where
show :: Data -> String
show (D x y z) show x ++ "/" ++ show y ++ "/" ++ show z


ordena :: Extracto -> Extracto
ordena (Ext saldo movimentos) = Ext saldo (insertionSort movimentos)
  where
    insertionSort :: [(Data, String, Movimento)] -> [(Data, String, Movimento)]
    insertionSort [] = []
    insertionSort (x:xs) = insere x (insertionSort xs)

    insere :: (Data, String, Movimento) -> [(Data, String, Movimento)] -> [(Data, String, Movimento)]
    insere x [] = [x]
    insere x (y:ys)
      | fst3 x <= fst3 y = x : y : ys
      | otherwise = y : insere x ys

    fst3 (a, _, _) = a