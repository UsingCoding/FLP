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
intersperse :: a -> [a] -> [a]
intersperse _ [] = []
intersperse _ [x] = [x]
intersperse x list = head list : x : intersperse x (tail list)

-- Set
filter :: (Ord a) => (a -> Bool) -> Set a -> Set a
filter predicate set = Set.fromList( [x | x <- Set.toList set, predicate x] )

-- Char
toUpper :: Char -> Char
toUpper ch = if ch `elem` ['a'..'z'] then chr ( ord ch - 32) else ch

-- Map
deleteAt :: (Ord k) => Int -> Map k a -> Map k a
deleteAt pos m = Map.delete (Tuple.fst $ Map.elemAt pos m) m

mapMaybe :: (Ord k) => (a -> Maybe b) -> Map k a -> Map k b
mapMaybe f m = Map.fromList [compactTuple x | x <- Map.toList m, filterNothing x]
    where
        compactTuple = \x -> (Tuple.fst x, head $ Maybe.maybeToList $ f $ Tuple.snd x)
        filterNothing = isJust . f . Tuple.snd
