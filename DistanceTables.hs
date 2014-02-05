module DistanceTables where

import qualified Data.Vector as V
import Data.List (nub)
import Piece
import Board
import R


getFirstDupe (x:y:z)
    | x == y    = x
    | otherwise = getFirstDupe $ y:z

generateDistenceTable color piece = do
    let listOfTables = generateDistenceTable' color piece
    getFirstDupe listOfTables

generateDistenceTable' color piece = do
    --let startingTable = V.update (emptyTable chessboard) $ V.fromList [(translatePairToVector(8,8), 0)]
    let startingTable = V.update (emptyTable) $ V.fromList [(translatePairToVector(8,8), 0)]
    let testP = makeChessDistancePiece color piece (8,8)
    let validMoves = genaricBoardMovments distanceBoard testP
    let accum = 1
    let vecUpdatePairs = zip (map translatePairToVector validMoves) (repeat accum)
    let oneMove = V.update startingTable $ V.fromList vecUpdatePairs
    oneMove : (generateDistenceTable'' validMoves oneMove (accum + 1) color piece )

generateDistenceTable'' validMoves lastMove accum color piece = do
    let newPieces = map (makeChessDistancePiece color piece ) validMoves
    let validMoves2 = nub.concat $ map (genaricBoardMovments distanceBoard) newPieces
    let filteredValidMoves = filter (\x -> lastMove V.! (translatePairToVector x) == (-1)) validMoves2
    let vecUpdatePairs2 = zip (map translatePairToVector filteredValidMoves) (repeat accum)
    let newMove = V.update lastMove $ V.fromList vecUpdatePairs2
    newMove : (generateDistenceTable'' validMoves2 newMove (accum + 1) color piece )

