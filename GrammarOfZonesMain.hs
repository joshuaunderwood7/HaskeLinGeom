module Main where

import GrammarOfZones
import DistanceTables
import R
import Piece
import Board
import qualified Data.Vector as V

main = do
    let s_color = White
    let s_rank  = Bishop
    let start = (3,2)
    let destination = (4,5)
    let subject = makeChessPiece s_color s_rank start
    let target = makeChessPiece Black Pawn destination
    let adversary1 = makeChessPiece Black King (7,7)
    let adversary2 = makeChessPiece Black Knight (2,7)
    let ally1      = makeChessPiece White King (7,1)
    let ally2      = makeChessPiece White Pawn (6,3)
    let ally3      = makeChessPiece White Pawn (5,5)
    let pieces = [subject, target, adversary1, adversary2, ally1, ally2, ally3]
    let obsticals = map location $ filter (\x -> x /= subject && x /= target) pieces

    let mainTrajectory = [(3,2),(5,4),(4,5)]
    print mainTrajectory

    let zone = generateChessZoneM2 pieces subject target mainTrajectory 
    zone >>= return.zoneToString >>= putStrLn

    let pieces2 = [ (makeChessPiece Black Pawn (1,5)),
                    (makeChessPiece White Pawn (1,1)),
                    (makeChessPiece White Pawn (6,6)),
                    (makeChessPiece White King (1,8)),
                    (makeChessPiece Black King (8,6))]
    let zone2 = generateChessZoneM2 pieces2 (head pieces2) (head $ drop 1 pieces2) [(1,5),(1,4),(1,3),(1,2),(1,1)]
    zone2 >>= return.zoneToString >>= putStrLn


    print "bye"
