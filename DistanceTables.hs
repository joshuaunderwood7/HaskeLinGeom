module DistanceTables where

import qualified Data.Vector as V
import Control.Parallel.Strategies
import Data.List (nub, transpose)
import Data.Ix (range)
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

nextj_all_table smallR bigR ovl =  V.map and3 (V.zip3 smallR bigR ovl)
    where and3 = (\(x,y,z) -> if (x==1&&y==1&&z==1) then 1 else 0)

nextj_all smallR bigR ovl = getNext_jLocations $ nextj_all_table smallR bigR ovl

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

mapx_p table destination = table V.! (translateChessPairToVector destination)

sumTable :: (Num c, Ord c) => V.Vector c -> V.Vector c -> V.Vector c
sumTable x y = V.zipWith mixVectors x y

mixVectors :: (Num a, Ord a) =>a -> a -> a
mixVectors x y
    | x < 0 = x
    | y < 0 = y
    | otherwise = x + y

--indexToChessLocation :: Integer -> Location
indexToChessLocation index = (8-(index `mod` 8),8-(index `div` 8))

locationOnChessboard :: Location -> String
locationOnChessboard (x,y)
    | x == 8 = "a" ++ (show y)
    | x == 7 = "b" ++ (show y)
    | x == 6 = "c" ++ (show y)
    | x == 5 = "d" ++ (show y)
    | x == 4 = "e" ++ (show y)
    | x == 3 = "f" ++ (show y)
    | x == 2 = "g" ++ (show y)
    | x == 1 = "h" ++ (show y)
    | otherwise = "xx"

trajectoryToString traj = do
    let locats = map locationOnChessboard traj
    concat ["a("++l++")" | l <- locats]

trajectoryToDotString []     = ""
trajectoryToDotString (x:[]) = ""
trajectoryToDotString (x:xs) = "        " ++ (locationOnChessboard x) ++ " -> " ++ (locationOnChessboard (head xs)) ++ "\n" ++ trajectoryToDotString xs

getIndexOfnonZero table = filter (>=0) $ getIndexOfnonZero' table 0
getIndexOfnonZero' table index
    | V.length table > index = (if table V.! index /= 0 then index else -1) : getIndexOfnonZero' table (index + 1)
    | otherwise              = []

getIndexOfNLength table nLength = filter (>=0) $ getIndexOfNLength' nLength table 0
getIndexOfNLength' n table index
    | V.length table > index = (if table V.! index == n then index else -1) : getIndexOfNLength' n table (index + 1)
    | otherwise              = []

getNLengthLocations table n = map indexToChessLocation $ getIndexOfNLength table n

getNext_jLocations table = map indexToChessLocation $ getIndexOfnonZero table


buildTrajectoryBundle loopCount piece destination obsticals
    | (location piece) == destination = [[location piece]]
    | loopCount >= 124 = []
    | rank piece == Pawn = bJTforP piece destination obsticals
    | otherwise = do
        let x = piece
        let cbx = appliedDistenceTable x obsticals
        if mapx_p cbx destination < (0) --is destination reachable? 
            then []
            else do
                let y = moveChessPieceUnchecked x destination
                let cby = appliedDistenceTable y obsticals
                let smallRingX = smallRing obsticals x
                let bigRingX = bigRing cbx loopCount
                let ovalX = oval (sumTable cbx cby) (mapx_p cbx destination)
                let next_j = nextj_all smallRingX bigRingX ovalX
                let currentList = [[location piece]]
                bJT' currentList (loopCount + 1) piece destination obsticals cbx ovalX next_j

bJT = buildTrajectoryBundle

bJT' _ 124 _ _ _ _ _ _ = []
bJT' lastList _ _ _ _ _ _ []  = lastList
bJT' lastList loopCount piece destination obsticals cbx oval current_j
    | location piece == destination = lastList
    | otherwise = do
        let smallRingX = smallRing obsticals piece
        let bigRingX = bigRing cbx loopCount
        let next_j = nextj_all smallRingX bigRingX oval
        let movesList = concat $ [bJT 1 (moveChessPiece piece x) destination obsticals | x <- current_j]
        let finalBundles = [l ++ j | j <- movesList , l <- lastList]
        filter (verifyDestination destination) finalBundles

--TODO: Why doesn't bJT' work for pawns?  Need to look into this.
bJTforP piece destination obsticals = do 
        if mapx_p (appliedDistenceTable piece obsticals) destination < (0) --is destination unreachable?         
        then [[]]                                                                  
        else do
            let yMod = snd (location piece) - snd destination
            if yMod > 0 then do
                let xRange  = repeat $ fst destination                              
                [ zip xRange $ reverse [snd destination .. snd (location piece)] ]
            else do
                let xRange  = repeat $ fst destination                              
                [ zip xRange $ [snd (location piece) .. snd destination] ]

builtAcceptableTrajectoriesBundle loopCount piece destination obsticals maxLength = do
    let x = piece
    let cbx = appliedDistenceTable x obsticals
    let y = moveChessPieceUnchecked x destination
    let cby = appliedDistenceTable y obsticals
    let distanceSum = sumTable cbx cby
    let minDistence = V.minimum distanceSum
    let maxDistence = V.maximum distanceSum
    bAJT' loopCount piece destination obsticals maxLength x y cbx cby distanceSum minDistence maxDistence 
bAJT = builtAcceptableTrajectoriesBundle
bAJT' loopCount piece destination obsticals maxLength x y cbx cby distanceSum minDistence maxDistence
    | maxLength < minDistence = [[]]
    | maxLength == minDistence = bJT loopCount piece destination obsticals
--    | maxLength > maxDistence = bAJT' loopCount piece destination obsticals maxDistence x y cbx cby distanceSum minDistence maxDistence
    | otherwise = do
        let acceptableLengths = drop 1 [minDistence .. maxLength] 
        let acceptableMidpoints = filter (\x -> x /= (location piece) && x /= destination) $ concat [getNLengthLocations distanceSum n | n <- acceptableLengths]
        let midPointBundles = concat [combineBundles piece midPoint destination obsticals | midPoint <- acceptableMidpoints]
        let shortestBundles = bJT 1 piece destination obsticals
        let finalBundles = shortestBundles ++ midPointBundles
        filter (verifyDestination destination) finalBundles

combineBundles piece midPoint destination obsticals = do
    let bundleToMidpoint   = map init $ filter (verifyDestination midPoint) $ bJT 1 piece midPoint obsticals
    let bundleFromMidpoint = filter (verifyDestination destination) $ bJT 1 (moveChessPieceUnchecked piece midPoint) destination obsticals
    [i ++ j | i <- bundleToMidpoint, j <- bundleFromMidpoint]

verifyDestination destination [] = False
verifyDestination destination x  = (last x) == destination

