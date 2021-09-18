--ghc 8.0.2
-- #0
doMyList :: Int-> [Int]
doMyList x = [x .. x * 2 -1]

-- #1
oddEven :: [a] -> [a]
oddEven [] = []
oddEven [x] = [x]
oddEven (x:y:z) = [ y, x ] ++ oddEven z

-- #2
rearTake :: Int -> [a] -> [a]
rearTake pos list = reverse ( take pos (reverse  list) )

insert :: [a] -> a -> Int -> [a]
insert list x pos = take pos list ++ [x] ++ rearTake (length list - pos - 1) list

-- #3
listSumm :: (Num a) => [a] -> [a] -> [a]
listSumm l1 l2
    | null l1 = []
    | null l2 = []
    | otherwise = (head l1 + head l2): listSumm (tail(l1)) (tail(l2))

-- #4
position :: (Eq a) => [a] -> a -> Int
position [] _ = error "no element found"
position (x:xs) a = if x == a then 0 else 1 + position xs a

-- #5
summSimple :: Int -> Int
summSimple 0 = 0
summSimple n = sum [1..n]

-- #6
summMedium :: Int -> Int
summMedium 0 = 0
summMedium n = sum(init [1..n - 1])


main :: IO ()
main = do
    -- #0
    print ( doMyList 4 )

    -- #1
    print(oddEven[5, 2, 4, 3])

    -- #2
    print(insert [5, 2, 4, 3, 1, 7, 6] 10 3 )

    -- #3
    print(listSumm [100, 3] [5] )

    -- #4
    print(position [1, 3, 1] 1)

    -- #5
    print(summSimple 4)

    -- #6
    print(summMedium 4)
