module DistanceTables where

import qualified Data.Vector as V
import Control.Parallel.Strategies
import Data.List (nub, transpose)
import Piece
import Board
import R


getFirstDupe :: Eq a => [a] -> a
getFirstDupe (x:y:z)
    | x == y    = x
    | otherwise = getFirstDupe $ y:z


generateDistenceTableObst :: [Location] -> Color -> Rank -> V.Vector Integer
generateDistenceTableObst obst color piece = do
    let startingTable = placeObst (V.update (emptyTable) $ V.fromList [(translatePairToVector(8,8), 0)]) obst
    let accum = 0
    let validMoves = [(8,8)]
    getFirstDupe $ generateDistenceTable' validMoves startingTable (accum + 1) color piece

smallRing :: [Location] -> Piece -> V.Vector Integer
smallRing obst piece = do
    let startingTable = placeObst (V.update (emptyTable) $ V.fromList [(translatePairToVector(8,8), 0)]) obst
    let accum = 0
    let validMoves = [(8,8)]
    let shortDist = head $ generateDistenceTable' validMoves startingTable (accum + 1) (color piece) (rank piece)
    applyToChessBoard (location piece) shortDist

bigRing :: V.Vector Integer -> Integer -> V.Vector Integer
bigRing dTable dist = V.map substituteDist dTable
    where substituteDist  x = if (x == dist) then 1 else 0

oval :: V.Vector Integer -> Integer -> V.Vector Integer
oval sumTable length = bigRing sumTable length

nextj_all smallR bigR ovl = V.map and3 (V.zip3 smallR bigR ovl)
    where and3 = (\(x,y,z) -> if (x==1&&y==1&&z==1) then 1 else 0)

generateDistenceTable :: Color -> Rank -> V.Vector Integer
generateDistenceTable color piece = do
    let startingTable = V.update (emptyTable) $ V.fromList [(translatePairToVector(8,8), 0)]
    let accum = 0
    let validMoves = [(8,8)]
    getFirstDupe $ generateDistenceTable' validMoves startingTable (accum + 1) color piece

generateDistenceTable' ::
  (Eq b, Num b) => [Location] -> V.Vector b -> b -> Color -> Rank -> [V.Vector b]
generateDistenceTable' validMoves lastMove accum color piece = do
    let newPieces = map (makeChessDistancePiece color piece ) validMoves

    --let validMoves2 = nub.concat $ map (genaricBoardMovments distanceBoard) newPieces
    let validMoves2 = nub.concat $ map (advancedBoardMovments lastMove) newPieces

    let filteredValidMoves = filter (\x -> lastMove V.! (translatePairToVector x) == (-1)) validMoves2

    let vecUpdatePairs2 = zip (map translatePairToVector filteredValidMoves) (repeat accum)
    let newMove = V.update lastMove $ V.fromList vecUpdatePairs2

    newMove : (generateDistenceTable' validMoves2 newMove (accum + 1) color piece )

applyToChessBoard  :: Location -> V.Vector a -> V.Vector a
applyToChessBoard locat@(x0, y0) dTable = V.fromList [dTable V.! translatePairToVector(x) | x <- offsetBoard]
    where offsetBoard =  [(x,y) | y <- [y0..7+y0], x <- [x0..7+x0]]
--    where offsetBoard = [(x,y) | y <- [(7+x0), (6+x0) .. x0], x <- [(7+x0), (6 + x0) ..x0]]

appliedDistenceTable piece obstList = do
    applyToChessBoard (location piece) $ generateDistenceTableObst (map (\x -> (xLocat - (fst x) + 8, yLocat - (snd x) + 8) ) obstList) (color piece) (rank piece)
    where xLocat = fst $ location piece
          yLocat = snd $ location piece


sumTable x y = V.zipWith mixVectors x y

mixVectors x y
    | x < 0 = x
    | y < 0 = y
    | otherwise = x + y

