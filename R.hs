module R where

import Board

makeRForBoard :: Board -> (Location -> Location -> Bool) -> Location -> Location -> Bool
makeRForBoard board fP x y@(y1, y2) 
    | x == y = False
    | Just y1 < minX board = False
    | Just y1 > maxX board = False
    | Just y2 < minY board = False
    | Just y2 > maxY board = False
    | otherwise = fP x y

r :: Board -> (Location -> Location -> Bool) -> Location -> Location -> Bool
r = makeRForBoard

r_distance :: Board -> (Location -> Location -> Bool) -> Location -> Location -> Bool
r_distance = makeRForBoard.makeDistanceBoard


--Here are the Movements for Chess
r_pB :: (Eq a, Eq a1, Num a1) => (a, a1) -> (a, a1) -> Bool
r_pW :: (Eq a, Eq a1, Num a1) => (a, a1) -> (a, a1) -> Bool
r_n :: (Eq a, Eq a1, Num a, Num a1) => (a, a1) -> (a, a1) -> Bool
r_b :: (Num a, Ord a) => (a, a) -> (a, a) -> Bool
r_r :: (Num a, Num a1, Ord a, Ord a1) => (a, a1) -> (a, a1) -> Bool
r_q :: (Num a, Ord a) => (a, a) -> (a, a) -> Bool
r_q' :: (Num a, Ord a) => (a, a) -> (a, a) -> Bool
r_k :: (Num a, Num a1, Ord a, Ord a1) => (a, a1) -> (a, a1) -> Bool

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

