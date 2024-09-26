main :: IO ()
main = do 
    content <- readFile "in.txt"
    writeFile "out.txt" content
