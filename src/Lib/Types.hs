module Lib.Types where



import qualified Data.Vector as V

-- * Types

data Input a = Input {
  ncolsX :: Int,
  nrowsY :: Int,
  nticks :: Int,
  inputData :: V.Vector (Maybe [a]) } deriving (Eq, Show)
