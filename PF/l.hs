data BTree a = Empty
             | Node a (BTree a) (BTree a)
deriving Show


minSmin :: Ord a => BTree a -> (a,BTree a)
minSmin Node r Empty Empty = (r, Empty)
minSmin Node r Empty d = (r, d)
minSmin Node r e d = aux (0,Node R e d) Node r e d

aux :: (a, BTree a) -> Ord a => BTree a -> (a,BTree a)
aux (a,b) Empty = (a,b)
aux (a,b) (Node r Empty Empty) = (r, Empty)
aux (a,b) (Node r Empty d) = (r, d) 
aux (a,b) (Node r e d) = aux (a,b) (Node e x y) aux(a,b)(Node d w z)