module Main where

import GrammarOfReducedSearches
import DistanceTables
import R
import Piece
import Board
import qualified Data.Vector as V
import Control.Monad

main ::  IO ()
main = do
    let pieces = [ (makeChessPiece Black Pawn (1,5)),
                   (makeChessPiece Black Target (6,8)),
                   (makeChessPiece White Target (1,1)),
                   (makeChessPiece White Pawn (6,6)),
                   (makeChessPiece White King (1,8)),
                   (makeChessPiece Black King (8,6))]

    let teamA = filter (\x -> White == color x) pieces
    let teamB = filter (\x -> Black == color x) pieces
    
    let teamAZones = [ generateChessZoneM3 pieces mainPiece targetPiece (generationHelper mainPiece targetPiece pieces) | mainPiece <- teamA , targetPiece <- teamB ]
    let teamBZones = [ generateChessZoneM3 pieces mainPiece targetPiece (generationHelper mainPiece targetPiece pieces) | mainPiece <- teamB , targetPiece <- teamA ]

    let teamAZonesSignificant = map (liftM $ filter (\(_,_,x) -> x > 1)) teamAZones
    let teamBZonesSignificant = map (liftM $ filter (\(_,_,x) -> x > 1)) teamBZones

    let allZones = teamAZonesSignificant ++ teamBZonesSignificant
    let allTheNames = [ (mainPiece, targetPiece) | mainPiece <- teamA , targetPiece <- teamB] ++ [ (mainPiece, targetPiece) | mainPiece <- teamB , targetPiece <- teamA]
    printAllTheZones' allTheNames allZones 
--    printAllTheZones allZones

    print "bye"

generationHelper ::  Piece -> Piece -> [Piece] -> [Location]
generationHelper mainPiece targetPiece allPieces = do
    let trajectories = bJT 1 mainPiece (location targetPiece) (map location $ filter (\x -> x/=mainPiece && x/=targetPiece) allPieces)
    if trajectories == [] then [location mainPiece]
                          else head trajectories

printAllTheZones :: (Show a, Show a1) => [IO [(a, [Location], a1)]] -> IO ()
printAllTheZones []     = putStrLn " --- "
printAllTheZones (x:xs) = x >>= return.zoneToString >>= putStrLn >> putStrLn " --- " >> printAllTheZones xs

printAllTheZones' :: (Show a1, Show a2, Show a) =>[a] -> [IO [(a1, [Location], a2)]] -> IO ()
printAllTheZones' [] _    = putStrLn " --- "
printAllTheZones' (n:ns) (x:xs) = print n >> x >>= return.zoneToString >>= putStrLn >> putStrLn " --- " >> printAllTheZones' ns xs

