import System.IO
import System.Environment.Blank (getArgs)

main :: IO ()
main = do
    [beginStr, countStr, multiplicityStr] <- getArgs

    let begin = read beginStr :: Integer
    print begin

    let count = read countStr :: Integer
    print count

    let multiplicity = read multiplicityStr :: Integer
    print multiplicity

    print( filter (\x -> mod x multiplicity == 0 ) [begin..(multiplicity * count) + multiplicity])
