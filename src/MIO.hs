{-# LANGUAGE GADTs #-}
{-# LANGUAGE QualifiedDo #-}
module MIO where

import Prelude hiding ((>>=), return)
import GHC.Base (bindIO)

{-
IO a
GHC.Prim.RealWorld -> (GHC.Prim.RealWorld, a #))
-}

-- GADT syntax allows to restrict the types of constructed values e.g. `MIO String`
data MIO a where

    -- No operation
    Pure :: a -> MIO a

    -- Primitives
    ReadLine :: MIO String
    WriteLine :: String -> MIO ()

    -- AndThen models the sequence of MIO actions
    AndThen :: MIO a -> (a -> MIO b) -> MIO b

prog :: MIO ()
prog = ReadLine `AndThen` \l ->
       WriteLine l

(>>=) :: MIO a -> (a -> MIO b) -> MIO b
(>>=) = AndThen

easyProgDesugared :: MIO ()
easyProgDesugared = 
    ReadLine >>= \l ->
    WriteLine l

easyProg :: MIO ()
easyProg = MIO.do
    s <- ReadLine
    WriteLine s

-- Translate MIO to Haskell IO which the RTS can execute.
interp :: MIO a -> IO a
interp (Pure a) = pure a
interp ReadLine = getLine
interp (WriteLine l) = putStrLn l
interp (AndThen mioa f) = interp mioa `bindIO` (\a -> interp (f a))

main :: IO ()
main = interp prog
