--ghc 8.0.2
import LWModule

import Data.Set as Set
import Data.Map as Map
import Data.Tuple as Tuple

-- Data.List - intersperse
-- Data.Char - toUpper
-- Data.Map - deleteAt
-- Data.Map - mapMaybe
-- Data.Set - filter

main :: IO ()
main = do
    -- List
    print( LWModule.intersperse '.' "STALKER" )

    -- Set
    let specialSet = Set.fromList [1, 2, 3]

    print( LWModule.filter (== 3) specialSet )

    -- Char
    print( LWModule.toUpper 'a' )

    print( LWModule.toUpper 'W' )

    print( LWModule.toUpper '#' )

    -- Map
    let specialMap = Map.insert 2 "b" $ Map.singleton 1 "a"

    print $ LWModule.deleteAt 1 specialMap

    let f x = if x == "a" then Just "new a" else Nothing
    print $ LWModule.mapMaybe f (Map.fromList [(5,"a"), (3,"b")])
