--ghc 8.0.2
import LWModule

import Data.Set as Set

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
