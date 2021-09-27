--ghc 8.0.2 
 
-- #1 
listnums :: Int -> [Int] 
listnums 0 = [] 
listnums x = x : listnums(x - 1) 
 
-- #2 
secondlastlist :: [[a]] -> [a] 
secondlastlist [] = [] 
secondlastlist xs = last(head(xs)) : secondlastlist(tail xs) 
 
-- #3 
presentIn :: (Eq a) => [a] -> a -> Bool 
presentIn [] _ = False 
presentIn (x:xs) a = if x == a then True else presentIn xs a 
 
myunion :: (Eq a) => [a] -> [a] -> [a] 
myunion _ [] = []
myunion [] _ = []
myunion xs ys = xs ++ [x | x <- ys, not( presentIn xs x )]

-- #4
mySubst :: (Eq a) => [a] -> [a] -> [a] 
mySubst _ [] = []
mySubst [] _ = []
mySubst (x:xs) ys 
    | not( presentIn ys x ) = x : mySubst xs ys
    | otherwise = mySubst xs ys

main :: IO ()
main = do 
    -- #1 
    print(listnums 4) 
 
    -- #2 
    print( secondlastlist [[1,2,44], [1,2,2], [1,2,3]] )

    -- #3
    print( myunion [1, 2, 3] [1, 2, 4, 5] )

    -- #4
    print( mySubst [1, 2] [1, 3] )