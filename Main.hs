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
        let obst = [(4,7),(4,2),(5,4)]
        {--
        let testPieceX = makeChessPiece Black King (7,3)
        let testPieceY = moveChessPieceUnchecked testPieceX (5,8)
        --print $ location testPieceY
        let cbx = appliedDistenceTable testPieceX obst
        let cby = appliedDistenceTable testPieceY obst
        let smallRingX = smallRing obst $ moveChessPieceUnchecked testPieceX (7,3)
        let bigRingX = bigRing cbx 1
        let ovalX = oval (sumTable cbx cby) (mapx_p cbx (5,8))

        displayTable "cbx" cbx
        displayTable "cby" cby
        displayTable "SUM table" $ sumTable cbx cby
        displayTable "smallring" smallRingX
        displayTable "bigRing" bigRingX
        displayTable "oval" ovalX
        displayTable "next_j" $ nextj_all_table smallRingX bigRingX ovalX
        let next_j = nextj_all smallRingX bigRingX ovalX

        --print $ mapx_p cbx (5,8)
        --print $ translateChessPairToVector (5,8)
        --print $ cbx V.! 0
        --}
        let bundle = buildTrajectoryBundle 1 (makeChessPiece Black King (6,3)) (1,1) obst

        print bundle

        putStrLn "bye."



main = EX.catch mainProgram showHelp
