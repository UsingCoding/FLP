module LWModule (intersperse) where

intersperse :: a -> [a] -> [a]
intersperse _ [] = []
intersperse _ [x] = [x]
intersperse x list = head list : x : intersperse x (tail list)
