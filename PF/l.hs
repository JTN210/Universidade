import Data.Char
import Data.List

data BTree a = Empty
             | Node a (BTree a) (BTree a)
    deriving Show


minSmin :: Ord a => BTree a -> (a,BTree a)

minSmin (Node r e d) = aux (r,Empty) (Node r e d) 

aux :: Ord a => (a, BTree a) -> BTree a -> (a,BTree a)
aux (a,b) Empty = (a,b)
aux (a,b) (Node r Empty d) = (r,b) 
aux (a,b) (Node r e d) = aux (a,b) e









exampleTree :: BTree Int
exampleTree = Node 10
                (Node 5
                    (Node 3 Empty Empty)
                    (Node 7 Empty Empty)
                )
                (Node 15
                    (Node 12 Empty Empty)
                    (Node 18 Empty Empty)
                )






main :: IO ()
main = do
    putStrLn "Árvore binária de busca inicial:"
    print exampleTree
    putStrLn "Inserindo o valor 6 na árvore:"
    let newTree = minSmin  exampleTree
    print newTree