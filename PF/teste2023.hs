
type MSet a = [(a, Int)]

uniaoMSet :: Eq a => MSet a -> MSet a -> MSet a
uniaoMSet [] mset2 = mset2  
uniaoMSet mset1 [] = mset1 
uniaoMSet ((x,xs):t) ((y,ys):z) | x == y = (x,xs + ys) : uniaoMSet t z
                                | x != y = uniaoMSet (x,xs) z ++ uniaoMSet (y,ys) t 
                    