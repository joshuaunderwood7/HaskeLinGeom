module Main where

import Control.Concurrent
import Control.Concurrent.Chan
import Control.Parallel.Strategies
import Board
import Piece
import DistanceTables


{--
forkableGeneration :: String -> Color -> Rank -> String
forkableGeneration string color rank =
    displayTableToString string $ generateDistenceTable color rank
--}
{--}
forkableGeneration string color rank =
    "let " ++ string ++ " = " ++ (show $ generateDistenceTable color rank)
--}

doXtimes :: (Eq a, Monad m, Num a) => a -> m a1 -> m a1
doXtimes x func
    | x == 0 = func 
    | x == 1 = func 
    | otherwise = do func; doXtimes (x - 1) func

main = do
{--
-- This is an expirement with parallel, but I've only seen it take longer
    let black_p = zip ["Rook", "Knight", "Bishop", "Queen", "King", "Black_Pawn"] [Rook, Knight, Bishop, Queen, King, Pawn] 
    mapM putStrLn $ parMap rpar id $ [forkableGeneration x Black y | (x, y) <- black_p] ++ [forkableGeneration "White_Pawn" White Pawn]
--}

{--}
-- This is another expirement with Concurrent processing, (Runtime will do Parallel if run +RTS -N)
-- This is slightly slower when run parallel, but I only have two cores.
    chan <- newChan
    forkIO $ writeChan chan $ forkableGeneration "Rook" Black Rook
    forkIO $ writeChan chan $ forkableGeneration "Knight" Black Knight
    forkIO $ writeChan chan $ forkableGeneration "Bishop" Black Bishop
    forkIO $ writeChan chan $ forkableGeneration "Queen" Black Queen
    forkIO $ writeChan chan $ forkableGeneration "King" Black King
    forkIO $ writeChan chan $ forkableGeneration "White_Pawn" White Pawn
    forkIO $ writeChan chan $ forkableGeneration "Black_Pawn" Black Pawn
    doXtimes 7 $ readChan chan >>= putStrLn
--}

{--
--This appears to run about the same time as forkIO Concurrentcy
    putStrLn $ forkableGeneration "Rook" Black Rook
    putStrLn $ forkableGeneration "Knight" Black Knight
    putStrLn $ forkableGeneration "Bishop" Black Bishop
    putStrLn $ forkableGeneration "Queen" Black Queen
    putStrLn $ forkableGeneration "King" Black King
    putStrLn $ forkableGeneration "White Pawn" White Pawn
    putStrLn $ forkableGeneration "Black Pawn" Black Pawn
--} 
