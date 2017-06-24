{-# language OverloadedStrings #-}
module Lib.Parsers where

import Control.Applicative ((<|>))

import Data.Attoparsec.Internal.Types (Parser)
import qualified Data.Attoparsec.ByteString as PB
import Data.Attoparsec.ByteString.Char8 (decimal, char, endOfLine)
import qualified Data.ByteString as B (ByteString)

import qualified Data.Vector as V

import Lib.Types

-- * Parsers

space :: PB.Parser Char
space = char ' ' -- NB: `space` from Data.Attoparsec.ByteString.Char8 matches newlines as well

parseHeader :: Parser B.ByteString (Int, Int, Int)
parseHeader = (,,) <$>
  (decimal <* space) <*>
  (decimal <* endOfLine) <*>
  (decimal <* endOfLine)

parseLine :: Parser B.ByteString (Maybe (V.Vector Int))
parseLine = (no_dat <|> dat) <* endOfLine where
  dat = do
    js <- PB.sepBy decimal space
    pure $ Just $ V.fromList js
  no_dat = char '-' >> pure Nothing
  
parseInput :: Parser B.ByteString (Input Int)
parseInput = do
  (x, y, n) <- parseHeader
  ii <- PB.count n parseLine
  return $ Input x y n (V.fromList ii)


