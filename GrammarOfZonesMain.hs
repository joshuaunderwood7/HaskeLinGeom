module Main where

import GrammarOfZones
import DistanceTables
import R
import Piece
import Board
import qualified Data.Vector as V

main = do
    let s_color = White
    let s_rank  = King
    let start = (4,7)
    let destination = (4,1)
    let subject = makeChessPiece s_color s_rank start
    let i_color = Black
    let i_rank  = Queen
    let i_start = (5,8)
    let i_dest  = (2,1)
    let i_adversary = makeChessPiece i_color i_rank i_start
    let l_color = Black
    let l_rank  = Knight
    let l_start = (5,6)
    let l_dest  = (2,1)
    let l_adversary = makeChessPiece l_color l_rank l_start
    let t_color = Black
    let t_rank  = Rook
    let t_start = (4,1)
    let t_dest  = (4,1)
    let target = makeChessPiece t_color t_rank t_start
    let obstPice = makeChessPiece White King (5,5)
    let pieces = [subject, i_adversary, l_adversary, target, obstPice]

    let mainTrajectory = head $ buildTrajectoryBundle 1 subject destination [(location i_adversary), (location l_adversary), (location obstPice)]
    print mainTrajectory

    let zone = generateChessZoneM2 pieces subject target mainTrajectory 
    zone >>= return.zoneToString >>= putStrLn

    --let obst = [(4,3),(4,4),(4,5),(4,6),(5,3),(5,4),(5,5),(5,6),(6,3),(3,4),(3,5)]


    --let bundle = buildTrajectoryBundle 1 subject destination obst
    --let bundle = bAJT 1 subject destination obst 4
    

    --print $ length.nub $ map trajectoryToString bundle
    --mapM putStrLn $ map (\x -> "        " ++ locationOnChessboard x ++ " [fillcolor=yellow]") obst  
    --putStrLn $ (unlines.nub.lines.concat) $ map trajectoryToDotString bundle

    --displayTable "White moves:" $ appliedDistenceTable x obsticals
    --print $ map trajectoryToString bundle
    --displayTable "Underwood moves:" $ appliedDistenceTable subject []
    --let mainPiece = makeChessPiece
    --print $ zone

    print "bye"
