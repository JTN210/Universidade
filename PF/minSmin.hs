data BTree a = Empty
             | Node a (BTree a) (BTree a)
             deriving Show


{- minSmin :: Ord a => BTree a -> (a,BTree a)
minSmin Node r Empty Empty = (r, Empty)
minSmin Node r Empty d = (r, d)
minSmin Node r e d = aux (r,Node R e d) Node r e d

aux :: (a, BTree a) -> Ord a => BTree a -> (a,BTree a)
aux (a,b) Empty = (a,b)
aux (a,b) (Node r e d) = (Node (Node r e d) d ) 
 -}




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
minSmin (Node r e d) = 
                        let 
                            (res, t) = minSmin e

                        in  (res, Node r t d)



main :: IO ()
main = do
    let result = minSmin exampleBST
    print result