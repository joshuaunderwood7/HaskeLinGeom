module Board where

import qualified Data.Vector as V

type Location = (Int, Int)
data Shape = Square | Triangle | Hexagon
data Board = Board  { minX :: Maybe Int ,
                      maxX :: Maybe Int ,
                      minY :: Maybe Int ,
                      maxY :: Maybe Int ,
                      minZ :: Maybe Int ,
                      maxZ :: Maybe Int ,
                      shape :: Shape}

chessboard    = Board (Just 1) (Just 8) (Just 1) (Just 8) (Just 1) (Just 1) Square
chessboard3D  = Board (Just 1) (Just 8) (Just 1) (Just 8) (Just 1) (Just 8) Square
chessboardNxN = Board (Just 1) (Nothing) (Just 1) (Nothing) (Just 1) (Just 1) Square
distanceBoard = makeDistanceBoard chessboard


boardRange :: (Enum t1, Num t1) => (t -> Maybe t1) -> (t -> Maybe t1) -> t -> [t1]
boardRange param_min param_max board = 
    case param_min board of
        Just min_p -> case param_max board of
            Just max_p -> [min_p..max_p]
            Nothing    -> [min_p..]
        Nothing    -> [-1..1] --TODO: Infinite list in both directions??!

boardXrange = boardRange minX maxX
boardYrange = boardRange minY maxY
boardZrange = boardRange minZ maxZ

numberOfSquares2d :: Board -> Int
numberOfSquares2d board = (length $ boardXrange board) * (length $ boardYrange board)

makeDistanceBoard :: Board -> Board
makeDistanceBoard board = Board (Just 1) (doubleMinus1 $ maxX board) (Just 1) (doubleMinus1 $ maxY board) (Just 1) (doubleMinus1 $ maxZ board) Square

doubleMinus1 :: Num a => Maybe a -> Maybe a
doubleMinus1 (Just x) = Just ((x*2)-1)

---Here are the functions moved out of DistanceTables that I thought should be
--board functions---
--

--emptyTable board = V.replicate (numberOfSquares2d $ makeDistanceBoard board) (-1) 
emptyTable = V.replicate (numberOfSquares2d distanceBoard) (-1) 

translatePairToVector :: (Int, Int) -> Int
translatePairToVector pair@(x,y) = (x-1) + ((y-1) * 15)

displayTable  :: (Show a) => String -> V.Vector a-> IO ()
displayTable tableName table = do
    putStrLn tableName
    let displaiedTable = breakIntoRows $ map (poundObstical.xUnreach.show) $ V.toList table
    putStrLn $ unlines.(map unwords) $ displaiedTable
    where xUnreach = (replaceValueWith "-1" "X")
          poundObstical = (replaceValueWith "-2" "#")

displayTableToString  :: (Show a) => String -> V.Vector a-> String
displayTableToString tableName table = do
    let displaiedTable = breakIntoRows $ map (poundObstical.xUnreach.show) $ V.toList table
    tableName ++ "\n" ++ (unlines.(map unwords) $ displaiedTable)
    where xUnreach = (replaceValueWith "-1" "X")
          poundObstical = (replaceValueWith "-2" "#")

breakIntoRows :: [a] -> [[a]]
breakIntoRows []   = []
breakIntoRows list = [x | x <- take 15 list] : breakIntoRows (drop 15 list)

replaceValueWith value withThis replaceThis  
    | replaceThis == value = withThis
    | otherwise         = replaceThis

replaceZeroWith = replaceValueWith 0 
replaceUnreachableWith = replaceValueWith (-1) 
