import Data.Char
import Data.List

data BTree a = Empty
             | Node a (BTree a) (BTree a)
             deriving Show


 minSmin :: Ord a => BTree a -> (a,BTree a)
minSmin Node r Empty Empty = (r, Empty)
minSmin Node r Empty d = (r, d)
minSmin Node r e d = aux (r,Node R e d) Node r e d

aux :: Ord a => (a, BTree a) -> BTree a -> (a,BTree a)
aux (a,b) Empty = (a,b)
aux (a,b) (Node r Empty d) = (r,b) 
aux (a,b) (Node r e d) = aux (a,b) e

-- aux (a,b) (Node r e d) = (Node (Node r e d) d ) 



----
exampleBST :: BTree Int
exampleBST = Node 10 
                (Node 5 
                    (Node 2 Empty Empty) 
                    (Node 7 Empty Empty)
                ) 
                (Node 15 
                    (Node 12 Empty Empty) 
                    (Node 20 Empty Empty)
                )

minSmin :: Ord a => BTree a -> (a,BTree a)
minSmin (Node r Empty d) = (r, d)
minSmin (Node r (Node re Empty de) d) = (re, Node r de d)
minSmin (Node r (Node re ee de) d) = 
                        let 
                            (res, t) = minSmin (Node re ee de)

                        in  (res, Node r t d)



main :: IO ()
main = do
    putStrLn "Árvore binária de busca inicial:"
    print exampleTree
    putStrLn "Inserindo o valor 6 na árvore:"
    let newTree = minSmin  exampleTree
    print newTree
