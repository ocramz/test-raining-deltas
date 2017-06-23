{-# language OverloadedStrings #-}
module Lib.Parsers where

import Control.Applicative ((<|>))

import Data.Attoparsec.Internal.Types (Parser)
import qualified Data.Attoparsec.ByteString as PB
import Data.Attoparsec.ByteString.Char8 (decimal, space, char, endOfLine, endOfInput)
import qualified Data.ByteString as B (ByteString, readFile)

import qualified Data.Vector as V

-- * Types

data Input a = Input {
  ncolsX :: Int,
  nrowsY :: Int,
  nticks :: Int,
  inputData :: V.Vector a } deriving (Eq, Show)

-- * Parsers

parseHeader :: Parser B.ByteString (Int, Int, Int)
parseHeader = (,,) <$>
  (decimal <* space) <*>
  (decimal <* endOfLine) <*>
  (decimal <* endOfLine)

parseLine :: Parser B.ByteString (Maybe [Int])
parseLine = deltas <|> tick where
  deltas = do
    js <- PB.sepBy decimal space
    return $ Just js
  tick = char '-' >> return Nothing
  

-- parseInput :: Parser B.ByteString (Input (Maybe [Int]))
parseInput = do
  (x, y, n) <- parseHeader
  ii <- PB.sepBy parseLine endOfLine <* endOfInput
  return $ Input x y n (V.fromList ii)

