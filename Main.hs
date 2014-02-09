module Main where

import System.Environment
import Control.Concurrent
import Control.Concurrent.Chan
import Control.Parallel.Strategies
import Data.Char (toUpper)
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
main = do
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
    
    
--
--- the rest of this is all just testing things. I was having fun with parallel
--processing but I had the issue where it was taking longer to run.  Too much
--overhead for this sort of problem.  Now though I have it working and
--probably do not need any of this nonsense anymore.  but I am saving it as a
--reminder of how to accomplish this sort of parallelism.  I intend to remove
--it from the homework assignments, but if it gets attached by accident please
--ignore.

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

{--
-- This is another expirement with Concurrent processing, (Runtime will do Parallel if run +RTS -N)
-- This is slightly slower when run parallel, but I only have two cores.
-- AFTER TESTING this is my better than other mothods because it lets the rts
-- decide if there is any bennifit to Parallel, which I do not see any.
-- Parallel slows down the processing, even for large numbers of pieces
    chan <- newChan
    let black_p = zip ["Rook", "Knight", "Bishop", "Queen", "King", "Black_Pawn"] [Rook, Knight, Bishop, Queen, King, Pawn] 
    let pieces = [forkableGeneration x Black y | (x, y) <- black_p] ++ [forkableGeneration "White_Pawn" White Pawn]
    mapFork (writeChan chan) pieces
--    forkIO $ writeChan chan $ forkableGeneration "Rook" Black Rook
--    forkIO $ writeChan chan $ forkableGeneration "Knight" Black Knight
--    forkIO $ writeChan chan $ forkableGeneration "Bishop" Black Bishop
--    forkIO $ writeChan chan $ forkableGeneration "Queen" Black Queen
--    forkIO $ writeChan chan $ forkableGeneration "King" Black King
--    forkIO $ writeChan chan $ forkableGeneration "White_Pawn" White Pawn
--    forkIO $ writeChan chan $ forkableGeneration "Black_Pawn" Black Pawn
    doXtimes 7 $ readChan chan >>= putStrLn
--}

---Other methods---

{--
-- This is an expirement with parallel, but I've only seen it take longer
    let pieces = pawnsB ++ rooksB ++ knishtsB ++ bishopsB ++ queenB ++ kingB ++ pawnsW ++ rooksW ++ knishtsW ++ bishopsW ++ queenW ++ kingW
    mapM putStrLn $ parMap rpar id $ [forkableGeneration "A Piece" (color x) (rank x) | x <- pieces]
--    mapM putStrLn $ [forkableGeneration "A Piece" (color x) (rank x) | x <- pieces]
--}
{--
-- This is an expirement with parallel, but I've only seen it take longer
    let black_p = zip ["Rook", "Knight", "Bishop", "Queen", "King", "Black_Pawn"] [Rook, Knight, Bishop, Queen, King, Pawn] 
    mapM putStrLn $ parMap rpar id $ [forkableGeneration x Black y | (x, y) <- black_p] ++ [forkableGeneration "White_Pawn" White Pawn]
--}



{--
forkableGeneration :: String -> Color -> Rank -> String
forkableGeneration string color rank =
    displayTableToString string $ generateDistenceTable color rank
--}
{--
forkableGeneration string color rank =
    "let " ++ string ++ " = " ++ (show $ generateDistenceTable color rank)
--}
{--
forkableGeneration string color rank =
    displayTableToPython string $ generateDistenceTable color rank

doXtimes :: (Eq a, Monad m, Num a) => a -> m a1 -> m a1
doXtimes x func
    | x == 0 = func 
    | x == 1 = func 
    | otherwise = do func; doXtimes (x - 1) func

mapFork func (x:[]) = forkIO $ func x 
mapFork func (x:xs) = do 
    forkIO $ func x
    mapFork func xs
--}
