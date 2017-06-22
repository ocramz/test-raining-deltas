module Lib where

import Data.Attoparsec.Internal.Types (Parser)
import qualified Data.Attoparsec.ByteString as PB
import Data.Attoparsec.ByteString.Char8 (decimal, signed, scientific, digit, number, rational, char, char8, endOfLine, endOfInput, isDigit, isDigit_w8, isEndOfLine, isHorizontalSpace)
import qualified Data.ByteString as B (ByteString, readFile)

import System.FilePath
