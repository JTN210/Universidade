
fromDigits :: [Int] -> Int
fromDigits l = fst $ foldr (\curr (a,b) -> (a+curr*10^b,b+1) ) (0,0) l
