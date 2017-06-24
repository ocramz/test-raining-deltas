{-# language OverloadedStrings #-}
module Lib where

import Lib.Parsers
import Lib.Types

import Control.Monad.State.Strict

-- import Data.Attoparsec.Internal.Types (Parser)
import qualified Data.Attoparsec.ByteString as PB
import qualified Data.ByteString as B (readFile)

import qualified Data.Vector as V
import System.Random.MWC(Gen, uniformR)
import Control.Monad.Primitive


-- import System.FilePath




loadProblem :: FilePath -> IO (Either String (Input Int))
loadProblem fname = do
  fstr <- B.readFile fname
  return $ PB.parseOnly parseInput fstr


checkInput :: Input a -> Bool
checkInput inp = V.length (inputData inp) == nticks inp
      

observableState :: Input a -> Int -> V.Vector (Maybe (V.Vector a))
observableState inp t
  | t <= tmax = V.take t (inputData inp)
  | otherwise = error $ unwords ["observableState: t must be smaller than", show tmax] where
      tmax = nticks inp
    

-- Pick an element out of a Vector uniformly at random 
choose :: PrimMonad m => Gen (PrimState m) -> V.Vector b -> m b        
choose g v = do 
  i <- uniformR (0, V.length v) g
  return $ v V.! i


-- Pick a starting position uniformly at random
startingPosition :: PrimMonad m => Gen (PrimState m) -> Input b -> Maybe (m b)
startingPosition g inp = choose g <$> obs0 where
  obs0 = observableState inp 0 V.! 0
