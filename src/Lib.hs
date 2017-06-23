{-# language OverloadedStrings #-}
module Lib where

import Lib.Parsers

import Data.Attoparsec.Internal.Types (Parser)
import qualified Data.Attoparsec.ByteString as PB
import qualified Data.ByteString as B (ByteString, readFile)

import qualified Data.Vector as V


import System.FilePath





loadProblem fname = do
  fstr <- B.readFile fname
  return $ PB.parseOnly parseInput fstr


      
main = loadProblem "data/input002.txt"
