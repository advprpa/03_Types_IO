module Optional ( 
  OptInt, -- Export the type, but _not_ the value constructors Value, Empty
  create, -- Export all functions to work with OptInt values
  empty,
  foldOptInt
) where

data OptInt = Value Int | Empty

create :: Int -> OptInt
create i = Value i

empty :: OptInt
empty = Empty

foldOptInt:: (Int -> a) -> a -> OptInt -> a
foldOptInt f _ (Value i) = f i
foldOptInt _ d Empty     = d


-- Alternative implementation based on Maybe.
{-
module Optional (
  OptInt,
  create, 
  empty, 
  foldOptInt
) where

data OptInt = OptIntImpl (Maybe Int)

create :: Int -> OptInt
create i = OptIntImpl (Just i)

empty :: OptInt
empty = OptIntImpl Nothing

foldOptInt:: (Int -> a) -> a -> OptInt -> a
foldOptInt f d (OptIntImpl mi) = maybe d f mi
-}

