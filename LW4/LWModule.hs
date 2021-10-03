module LWModule (
    intersperse,
    LWModule.filter,
    toUpper,
    LWModule.deleteAt,
    LWModule.mapMaybe,
) where

import Data.Set as Set hiding (filter)
import Data.Char as Char hiding (toUpper)
import Data.List as List hiding (intersperse, filter)
import Data.Map as Map hiding (deleteAt, mapMaybe)
import Data.Tuple as Tuple
import Data.Maybe as Maybe

import Prelude hiding (filter)

-- List

-- Функция вставляет новый элемент между элементами списка

intersperse :: a -> [a] -> [a]
intersperse _ [] = []
intersperse _ [x] = [x]
intersperse x list = head list : x : intersperse x (tail list)

{-
    Примеры использования

    LWModule.intersperse '.' "STALKER" == "S.T.A.L.K.E.R"
    LWModule.intersperse 0 [1, 2, 3, 4, 5] == [1, 0, 2, 0, 3, 0, 4, 0, 5]

-}

-- Set

-- Функция фильтрации элементов в множестве по предикату

filter :: (Ord a) => (a -> Bool) -> Set a -> Set a
filter predicate set = Set.fromList( [x | x <- Set.toList set, predicate x] )

{-
    Примеры использования

    LWModule.filter (== 3) Set.fromList [1, 2, 3] == Set.fromList [3]
    LWModule.filter (> 13) Set.fromList [1, 2, 3] == Set.fromList []

-}

-- Char

-- Функция переводит переданный ей символ в верхний регистр
-- Если символ уже в верхнем регистре или не переводится в верхний регистр, как например числа и спец. символы,
-- то функция возвращает то же самое значение

toUpper :: Char -> Char
toUpper ch = if ch `elem` ['a'..'z'] then chr $ ord ch - 32 else ch

{-
    Примеры использования

    LWModule.toUpper 'a' == 'A'
    LWModule.toUpper 'W' == 'W'
    LWModule.toUpper '#' == '#'
-}

-- Map

-- Удаляет элемент из мапы по указанной позиции.
-- Если элемента нет, то кидается ошибка Error: index out of range

deleteAt :: (Ord k) => Int -> Map k a -> Map k a
deleteAt pos m = Map.delete (Tuple.fst $ Map.elemAt pos m) m

{-
    Примеры использования

    let specialMap = Map.insert 2 "b" $ Map.singleton 1 "a"

    LWModule.deleteAt 1 specialMap == Map.fromList [(1,"a")]
    LWModule.deleteAt 2 specialMap    Error: index out of range
    LWModule.deleteAt -1 specialMap    Error: index out of range

-}

-- Функция мапает значения и собирает только Just значения

mapMaybe :: (Ord k) => (a -> Maybe b) -> Map k a -> Map k b
mapMaybe f m = Map.fromList [compactTuple x | x <- Map.toList m, filterNothing x]
    where
        compactTuple = \x -> (Tuple.fst x, Maybe.fromJust $ f $ Tuple.snd x)
        filterNothing = isJust . f . Tuple.snd

{-
    Примеры использования

    let f x = if x == "a" then Just "new a" else Nothing
    LWModule.mapMaybe f (Map.fromList [(5,"a"), (3,"b")]) == Map.fromList [(5,"new a")]
-}
