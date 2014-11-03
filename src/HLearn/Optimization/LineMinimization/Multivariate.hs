{-# LANGUAGE DataKinds,RebindableSyntax #-}
module HLearn.Optimization.LineMinimization.Multivariate
    (
    MultivariateLineSearch

    -- * Univariate wrappers
    , lineSearchBrent

    -- * Unsafe line minimization
    , Backtracking (..)
    , backtracking

    -- ** stopping conditions
    , wolfe
    , amijo
    , weakCurvature
    , strongCurvature
    )
    where

import SubHask

import HLearn.History
import HLearn.Optimization.Common
import HLearn.Optimization.LineMinimization.Univariate

-------------------------------------------------------------------------------
-- backtracking

data Backtracking v = Backtracking
    { _bt_x     :: !(Scalar v)
    , _bt_fx    :: !(Scalar v)
    , _bt_f'x   :: !v

    , _init_dir :: !v
    , _init_f'x :: !v
    , _init_fx  :: !(Scalar v)
    , _init_x   :: !v
    }
    deriving (Typeable)
makeLenses ''Backtracking

-- instance (IsScalar (Scalar v), ValidTensor1 v) => Has_x1 Backtracking v where x1 = bt_x
-- instance (IsScalar (Scalar v), ValidTensor1 v) => Has_fx1 Backtracking v where fx1 = bt_fx

-- | Backtracking linesearch is NOT guaranteed to converge.
-- It is frequently used as the linesearch for multidimensional problems.
-- In this case, the overall minimization problem can converge significantly  
-- faster than if one of the safer methods is used.
backtracking :: 
    ( InnerProductSpace v
    , Normed (Scalar v)
    , Ord (Scalar v)
    , HistoryMonad m
    , Reportable m (Backtracking v)
    ) => StopCondition m (Backtracking v) 
      -> MultivariateLineSearch m v
backtracking stops f f' x0 f'x0 stepGuess = {-# SCC backtracking #-} do
    let g y = {-# backtracking_g #-} f $ x0 + y *. f'x0
    let grow=2.1

    fmap _bt_x $ optimize (step_backtracking 0.5 f f')
        (Backtracking
            { _bt_x = (grow*stepGuess)
            , _bt_fx = g (grow*stepGuess)
            , _bt_f'x = grow *. (f' $ x0 + grow*stepGuess *. f'x0)
            , _init_dir = f'x0
            , _init_x = x0
            , _init_fx = f x0
            , _init_f'x = f'x0
            })
        stops

step_backtracking :: 
    ( Module v
    , HistoryMonad m
    ) => Scalar v 
      -> (v -> Scalar v) 
      -> (v -> v)
      -> Backtracking v 
      -> m (Backtracking v)
step_backtracking !tao !f !f' !bt = {-# SCC step_backtracking #-} do
    let x1 = tao * _bt_x bt
    return $ bt
        { _bt_x = x1
        , _bt_fx = g x1
        , _bt_f'x = g' x1
        }
    where
        g alpha = f $ _init_x bt + alpha *. _init_dir bt
        g' alpha = alpha *. f' (_init_x bt + alpha *. _init_dir bt)

---------------------------------------
-- stop conditions

{-# INLINABLE wolfe #-}
wolfe :: 
    ( InnerProductSpace v
    , Normed (Scalar v)
    , Ord (Scalar v)
    , HistoryMonad m
    ) => Scalar v -> Scalar v -> StopCondition m (Backtracking v)
wolfe !c1 !c2 !bt0 !bt1 = {-# SCC wolfe #-} do
    a <- amijo c1 bt0 bt1
    b <- strongCurvature c2 bt0 bt1
    return $ a && b

{-# INLINABLE amijo #-}
amijo :: 
    ( InnerProductSpace v
    , Ord (Scalar v)
    , HistoryMonad m
    ) => Scalar v -> StopCondition m (Backtracking v)
amijo !c1 _ !bt = {-# SCC amijo #-} return $ 
    _bt_fx bt <= _init_fx bt + c1 * (_bt_x bt) * ((_init_f'x bt) <> (_init_dir bt))

{-# INLINABLE weakCurvature #-}
weakCurvature :: 
    ( InnerProductSpace v
    , Ord (Scalar v)
    , HistoryMonad m
    ) => Scalar v -> StopCondition m (Backtracking v)
weakCurvature !c2 _ !bt = {-# SCC weakCurvature #-} return $ 
    _init_dir bt <> _bt_f'x bt >= c2 * (_init_dir bt <> _init_f'x bt)

{-# INLINABLE strongCurvature #-}
strongCurvature :: 
    ( InnerProductSpace v
    , Ord (Scalar v)
    , Normed (Scalar v)
    , HistoryMonad m
    ) => Scalar v -> StopCondition m (Backtracking v)
strongCurvature !c2 _ !bt = {-# SCC strongCurvature #-} return $ 
    abs (_init_dir bt <> _bt_f'x bt) <= c2 * abs (_init_dir bt <> _init_f'x bt)


-------------------------------------------------------------------------------

-- | determine how far to go in a particular direction
type MultivariateLineSearch m v = 
    (v -> Scalar v) -> (v -> v) -> v -> v -> Scalar v -> m (Scalar v)

-- lineSearchBrent ::
--     ( InnerProductSpace v
--     , HistoryMonad m
--     , Reportable m (Scalar v)
--     , Reportable m (LineBracket (Scalar v))
--     , Reportable m (Brent (Scalar v))
--     ) => StopCondition m (Brent (Scalar v))
--       -> MultivariateLineSearch m v
lineSearchBrent !stops !f _ !x0 !f'x0 !stepGuess = {-# SCC lineSearchBrent #-} do
    let g y = f $ x0 + y *. f'x0
    bracket <- lineBracket g (stepGuess/2) (stepGuess*2)
    brent <- brent g bracket stops
    return $ _x brent
