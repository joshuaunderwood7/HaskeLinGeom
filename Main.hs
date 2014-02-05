module Main where

import Control.Concurrent
import Control.Concurrent.Chan
import Board
import Piece
import DistanceTables

forkableGeneration chan string color rank =
    writeChan chan $ displayTableToString string $ generateDistenceTable color rank

main = do
    chan <- newChan
    forkIO $ forkableGeneration chan "Rook" Black Rook
    forkIO $ forkableGeneration chan "Knight" Black Knight
    forkIO $ forkableGeneration chan "Bishop" Black Bishop
    forkIO $ forkableGeneration chan "Queen" Black Queen
    forkIO $ forkableGeneration chan "King" Black King
    forkIO $ forkableGeneration chan "White Pawn" White Pawn
    forkIO $ forkableGeneration chan "Black Pawn" Black Pawn
    readChan chan >>= putStrLn 
    readChan chan >>= putStrLn 
    readChan chan >>= putStrLn 
    readChan chan >>= putStrLn 
    readChan chan >>= putStrLn 
    readChan chan >>= putStrLn 
    readChan chan >>= putStrLn 
    
{--

    let rook = generateDistenceTable Black Rook
    displayTable "Rook" rook

--}
