import System.Environment ( getArgs )
import Data.List ( intercalate )

main :: IO ()
main = do 
    args <- getArgs
    putStrLn (intercalate "\n" args)