import System.IO
import System.Environment.Blank (getArgs)

main :: IO ()
main = do
    [f1, f2, charStr] <- getArgs

    let char = head charStr

    contents <- readFile f1

    writeFile f2 (map (\ch -> if ch `elem` [',', '.', '?', '!', ':', ';', '\'', '"'] then char else ch )contents)
