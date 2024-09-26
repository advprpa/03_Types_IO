data Person (f :: * -> *) 
    = MkPerson { nr :: Int, name :: f String, email :: f String }

a :: Person Maybe
a = MkPerson 12 (Just "Daniel") Nothing

b :: Person []
b = MkPerson 13 ["Peter", "Daniel"] []

data ValidationError = BadName | BadEmail
c :: Person (Either ValidationError)
c = MkPerson 13 (Right "Daniel") (Left BadEmail)

newtype Id a = Id a
d :: Person Id
d = MkPerson 12 (Id "Daniel") (Id "dk@bla.ch")
