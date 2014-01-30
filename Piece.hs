module Piece where

import R hiding (main)
import Board hiding (main)

type Location = (Int, Int)
data Color = Black | White
    deriving (Eq)
data Rank = Pawn | Knight | Bishop | Rook | Queen | King
    deriving (Eq)

data Piece = Piece { movement :: (Location -> Bool) ,
                     color    :: Color ,
                     rank     :: Rank ,
                     location :: Location }

makePiece colour rnk locat = Piece (moveFunk colour rnk locat) colour rnk locat

moveFunk colour rnk locat
    | rnk == Pawn && colour == White  = r r_pW locat
    | rnk == Pawn && colour == Black  = r r_pB locat
    | rnk == Knight = r r_n locat
    | rnk == Bishop = r r_b locat
    | rnk == Rook   = r r_r locat
    | rnk == Queen  = r r_q locat
    | rnk == King   = r r_k locat
    | otherwise     = \_ -> False

--needs to include more than the movment check, needs to remove oposing piece
--I think that this would also be a good place to implement Pawn movments...
movePice piece locat
    | (movement piece) locat = makePiece (color piece) (rank piece) locat 
    | otherwise              = piece

genaricBoardMovments board piece = [(x,y) | x <- (boardXrange board), y <- (boardYrange board), movement piece (x,y)]
chessBoardMovments piece = [(x,y) | x <- [1..8], y <- [1..8], movement piece (x,y)]

pawnsB   = [makePiece Black Pawn   (x,2) | x <- [1..8]]
rooksB   = [makePiece Black Rook   (x,1) | x <- [1,8]]
knishtsB = [makePiece Black Knight (x,1) | x <- [2,7]]
bishopsB = [makePiece Black Bishop (x,1) | x <- [3,5]]
queenB   = [makePiece Black Queen  (x,1) | x <- [4]]
kingB    = [makePiece Black King   (x,1) | x <- [5]]

pawnsW   = [makePiece White Pawn   (x,7) | x <- [1..8]]
rooksW   = [makePiece White Rook   (x,8) | x <- [1,8]]
knishtsW = [makePiece White Knight (x,8) | x <- [2,7]]
bishopsW = [makePiece White Bishop (x,8) | x <- [3,5]]
queenW   = [makePiece White Queen  (x,8) | x <- [4]]
kingW    = [makePiece White King   (x,8) | x <- [5]]

main = do

    print $ map chessBoardMovments pawnsB

{--
    let p1 = makePiece Black Pawn (2,6)
    print $ location p1
    print $ chessBoardMovments p1
    let p1_2 = movePice p1 (2,5)
    print $ chessBoardMovments p1_2
--}

    print $ head [1..8]
    print $ last [1..8]
    print "bye"
