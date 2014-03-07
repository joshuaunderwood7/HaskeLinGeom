module Piece where

import R
import Board
import Data.Char (toUpper)
import Data.Ix (inRange)
import qualified Data.Vector as V

data Color = Black | White | Grey
    deriving (Eq, Show)

getColorFromString x
    | (map toUpper x) == "WHITE" = White
    | (map toUpper x) == "BLACK" = Black
    | otherwise = Grey

data Rank = Pawn | Knight | Bishop | Rook | Queen | King | Obstacle | Underwood
    deriving (Eq, Show)

getRankFromString x
    | (map toUpper x) == "PAWN"      = Pawn
    | (map toUpper x) == "KNIGHT"    = Knight
    | (map toUpper x) == "BISHOP"    = Bishop
    | (map toUpper x) == "ROOK"      = Rook
    | (map toUpper x) == "QUEEN"     = Queen
    | (map toUpper x) == "KING"      = King
    | (map toUpper x) == "UNDERWOOD" = Underwood
    | otherwise  = Obstacle

data Piece = Piece { movement :: (Location -> Bool) ,
                     color    :: Color ,
                     rank     :: Rank ,
                     location :: Location }

on :: Location -> [Piece] -> [Piece]
on x ps = [p | p <- ps, (location p) == x]

on1 :: Location -> [Piece] -> Piece
on1 x ps = head $ on x ps

makePiece :: Board -> Color -> Rank -> Location -> Piece
makePiece board colour rnk locat = Piece (moveFunk board colour rnk locat) colour rnk locat

makeChessPiece :: Color -> Rank -> Location -> Piece
makeChessPiece = makePiece chessboard

transColor piece 
    | color piece == Black = makeChessPiece White (rank piece) (location piece)
    | color piece == White = makeChessPiece Black (rank piece) (location piece)
    | otherwise = piece

makeChessDistancePiece :: Color -> Rank -> Location -> Piece
makeChessDistancePiece = makePiece distanceBoard

moveFunk :: Board -> Color -> Rank -> Location -> Location -> Bool
moveFunk board colour rnk locat
    | rnk == Pawn && colour == White  = (r board) r_pW locat
    | rnk == Pawn && colour == Black  = (r board) r_pB locat
    | rnk == Knight = (r board) r_n locat
    | rnk == Bishop = (r board) r_b locat
    | rnk == Rook   = (r board) r_r locat
    | rnk == Queen  = (r board) r_q locat
    | rnk == King   = (r board) r_k locat
    | rnk == Underwood = (r board) r_u locat
    | otherwise     = \_ -> False

--needs to include more than the movment check, needs to remove oposing piece
--I think that this would also be a good place to implement Pawn movments...

movePiece :: Board -> Piece -> Location -> Piece
movePiece board piece locat
    | (movement piece) locat = makePiece board (color piece) (rank piece) locat
    | otherwise              = piece

movePieceUnchecked board piece locat = makePiece board (color piece) (rank piece) locat
moveChessPieceUnchecked = movePieceUnchecked chessboard

moveChessPiece :: Piece -> Location -> Piece
moveChessPiece = movePiece chessboard

moveChessDistancePiece :: Piece -> Location -> Piece
moveChessDistancePiece = movePiece distanceBoard

--For the advancedBoardMovments these are the directions that a piece can move
--This prevents the pieces from being able to pass through another piece.
--There is an added bennifit that this is slightly faster than the (every
--possible move) method used for the genaricBoardMovments.
upLeft    loc = [((fst loc) + x, (snd loc) + x) | x <- [1..8]]
upRight   loc = [((fst loc) - x, (snd loc) + x) | x <- [1..8]]
downLeft  loc = [((fst loc) + x, (snd loc) - x) | x <- [1..8]]
downRight loc = [((fst loc) - x, (snd loc) - x) | x <- [1..8]]

left  loc = [((fst loc) + x,(snd loc)) | x <- [1..8]]
right loc = [((fst loc) - x,(snd loc)) | x <- [1..8]]
up    loc = [((fst loc),(snd loc) + x) | x <- [1..8]]
down  loc = [((fst loc),(snd loc) - x) | x <- [1..8]]

knightMoves loc = [(x,y) | x <- [((fst loc) - 2) .. ((fst loc) + 2)], y <- [((snd loc) + 2) .. ((snd loc) - 2)]]

advancedBoardMovments :: (Eq a, Num a) => V.Vector a -> Piece -> [(Int, Int)]
advancedBoardMovments table piece
    | (rank piece) == Pawn && (color piece) == Black =  filterObst [x | x <- (up (location piece))]
    | (rank piece) == Pawn && (color piece) == White =  filterObst [x | x <- (down (location piece))]
    | (rank piece) == Bishop = (filterObst [x | x <- (upLeft (location piece))]) ++ (filterObst [x | x <- (downLeft (location piece))])
                          ++ (filterObst [x | x <- (upRight (location piece))]) ++ (filterObst [x | x <- (downRight (location piece))])
    | (rank piece) == Rook = (filterObst [x | x <- (up (location piece))]) ++ (filterObst [x | x <- (down (location piece))])
                          ++ (filterObst [x | x <- (left (location piece))]) ++ (filterObst [x | x <- (right (location piece))])
    | (rank piece) == Queen = (filterObst [x | x <- (up (location piece))]) ++ (filterObst [x | x <- (down (location piece))])
                          ++ (filterObst [x | x <- (left (location piece))]) ++ (filterObst [x | x <- (right (location piece))])
                          ++ (filterObst [x | x <- (upLeft (location piece))]) ++ (filterObst [x | x <- (downLeft (location piece))])
                          ++ (filterObst [x | x <- (upRight (location piece))]) ++ (filterObst [x | x <- (downRight (location piece))])
    | (rank piece) == Knight = filterObstKnight $ genaricBoardMovments distanceBoard piece
    | (rank piece) == King   = genaricBoardMovments distanceBoard piece
    | (rank piece) == Underwood = genaricBoardMovments distanceBoard piece
    | otherwise = [(location piece)]
    where filterObst = takeWhile (\m -> (movement piece m) && table V.! (translatePairToVector m) /= (-2))
          filterObstKnight = filter (\m -> (movement piece m) && table V.! (translatePairToVector m) /= (-2))
    --The filterObst function has an unsafe short circut for the V.! index out
    --of range.  It should be  boundchecked first. But this appears to work.
    --Lazy evaluation almost guarentees that the index won't be called unless
    --the movement is valid

--These Genaric movments do not take into account any obstical in the way. and
--therefore the advancedBoardMovments should be used on an initilized DistanceTable
genaricBoardMovments :: Board -> Piece -> [Location]
genaricBoardMovments board piece = [(x,y) | x <- (boardXrange board), y <- (boardYrange board), movement piece (x,y)]

chessBoardMovments :: Piece -> [Location]
chessBoardMovments piece = [(x,y) | x <- [1..8], y <- [1..8], movement piece (x,y)]

--Here are the starting positions of all of the pieces,
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

