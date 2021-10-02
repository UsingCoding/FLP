--ghc 8.0.2
import LWModule

-- Data.List - intersperse
-- Data.Char - toUpper
-- Data.Map - deleteAt
-- Data.Map - filter
-- Data.Set - filter

main :: IO ()
main = do
    print( LWModule.intersperse '.' "STALKER" )
