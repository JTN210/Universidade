
 --1
 data ExpInt = Const Int
             | Simetrico ExpInt
             | Mais ExpInt ExpInt
             | Menos ExpInt ExpInt
             | Mult ExpInt ExpInt

calcula :: ExpInt -> Int
calcula Const x = x 
calcula Simetrico x = (-1) * calcula x 
calcula (Mais e1 e2) = calcula e1 + calcula e2 
calcula (Menos e1 e2) = calcula e1 - calcula e2
calcula (Mult e1 e2) = calcula e1 * calcula e2 

infixa :: ExpInt -> String
infixa Const x = show x
infixa Simetrico x = "-" ++ infixa x 
infixa (Mais e1 e2) = "(" ++ infixa e1 "+" infixa e2 ")"
infixa (Menos e1 e2) = "(" ++ infixa e1 "-" infixa e2 ")"
infixa (Mult e1 e2) = "(" ++ infixa e1 "*" infixa e2 ")"

-- TPC
type Exp = [Parcela]
type Parcela = [Factores]
type Factores = Int 

normaliza :: ExpInt -> Int 





data RTree a = R a [RTree a]

soma :: Num a => RTree a -> a 
soma (R x []) = x
soma (R x (h:t)) = (soma h) + soma (R x t)

-- com função aux com acc
somaaux acc [] = acc 
somaaux acc ((R x l ):t ) = somaaux (acc + x) (l ++ t)

altura :: RTree a -> Int
altura R a [] = 1
altura R a l = 1 + maximum(map altura l)

prune :: Int -> RTree a -> RTree a
prune 1 (R x l) = R x []
prune n (R x l)  = (R x (map (prune n-1) l) )

mirror :: RTree a -> RTree a
mirror (R x l) = R x (map mirror ( reverse l))

--3
data BTree a = Empty | Node a (BTree a) (BTree a)

data LTree a = Tip a | Fork (LTree a) (LTree a)

{-           Fork
            /    \
          Fork    Tip 5
         /    \
      Tip 3  Tip 4      
-}

ltSum :: Num a => LTree a -> a
ltSum (Tip x) = x 
ltSum (Fork x y) | ltSum x + ltSum y

listaLT :: LTree a -> [a]
listaLT (Tip x) = [x]
listaLT (Fork x y) = listaLT x ++ listaLT y


ltHeight :: LTree a -> Int
ltHeight (Tip x) = 1
ltHeight (Fork x y) = 1 + max (ltHeight x)  (ltHeight y)  

--4 
data BTree a = Empty | Node a (BTree a) (BTree a)
    deriving Show

data LTree a = Tip a | Fork (LTree a) (LTree a)
    deriving Show

data FTree a b = Leaf b | No a (FTree a b) (FTree a b)
    deriving Show

-- Função para dividir uma FTree em uma BTree e uma LTree
splitFTree :: FTree a b -> (BTree a, LTree b)
splitFTree (Leaf x) = (Empty, Tip x)
splitFTree (No a e d) = 
    let (be, le) = splitFTree e 
        (bd, ld) = splitFTree d
    in (Node a be bd, Fork le ld)

-- Exemplo de uma FTree
exampleFTree :: FTree Char Int
exampleFTree = No 'A'
                (No 'B'
                    (Leaf 3)
                    (Leaf 4)
                )
                (Leaf 5)

-- Função principal para imprimir as árvores resultantes
main :: IO ()
main = do
    putStrLn "Árvore binária rotulada com dois tipos (FTree):"
    print exampleFTree
    let (bTree, lTree) = splitFTree exampleFTree
    putStrLn "Árvore BTree resultante:"
    print bTree
    putStrLn "Árvore LTree resultante:"
    print lTree



joinTrees :: BTree a -> LTree b -> Maybe (FTree a b)
joinTrees