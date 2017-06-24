{-# language OverloadedStrings #-}
module Lib where

import Lib.Parsers
import Lib.Types

import Control.Monad.State.Strict

-- import Data.Attoparsec.Internal.Types (Parser)
import qualified Data.Attoparsec.ByteString as PB
import qualified Data.ByteString as B (readFile)

import qualified Data.Vector as V



-- import System.FilePath




loadProblem :: FilePath -> IO (Either String (Input Int))
loadProblem fname = do
  fstr <- B.readFile fname
  return $ PB.parseOnly parseInput fstr


      

