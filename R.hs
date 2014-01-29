module R where

import Board
defaultBoard = chessboard

--This is the default movement based on the board size in 2D
r fP x y@(y1, y2) 
    | x == y = False
    | Just y1 < minX defaultBoard = False
    | Just y1 > maxX defaultBoard = False
    | Just y2 < minY defaultBoard = False
    | Just y2 > maxY defaultBoard = False
    | otherwise = fP x y

--Here are the Movements for Chess
--pawns are diffucult and this is not corrct
r_pB x@(x1, x2) y@(y1, y2) = or [ and [ x1 == y1, (x2 - y2) == -1],
                                 False ]
r_pW x@(x1, x2) y@(y1, y2) = or [ and [ x1 == y1, (x2 - y2) == 1],
                                 False ]

r_n x@(x1, x2) y@(y1, y2) = or [ and [(abs (x1 - y1)) == 1, (abs (x2- y2)) == 2],
                                 and [(abs (x1 - y1)) == 2, (abs (x2- y2)) == 1]]

r_b x@(x1, x2) y@(y1, y2) = and [(abs (x1 - y1)) <= 8, 
                                 (abs (x2- y2)) <= 8,
                                  abs (x1 - y1) == abs (x2 - y2) ]

r_r x@(x1, x2) y@(y1, y2) = and [(abs (x1 - y1)) <= 8, 
                                 (abs (x2- y2)) <= 8,
                                 or [ x1 == y1, 
                                      x2 == y2]]

r_q x@(x1, x2) y@(y1, y2) = and [(abs (x1 - y1)) <= 8, 
                                 (abs (x2- y2)) <= 8,
                                 or [ x1 == y1, 
                                      x2 == y2,
                                      abs (x1 - y1) == abs (x2 - y2) ]]

r_q' x@(x1, x2) y@(y1, y2) = or [r_r x y, r_b x y] 

r_k x@(x1, x2) y@(y1, y2) = and [(abs (x1 - y1)) <= 1, (abs (x2- y2)) <= 1]


main = do
--    let pawns = [(x,y) | x <- [1..8] , y <- [2,7]]
--    let pawnsMoves = [r r_p p | p <- pawns]
--    let pawnMovements = [[(x,y) | x <- [1..8] , y <- [1..8], pMove (x,y)] | pMove <- pawnsMoves ]
    let rooks = [(x,y) | x <- [1,8] , y <- [1,8]]
    let rookMoves = [r r_r p | p <- rooks]
    let rookMovements = [[(x,y) | x <- [1..8] , y <- [1..8], pMove (x,y)] | pMove <- rookMoves ]
    let bishops = [(x,y) | x <- [3,6] , y <- [1,8]]
    let bishopsMoves = [r r_b p | p <- bishops]
    let bishopsMovements = [[(x,y) | x <- [1..8] , y <- [1..8], pMove (x,y)] | pMove <- bishopsMoves ]
    let knights = [(x,y) | x <- [2,7] , y <- [1,8]]
    let knightsMoves = [r r_n p | p <- knights]
    let knightsMovements = [[(x,y) | x <- [1..8] , y <- [1..8], pMove (x,y)] | pMove <- knightsMoves ]
    let queens = [(1,4),(8,5)]
    let queensMoves = [r r_q p | p <- queens]
    let queensMovements = [[(x,y) | x <- [1..8] , y <- [1..8], pMove (x,y)] | pMove <- queensMoves ]
    let kings = [(1,5),(8,4)]
    let kingsMoves = [r r_k p | p <- kings]
    let kingsMovements = [[(x,y) | x <- [1..8] , y <- [1..8], pMove (x,y)] | pMove <- kingsMoves ]
--    print pawnMovements
    print rookMovements
    print bishopsMovements
    print knightsMovements
    print queensMovements
    print kingsMovements

     
    {--
    let p1 = (2,6)
    let r_p1 = r r_p p1
    let movements' = [(x,y) | x <- [1..8] , y <- [1..8], r_p1 (x,y)]
    print $ r_k (1,1) (2,3)
    print movements'
    --}
    print "bye"

{-- Queen movements
[(1,5),(1,6),(1,7),(2,1),(2,2),(2,3),(2,4),(2,5),(2,7),(2,8),(3,5),(3,6),(3,7),(4,4),(4,6),(4,8),(5,3),(5,6),(6,2),(6,6),(7,1),(7,6),(8,6)]
++++XXX+
XXXXX0XX
++++XXX+
+++X+X+X
++X++X++
+X+++X++
X++++X++
+++++X++
--}
{-- Knight movements
[(1,4),(1,8),(3,4),(3,8),(4,5),(4,7)]
+++X+++X
+++++0++
+++X+++X
++++X+X+
++++++++
++++++++
++++++++
++++++++
--}
