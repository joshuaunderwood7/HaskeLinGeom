module DistanceTables where

import qualified Data.Vector as V
import Data.List (nub)
import Piece hiding (main)
import Board hiding (main)
import R hiding (main)

emptyTable = V.replicate (15*15) (-1) 

translatePairToVector :: (Int, Int) -> Int
translatePairToVector pair@(x,y) = (x-1) + ((y-1) * 15)

displayTable  :: (Show a) => String -> V.Vector a-> IO ()
displayTable tableName table = do
    putStrLn tableName
    let displaiedTable = breakIntoRows $ map (xUnreach.show) $ V.toList table
    putStrLn $ unlines.(map unwords) $ displaiedTable
    where xUnreach = (replaceValueWith "-1" "X")

breakIntoRows :: [a] -> [[a]]
breakIntoRows []   = []
breakIntoRows list = [x | x <- take 15 list] : breakIntoRows (drop 15 list)

replaceValueWith value withThis replaceThis  
    | replaceThis == value = withThis
    | otherwise         = replaceThis

replaceZeroWith = replaceValueWith 0 
replaceUnreachableWith = replaceValueWith (-1) 

getFirstDupe (x:y:z)
    | x == y    = x
    | otherwise = getFirstDupe $ y:z

generateDistenceTable color piece = do
    let listOfTables = generateDistenceTable' color piece
    getFirstDupe listOfTables

generateDistenceTable' color piece = do
    let startingTable = V.update emptyTable $ V.fromList [(translatePairToVector(8,8), 0)]
    let testP = makePiece color piece (8,8)
    let validMoves = genaricBoardMovments defaultBoard testP
    --print validMoves
    let accum = 1
    let vecUpdatePairs = zip (map translatePairToVector validMoves) (repeat accum)
    --print vecUpdatePairs
    let oneMove = V.update startingTable $ V.fromList vecUpdatePairs
    --displayTable "pawnsB one move" pawnsBOneMove 
    oneMove : (generateDistenceTable'' validMoves oneMove (accum + 1) color piece )

generateDistenceTable'' validMoves lastMove accum color piece = do
    let newPieces = map (makePiece color piece) validMoves
    let validMoves2 = nub.concat $ map (genaricBoardMovments defaultBoard) newPieces
    let filteredValidMoves = filter (\x -> lastMove V.! (translatePairToVector x) == (-1)) validMoves2
    let vecUpdatePairs2 = zip (map translatePairToVector filteredValidMoves) (repeat accum)
    --print vecUpdatePairs2
    let newMove = V.update lastMove $ V.fromList vecUpdatePairs2
    --displayTable "pawnsB New move" pawnsBNewMove 
    newMove : (generateDistenceTable'' validMoves2 newMove (accum + 1) color piece )


main = do
    let rook = generateDistenceTable Black Rook
    displayTable "Rook" rook
    let knight = generateDistenceTable Black Knight
    displayTable "Knight" knight
    let bishop = generateDistenceTable Black Bishop
    displayTable "Bishop" bishop
    let queen = generateDistenceTable Black Queen
    displayTable "Queen" queen
    let king = generateDistenceTable Black King
    displayTable "King" king
    let wp = generateDistenceTable White Pawn
    displayTable "White Pawn" wp
    let bp = generateDistenceTable Black Pawn
    displayTable "Black Pawn" bp
    
