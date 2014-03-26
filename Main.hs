module Main where 
import System.Environment
import Control.Exception as EX
import Data.Char (toUpper)
import Data.List (nub)
import qualified Data.Vector as V
import Board
import Piece
import DistanceTables



strToLocation ::  [String] -> [(Int, Int)]
strToLocation [] = []
strToLocation str = do
    let x = read ( head str) :: Int
    let y = read ( head (drop 1 str) ) :: Int
    (x, y) : strToLocation (drop 3 str)


mainProgram ::  IO ()
mainProgram = do
    args <- getArgs
    case (map toUpper (head args)) of 
        "DISTANCE"         -> displayTableIO $ drop 1 args
        "CHESSDISTANCE"    -> displayChessTableIO $ drop 1 args
        "BUNDLE"           -> bundleIO $ drop 1 args
        "ACCEPTABLEBUNDLE" -> acceptableBundleIO $ drop 1 args
        "BUNDLESTRING"           -> bundleIOString $ drop 1 args
        "ACCEPTABLEBUNDLESTRING" -> acceptableBundleIOString $ drop 1 args



displayTableIO ::  [String] -> IO ()
displayTableIO args = do
    let tablename = head args
    let colour = head  $ drop 1 args
    let rnk = head $ drop 2 args
    let obst = strToLocation $ drop 6 args

    let locat = (read (head (drop 3 args)) :: Int , read (head (drop 4 args)) :: Int )

    let offserObst = map (\x -> ((fst locat) - (fst x) + 8, (snd locat) - (snd x) + 8) )  obst

    let distance_table = generateDistenceTableObst offserObst (getColorFromString colour) (getRankFromString rnk)
    displayTable tablename $ distance_table

displayChessTableIO ::  [String] -> IO ()
displayChessTableIO args = do
    let tablename = head args
    let colour = head  $ drop 1 args
    let rnk = head $ drop 2 args
    let obst = strToLocation $ drop 6 args
    let locat = (read (head (drop 3 args)) :: Int , read (head (drop 4 args)) :: Int )
    let piece = makeChessPiece (getColorFromString colour) (getRankFromString rnk) locat

    let distance_table = appliedDistenceTable piece obst
    displayTable tablename $ distance_table

bundleIO args = do
    let filename = head args
    let colour = head  $ drop 1 args
    let rnk = head $ drop 2 args
    let obst = strToLocation $ drop 9 args
    let locat = (read (head (drop 3 args)) :: Int , read (head (drop 4 args)) :: Int )
    let destination = (read (head (drop 6 args)) :: Int , read (head (drop 7 args)) :: Int )
    let piece = makeChessPiece (getColorFromString colour) (getRankFromString rnk) locat

    let bundle = buildTrajectoryBundle 1 piece destination obst
    putStrLn $ generateDotString bundle obst

acceptableBundleIO args = do
    let filename = head args
    let colour = head  $ drop 1 args
    let rnk = head $ drop 2 args
    let obst = strToLocation $ drop 10 args
    let locat = (read (head (drop 3 args)) :: Int , read (head (drop 4 args)) :: Int )
    let destination = (read (head (drop 6 args)) :: Int , read (head (drop 7 args)) :: Int )
    let maxLength = read ( head ( drop 9 args ) ) :: Integer
    let piece = makeChessPiece (getColorFromString colour) (getRankFromString rnk) locat

    let bundle = builtAcceptableTrajectoriesBundle 1 piece destination obst maxLength
    putStrLn $ generateDotString bundle obst

bundleIOString args = do
    let filename = head args
    let colour = head  $ drop 1 args
    let rnk = head $ drop 2 args
    let obst = strToLocation $ drop 9 args
    let locat = (read (head (drop 3 args)) :: Int , read (head (drop 4 args)) :: Int )
    let destination = (read (head (drop 6 args)) :: Int , read (head (drop 7 args)) :: Int )
    let piece = makeChessPiece (getColorFromString colour) (getRankFromString rnk) locat

    let bundle = buildTrajectoryBundle 1 piece destination obst
    mapM putStrLn $ nub $ map trajectoryToString bundle
    return ()


