{-# language OverloadedStrings #-}
module Lib where

import Lib.Parsers
import Lib.Types

import Control.Monad.State.Strict

-- import Data.Attoparsec.Internal.Types (Parser)
import qualified Data.Attoparsec.ByteString as PB
import qualified Data.ByteString as B (readFile)

import qualified Data.Vector as V
import Data.Vector.Algorithms.Merge (sort)
import System.Random.MWC(Gen, uniformR)
import Control.Monad.Primitive


-- import System.FilePath




loadProblem :: FilePath -> IO (Either String (Input Int))
loadProblem fname = do
  fstr <- B.readFile fname
  return $ PB.parseOnly parseInput fstr








  

      

observableState :: Input a -> Int -> V.Vector (Maybe (V.Vector a))
observableState inp t
  | t <= tmax = V.take t (inputData inp)
  | otherwise = error $ unwords ["observableState: t must be smaller than", show tmax] where
      tmax = nticks inp
   

-- Pick a starting position uniformly at random
startingPosition :: PrimMonad m => Gen (PrimState m) -> Input a -> Maybe (m a)
startingPosition g inp = choose g <$> obs0 where
  obs0 = observableState inp 0 V.! 0



-- * Regression

-- | Smallest regression coefficient between v0 and the elements of vec
regressLinear :: (Num t, PrimMonad m, Ord t) => t -> V.Vector t -> m t
regressLinear v0 vec = do
  let vdiff = V.map (subtract v0) vec
  vdiffSorted <- sortedV vdiff
  return $ V.head vdiffSorted
  



-- * Helpers

-- | Is the parsed input data consistent?
checkInput :: Input a -> Bool
checkInput inp = V.length (inputData inp) == nticks inp



  


-- Pick an element out of a Vector uniformly at random 
choose :: PrimMonad m => Gen (PrimState m) -> V.Vector a -> m a
choose g v = do 
  i <- uniformR (0, V.length v) g
  return $ v V.! i

sortedV :: (Ord a, PrimMonad m) => V.Vector a -> m (V.Vector a)
sortedV v = do
  vm <- V.thaw v
  sort vm
  V.freeze vm
