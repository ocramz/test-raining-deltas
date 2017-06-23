{-# language OverloadedStrings #-}
module Lib.Parsers where

import Control.Applicative ((<|>))

import Data.Attoparsec.Internal.Types (Parser)
import qualified Data.Attoparsec.ByteString as PB
import Data.Attoparsec.ByteString.Char8 (decimal, space, char, endOfLine, endOfInput)
import qualified Data.ByteString as B (ByteString)

import qualified Data.Vector as V


parseLine :: Parser B.ByteString (V.Vector Int)
parseLine = V.fromList <$> (deltas <|> tick) where
  deltas = PB.sepBy decimal space <* endOfLine
  tick = do
    _ <- (char '-' <* endOfLine)
    return [0]


data Header = Header {
  ncolsX :: Int,
  nrowsY :: Int,
  nticks :: Int } deriving (Eq, Show)

parseHeader :: Parser B.ByteString Header
parseHeader = Header <$> (decimal <* space) <*> (decimal <* endOfLine) <*> (decimal <* endOfLine)

data Input = Input {
  header :: Header,
  inputData :: V.Vector (V.Vector Int) } deriving (Eq, Show)

parseInput :: Parser B.ByteString Input
parseInput = do
  h <- parseHeader
  ii <- PB.count (nticks h) parseLine <* endOfInput
  return $ Input h (V.fromList ii)