acceptableBundleIOString args = do
    let filename = head args
    let colour = head  $ drop 1 args
    let rnk = head $ drop 2 args
    let obst = strToLocation $ drop 10 args
    let locat = (read (head (drop 3 args)) :: Int , read (head (drop 4 args)) :: Int )
    let destination = (read (head (drop 6 args)) :: Int , read (head (drop 7 args)) :: Int )
    let maxLength = read ( head ( drop 9 args ) ) :: Integer
    let piece = makeChessPiece (getColorFromString colour) (getRankFromString rnk) locat

    let bundle = builtAcceptableTrajectoriesBundle 1 piece destination obst maxLength
    mapM putStrLn $ nub $ map trajectoryToString bundle
    return ()



showHelp :: SomeException -> IO ()
showHelp _ = do
    putStrLn $ "The program requires command line input.\nAlthough it is assumed \
    \that the board is 8x8x1 for now. Try entering this: \n\
    \\n \
    \./compiled/Distance DISTANCE \"Rook\" Black Rook 4 4 1 4 7 1 4 2 1 5 4 1 \n\
    \or \n\
    \./compiled/Distance BUNDLE \"King\" Black King 3 3 1 3 6 1 4 3 1 4 4 1 4 5 1 4 6 1 3 4 1 3 5 1 \n\
    \or \n\
    \./compiled/Distance ACCEPTABLEBUNDLE \"King\" Black King 3 3 1 3 6 1 4 4 3 1 4 4 1 4 5 1 4 6 1 3 4 1 3 5 1 \n\
    \or \n\
    \./compiled/Distance BUNDLESTRING \"King\" Black King 3 3 1 3 6 1 4 3 1 4 4 1 4 5 1 4 6 1 3 4 1 3 5 1 \n\
    \or \n\
    \./compiled/Distance ACCEPTABLEBUNDLESTRING \"King\" Black King 3 3 1 3 6 1 4 4 3 1 4 4 1 4 5 1 4 6 1 3 4 1 3 5 1 \n\
    \ \n"
    {--
    do
        let obst = [(4,3),(4,4),(4,5),(4,6),(5,3),(5,4),(5,5),(5,6),(6,3),(3,4),(3,5)]
        let s_color = White
        let s_rank  = Underwood
        let start = (3,2)
        let destination = (4,1)
        let subject = makeChessPiece s_color s_rank start


        --let bundle = buildTrajectoryBundle 1 subject destination obst
        let bundle = bAJT 1 subject destination obst 4
        

        --print $ length.nub $ map trajectoryToString bundle
        --mapM putStrLn $ map (\x -> "        " ++ locationOnChessboard x ++ " [fillcolor=yellow]") obst  
        putStrLn $ (unlines.nub.lines.concat) $ map trajectoryToDotString bundle

        --displayTable "White moves:" $ appliedDistenceTable x obsticals
        --print $ map trajectoryToString bundle
        displayTable "Underwood moves:" $ appliedDistenceTable subject []
    --}

generateDotFile filename bundle obsticals = writeFile filename (generateDotString bundle obsticals)
generateDotString bundle obsticals = do
    let header = "digraph {"
    let nodes = [ (x,y) | x <- [8, 7..1] , y <- [1..8] ]
    let nodeStrings = map (makeNodeString obsticals) nodes
    let trajectoryStrings = (unlines.nub.lines.concat) $ map trajectoryToDotString bundle
    let footer = "}"
    header ++ (foldr1 (++) nodeStrings) ++ trajectoryStrings ++ footer

makeNodeString obsticals node@(x,y)
    | node `elem` obsticals = ""
    | otherwise             = "     " ++ locationOnChessboard node ++ "[label=\"" ++ locationOnChessboard node ++ "\" pos=\"" ++ (show (9-x)) ++ "," ++ (show y) ++ "!\"] \n" 
{-- TODO: Issues with GraphViz moving nodes around.  
    | node `elem` obsticals = "     " ++ locationOnChessboard node ++ "[label=\"" ++ locationOnChessboard node ++ "\" pos=\"" ++ (show x) ++ "," ++ (show y) ++ "!\" fontcolor=red] \n" 
    | otherwise             = "     " ++ locationOnChessboard node ++ "[label=\"" ++ locationOnChessboard node ++ "\" pos=\"" ++ (show (9-x)) ++ "," ++ (show y) ++ "!\"] \n" 
--}
main ::  IO ()
main = EX.catch mainProgram showHelp
