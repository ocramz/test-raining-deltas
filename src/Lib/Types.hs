module Lib.Types where



import qualified Data.Vector as V

-- * Types

data Input a = Input {
  ncolsX :: Int,
  nrowsY :: Int,
  nticks :: Int,
  inputData :: V.Vector (Maybe (V.Vector a)) } deriving (Eq, Show)


newtype ObservableState a = ObsState { unObsState :: [Maybe (V.Vector a)]} deriving (Eq, Show)
