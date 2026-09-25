
type MSet a = [(a, Int)]

uniaoMSet :: Eq a => MSet a -> MSet a -> MSet a
uniaoMSet [] mset2 = mset2  
uniaoMSet mset1 [] = mset1 
uniaoMSet ((x,xs):t) ((y,ys):z) | x == y = (x,xs + ys) : uniaoMSet t z
                                | x != y = uniaoMSet (x,xs) z ++ uniaoMSet (y,ys) t 
                    

func :: Float -> [(Float,Float)] -> [Float]
func x y = aux [] x y

aux :: [Float] -> Float -> [(Float,Float)] -> [Float]
aux n x [] = n 
aux n x ((a,b):t) | x > a = aux n x t 
                  | otherwise = aux (n:b) x t 
