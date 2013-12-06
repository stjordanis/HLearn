{-# LANGUAGE TypeOperators,DataKinds,KindSignatures,TypeFamilies,PolyKinds,UndecidableInstances #-}
import GHC.TypeLits
data Nat1 = Zero | Succ Nat1
type family Replicate1 (n :: Nat1) (x::a) :: [a]
type instance Replicate1 n x = Replicate1' n x '[]
type family Replicate1' (n :: Nat1) (x::a) (acc::[a]) :: [a]
type instance Replicate1' Zero x acc = acc
type instance Replicate1' (Succ n) x acc = Replicate1' n x (x ': acc)
class Class a where
    f :: a -> a
data Data (xs::a) = X | Y
    deriving (Read,Show)
main = print test1
instance (xs ~ Replicate1 ( Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Zero ))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) ()) => Class (Data xs) where
    f X = Y
    f Y = X
test1 = f (X :: Data ( Replicate1 ( Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Succ (  Zero ))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) () ))
