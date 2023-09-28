{-# LANGUAGE TypeFamilies, KindSignatures #-}

data Identity a = Identity a

type family Unwrap (f :: * -> *) (a :: *) :: * where
  Unwrap Identity a = a
  Unwrap f a = f a  -- default case

data Person (f :: * -> *) = MkPerson { nr :: Int, name :: Unwrap f String, email :: Unwrap f String }

a :: Person Maybe
a = MkPerson 12 (Just "Daniel") Nothing

b :: Person []
b = MkPerson 13 ["Peter", "Daniel"] []

c :: Person Identity
c = MkPerson 12 "Daniel" "dk@bla.ch"
