module R where

import Board

makeRForBoard board fP x y@(y1, y2) 
    | x == y = False
    | Just y1 < minX board = False
    | Just y1 > maxX board = False
    | Just y2 < minY board = False
    | Just y2 > maxY board = False
    | otherwise = fP x y

r = makeRForBoard
r_distance = makeRForBoard.makeDistanceBoard


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

