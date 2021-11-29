import Data.Char
import Data.List
import Data.Map as Map
import Data.Maybe as Maybe


-- #1
elemIndices :: (Eq a) => a -> [a] -> [Int]
elemIndices _ [] = []
elemIndices a list = elemIndicesWithCurrentIndex a list 0

elemIndicesWithCurrentIndex :: (Eq a) => a -> [a] -> Int -> [Int]
elemIndicesWithCurrentIndex _ [] _ = []
elemIndicesWithCurrentIndex a (x:xs) index = if a == x then index : elemIndicesWithCurrentIndex a xs (index + 1) else elemIndicesWithCurrentIndex a xs (index + 1)

-- #2
unevenHandWritingMy :: String -> String
unevenHandWritingMy [] = ""
unevenHandWritingMy x = unevenHandWritingMyWithCurrentIndex x 0

unevenHandWritingMyWithCurrentIndex :: String -> Int -> String
unevenHandWritingMyWithCurrentIndex [] _ = ""
unevenHandWritingMyWithCurrentIndex (x:xs) index = if index `mod` 3 == 0 then (switchCase x) : unevenHandWritingMyWithCurrentIndex xs (index + 1) else x : unevenHandWritingMyWithCurrentIndex xs (index + 1)

switchCase :: Char -> Char
switchCase x = if isUpper x then toLower x else toUpper x

-- #3

powLists :: Int -> Int -> [[Int]]
powLists 0 _ = []
powLists _ 0 = []
powLists count maxNumber = [makePowList x | x <- [1 .. maxNumber]]
    where
        makePowList = \x -> [x ^ pow | pow <- [1 .. count]]

Импортируем скриптом из learn_platform
-- #4

transpose :: [[a]]-> [[a]]
transpose [] = []
transpose lists = [takeFromEachListAt elemIndex lists | elemIndex <- [0 .. length lists] ]
    where
        takeFromEachListAt = \index lists -> [ list !! index | list <- lists ]


-- #5

countWords :: [String] -> Map String Int
countWords [] = Map.empty
countWords words = countWordsWithMap words Map.empty

countWordsWithMap :: [String] -> Map String Int -> Map String Int
countWordsWithMap [] m = m
countWordsWithMap (word:words) resultMap =
    if Map.member word resultMap
        then do
            let wordCount = Maybe.fromJust (Map.lookup word resultMap)

            countWordsWithMap words ( Map.insert word (wordCount + 1) resultMap )
        else
            countWordsWithMap words ( Map.insert word 1 resultMap )

prepareWordsRecords :: (String, Int) -> String
prepareWordsRecords (word, count) = word ++ ":" ++ ( show count )

main :: IO ()
main = do

    let inputFile = "in.txt"
    let outputFile = "out.txt"

    contents <- readFile inputFile

    -- Split file contens to separate words
    let words = List.words contents

    let wordsCountMap = countWords words

    let sortedWordsByCount = sortBy ( \(_, a) (_, b) -> not compare b a ) ( Map.toList wordsCountMap )

    let record = List.intercalate " " (List.map prepareWordsRecords sortedWordsByCount)

    writeFile outputFile record
