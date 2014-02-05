module Piece where

import R
import Board

data Color = Black | White
    deriving (Eq)
data Rank = Pawn | Knight | Bishop | Rook | Queen | King
    deriving (Eq)

data Piece = Piece { movement :: (Location -> Bool) ,
                     color    :: Color ,
                     rank     :: Rank ,
                     location :: Location }

makePiece board colour rnk locat = Piece (moveFunk board colour rnk locat) colour rnk locat

makeChessPiece = makePiece chessboard
makeChessDistancePiece = makePiece distanceBoard

moveFunk board colour rnk locat
    | rnk == Pawn && colour == White  = (r board) r_pW locat
    | rnk == Pawn && colour == Black  = (r board) r_pB locat
    | rnk == Knight = (r board) r_n locat
    | rnk == Bishop = (r board) r_b locat
    | rnk == Rook   = (r board) r_r locat
    | rnk == Queen  = (r board) r_q locat
    | rnk == King   = (r board) r_k locat
    | otherwise     = \_ -> False

--needs to include more than the movment check, needs to remove oposing piece
--I think that this would also be a good place to implement Pawn movments...
movePiece board piece locat
    | (movement piece) locat = makePiece board (color piece) (rank piece) locat 
    | otherwise              = piece

moveChessPiece = movePiece chessboard
moveChessDistancePiece = movePiece distanceBoard

genaricBoardMovments board piece = [(x,y) | x <- (boardXrange board), y <- (boardYrange board), movement piece (x,y)]
chessBoardMovments piece = [(x,y) | x <- [1..8], y <- [1..8], movement piece (x,y)]

pawnsB   = [makeChessPiece Black Pawn   (x,2) | x <- [1..8]]
rooksB   = [makeChessPiece Black Rook   (x,1) | x <- [1,8]]
knishtsB = [makeChessPiece Black Knight (x,1) | x <- [2,7]]
bishopsB = [makeChessPiece Black Bishop (x,1) | x <- [3,5]]
queenB   = [makeChessPiece Black Queen  (x,1) | x <- [4]]
kingB    = [makeChessPiece Black King   (x,1) | x <- [5]]

pawnsW   = [makeChessPiece White Pawn   (x,7) | x <- [1..8]]
rooksW   = [makeChessPiece White Rook   (x,8) | x <- [1,8]]
knishtsW = [makeChessPiece White Knight (x,8) | x <- [2,7]]
bishopsW = [makeChessPiece White Bishop (x,8) | x <- [3,5]]
queenW   = [makeChessPiece White Queen  (x,8) | x <- [4]]
kingW    = [makeChessPiece White King   (x,8) | x <- [5]]

{--
main = do

    print $ map chessBoardMovments pawnsB
    print $ map chessBoardMovments rooksB
    print $ map chessBoardMovments queenB

    let p1 = makePiece Black Pawn (2,6)
    print $ location p1
    print $ chessBoardMovments p1
    let p1_2 = movePiece p1 (2,5)
    print $ chessBoardMovments p1_2

    print "bye"
--}

