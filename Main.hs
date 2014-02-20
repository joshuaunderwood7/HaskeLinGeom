module Main where

import System.Environment
import Control.Exception as EX
import Data.Char (toUpper)
import qualified Data.Vector as V
import Board
import Piece
import DistanceTables



strToLocation [] = []
strToLocation str = do
    let x = read (head str) :: Int
    let y = read ( head (drop 1 str) ) :: Int
    (x, y) : strToLocation (drop 3 str)

-- runghc Main.hs "Queen" Black Queen 8 8 1 4 4 1 8 1 1 3 2 1
---main :: String -> Color -> Rank -> Int Int Int-> [Int Int Int] -> DistanceTable

mainProgram = do
    args <- getArgs
    let tablename = head args
    let colour = head  $ drop 1 args
    let rnk = head $ drop 2 args
    let obst = strToLocation $ drop 6 args

    let locat = (read (head (drop 3 args)) :: Int , read (head (drop 4 args)) :: Int )

    let offserObst = map (\x -> ((fst locat) - (fst x) + 8, (snd locat) - (snd x) + 8) )  obst

    let distance_table = generateDistenceTableObst offserObst (getColorFromString colour) (getRankFromString rnk)
    displayTable tablename $ distance_table
--    putStrLn $ displayTableToPython tablename $ distance_table

showHelp :: SomeException -> IO ()
showHelp _ = {--putStrLn $ "The program requires command line input.\nAlthough it is assumed \
    \that the board is 8x8x1 for now. Try entering this: \n\
    \\n \
    \compiled/Distance \"Rook\" Black Rook 4 4 1 4 7 1 4 2 1 5 4 1"
    --}
    do
        displayTable "x Queen" x
        displayTable "cbx Queen" qbx
        displayTable "y Queen" y
        displayTable "cby Queen" qby
        displayTable "oval Queen" qxy
        putStrLn "bye."
        where y = generateDistenceTableObst (map (\x -> (7 - (fst x) + 8, 3 - (snd x) + 8) ) [(4,7),(4,2),(5,4)]) Black King
              x = generateDistenceTableObst (map (\x -> (5 - (fst x) + 8, 8 - (snd x) + 8) ) [(4,7),(4,2),(5,4)]) Black King
              xq = generateDistenceTableObst [] Black Queen
              qbx = applyToChessBoard (6,2) xq
              qby = applyToChessBoard (7,4) xq
              cbx = applyToChessBoard (5,8) x
              cby = applyToChessBoard (7,3) y
              xy = V.zipWith mixVectors cbx cby
              qxy = V.zipWith mixVectors qbx qby
              

mixVectors x y
    | x < 0 = x
    | y < 0 = y
    | otherwise = x + y

main = EX.catch mainProgram showHelp
