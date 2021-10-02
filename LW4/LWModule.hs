module LWModule (intersperse, filter, toUpper) where

import Data.Set as Set hiding (filter)
import Data.Char as Char hiding (toUpper)
import Data.List as List hiding (intersperse, filter)

import Prelude hiding (filter)

-- List
intersperse :: a -> [a] -> [a]
intersperse _ [] = []
intersperse _ [x] = [x]
intersperse x list = head list : x : intersperse x (tail list)

-- Set
filter :: (Ord a) => (a -> Bool) -> Set a -> Set a
filter predicate set = Set.fromList( [x | x <- Set.toList set, predicate x] )


toUpper :: Char -> Char
toUpper ch = if ch `elem` ['a'..'z'] then chr ( ord ch - 32) else ch
