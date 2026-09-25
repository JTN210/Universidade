data BTree a = Empty
| Node a (BTree a) (BTree a)
deriving Show

--1
altura :: BTree a -> Int 
altura Node a Empty Empty = 1 
altura node a x y = 1 + max ((altura x) (altura y) ) 

contaNodos :: BTree a -> Int
contaNodos Empty = 0 
contaNodos Node a x y = 1 + (contaNodos x) + (contaNodos y)

folhas :: BTree a -> Int
folhas Empty = 0
folhas Node a Empty Empty = 1 
folhas Node a x y = folhas x + folhas y 

prune :: Int -> BTree a -> BTree a
prune 0 _ = Empty
prune _ Empty = Empty
prune n (Node a x y) = (prune (n - 1 x)) (prune (n - 1 y))

path :: [Bool] -> BTree a -> [a]
path [] _ = []
path _ Empty = []
path (h:t) (Node a e d) | h = a : path t Node d 
                        | otherwise = a : path t Node e 

mirror :: BTree a -> BTree a
mirror Empty = Empty
mirror Node a e Empty = Node a (Empty d)
mirror Node a Empty d = Node a (e Empty)
mirror Node e d = Node a (mirror e) (Mirror d) 


minimo :: Ord a => BTree a -> a
minimo Node a Empty _ = a 
minimo Node a e _ = minimo e

semMinimo :: Ord a => BTree a -> BTree a
semMinimo Node a Empty d = d 
semMinimo Node a e d = Node a (semMinimo e) d 

minSmin :: Ord a => BTree a -> (a,BTree a)

minSmin Node r e d = aux (r,Empty) Node r e d

aux :: (a, BTree a) -> Ord a => BTree a -> (a,BTree a)
aux (a,b) Empty = (a,b)
aux (a,b) (Node r Empty d) = (r, b) 
aux (a,b) (Node r e d) = aux (a,b) e


remove :: Ord a => a -> BTree a -> BTree a

--3 
type Aluno = (Numero,Nome,Regime,Classificacao)
type Numero = Int
type Nome = String
data Regime = ORD | TE | MEL deriving Show
data Classificacao = Aprov Int
                    | Rep
                    | Faltou
deriving Show
type Turma = BTree Aluno -- ´arvore bin´aria de procura (ordenada por n´umero)


inscNum :: Numero -> Turma -> Bool
inscNum _ Empty = False
inscNum n (Node x y z w) e d | x == n = True
                             | x > n = inscNum n e 
                             | otherwise = inscNum n d 

inscNome :: Nome -> Turma -> Bool
inscNome _ Empty = False 
inscNome n (Node (x,y,z,w) e d) | n == y = True
                                | otherwise = inscNome n e || inscNome n d 

trabEst :: Turma -> [(Numero,Nome)]
trabEst Empty = Empty 
trabEst 




nota :: Numero -> Turma -> Maybe
nota _ Empty = Nothing 
nota n Node(x,y,z,w) e d | n == x = Just w 
                         | n > x = nota n d 
                         | n < x = nota n e
                         | otherwise = Nothing

percFaltas :: Turma -> Float

