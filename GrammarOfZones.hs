module GrammarOfZones where

import DistanceTables
import R
import Piece
import Board
import qualified Data.Vector as V

frst (x,_,_) = x
scnd (_,x,_) = x
thrd (_,_,x) = x
easierU :: U -> (Integer, Integer, Integer)
easierU bigU = ( toInteger $ translateChessPairToVector $ frst bigU,
                 toInteger $ translateChessPairToVector $ scnd bigU,
                 thrd bigU )

type U = (Location, Location, Integer)
type V = V.Vector Integer
type W = V.Vector Integer
type TIME = V.Vector Integer
type NEXTTIME = V.Vector Integer

data GrammarState = GrammarState {
        gs_P :: [Piece],
        gs_p0 :: Piece,
        gs_x0 :: Location,
        gs_y0 :: Location,
        gs_l0 :: Integer,
        gs_n :: Integer,
        gs_u :: U,
        gs_v :: V,
        gs_w :: W,
        gs_time :: TIME,
        gs_nexttime :: NEXTTIME }

zoneToString zone = do
    let zone'  = map (\(a,b,c) -> "t(" ++ show a ++ ", " ++ trajectoryToString b ++", " ++ show c ++ ")") zone
    unlines zone'


initilizeGrammar pieces p0 x0 y0 l0 n = do
    let u0 = (x0, y0, l0)
    let v0 = ((V.fromList.(take n).repeat) (toInteger 0))
    let w0 = ((V.fromList.(take n).repeat) (toInteger 0))
    let time0 = ((V.fromList.(take n).repeat) (toInteger $ 2 * n))
    let nexttime0 = ((V.fromList.(take n).repeat) (toInteger $ 2 * n))
    GrammarState pieces p0 x0 y0 l0 (toInteger n) u0 v0 w0 time0 nexttime0 

q1 gs = do
    let distTable = appliedDistenceTable (gs_p0 gs) (map location (gs_P gs))
    and [ ((on1 (gs_x0 gs) (gs_P gs)) == (gs_p0 gs)), --is p0 on x0?
          (mapx_p distTable (gs_y0 gs) <= (gs_l0 gs)), --The distence is less then l0
          (mapx_p distTable (gs_y0 gs) <= (thrd (gs_u gs))),-- the distence is less then l
          ((on (gs_y0 gs) (gs_P gs)) /= []), --is there a target?
          (oppose (gs_p0 gs) (on1 (gs_y0 gs) (gs_P gs)) ) --is the target opposing team?
        ]
q2 _ = True
q3 gs = do
    let u = gs_u gs
    or [translateChessPairToVector (frst u) /= (fromIntegral $ gs_n gs), 
        translateChessPairToVector (scnd u) /= (fromIntegral $ gs_n gs)] 

q4 gs = do
    let distTable = appliedDistenceTable (gs_p0 gs) (map location (gs_P gs))
    let x = frst $ gs_u gs
    let y = scnd $ gs_u gs
    let x0 = translateChessPairToVector $ gs_x0 gs
    let y0 = translateChessPairToVector $ gs_y0 gs
    let l = thrd $ gs_u gs
    let ps = on (frst $ gs_u gs) (gs_P gs)
    let p = if ps /= [] then (head ps) else makeChessPiece Grey Obstacle (0,0)
--Here are the logical tests, they are easier to read this way
    let aPieceOnX = ps /= [] --is there a piece on x?
    let lGTzero = l > (toInteger 0)
    let xNotOnx0 = (translateChessPairToVector $ x) /= x0
    let yNotOny0 = (translateChessPairToVector $ y) /= y0
    let opposingPieces = oppose (gs_p0 gs) p
    and [ aPieceOnX,
          lGTzero,
          xNotOnx0,
          yNotOny0,
          or [ and [ (not opposingPieces), (mapx_p distTable y) == 1 ],
               and [ ( opposingPieces ), (mapx_p distTable y) <= l ] ] ]


q5 gs = or $ V.toList $ V.map (/=0) (gs_w gs)
q6 _ = True

gzinit gs u r
    | u == (0,0,0) = 2 * (gs_n gs)
    | otherwise   = r

gzf gs u@(x,y,l) v 
    | or [(and [(x/=(gs_n gs)),(l>(toInteger 0))]),(and [(y==(gs_n gs)),(l<=(toInteger 0))])] = (x+(toInteger 1),y,l)
    | or [(x==(gs_n gs)),(and [(y/=(gs_n gs)),(l<=(toInteger 0))])] = ( (toInteger 1), 
                                                                        (y+(toInteger 1)), 
                                                                        ((gs_time gs)V.! fromInteger (y+(toInteger 1))) * (v V.! fromInteger (y+(toInteger 1))) )
    | otherwise = u

h_i gs = True

generateChessZoneM2 pieces mainPiece target mainTrajectory = do
    let otherPices = (filter (\x -> x /= target && x /= mainPiece) pieces) 
    print otherPices
    let actualMainTrajectory = tail mainTrajectory
    let gzTIMEbase = V.map (+1) $ appliedDistenceTable mainPiece (map location otherPices) 
    putStr "gzTIMEbase: "
    print gzTIMEbase
    let gzTrajBase = V.update emptyChessTable $ V.fromList $ zip [0..63] (repeat 0)
    let gzTrajr    = V.update gzTrajBase $ V.fromList $ zip (map translateChessPairToVector actualMainTrajectory) (repeat 1)
    let gzTraj     = {--V.fromList.reverse.V.toList $--} gzTrajr
    putStr "gzTraj:     "
    print gzTraj
    let gzTIME     = V.fromList $ zipWith (*) [x | x <- (V.toList gzTraj)] [y | y <- (V.toList gzTIMEbase)]
    putStr "gzTIME:     "
    displayTable "gzTIME" gzTIME
    let primeTraj  = (mainPiece, mainTrajectory, (gzTIME V.! (translateChessPairToVector (last mainTrajectory))))
    let baseResult = primeTraj : [makeNetworkTraj (color mainPiece) piece dest otherPices (gzTIME V.! (translateChessPairToVector dest)) | piece <- otherPices, dest <- actualMainTrajectory]
    return $ filter (\x-> (length.scnd) x <= ((+1).fromInteger.thrd) x) $ filter (\x -> scnd x /= []) baseResult
    
makeNetworkTraj mColor piece dest obstPieces maxLength  
    | mColor == color piece = (piece, [], -1)
    | otherwise = do
        let bundle = buildTrajectoryBundle 1 piece dest (map location obstPieces)
        if bundle == [] then (piece, [], -1)
                        else (piece, head bundle, maxLength)
    
