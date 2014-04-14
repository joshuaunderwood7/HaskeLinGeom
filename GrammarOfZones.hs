module GrammarOfZones where

import DistanceTables
import R
import Piece
import Board
import qualified Data.Vector as V

frst (x,_,_) = x
scnd (_,x,_) = x
thrd (_,_,x) = x

--TODO: Remove these functions from the IO Monad.

--This will generate zones but only first negations and along the shortest path
-- clearly this will not do, but it is the base for the M3 funtion below
generateChessZoneM2 :: Monad m =>[Piece]-> Piece-> Piece-> [(Int, Int)]-> m [(Piece, [Location], Integer)]
generateChessZoneM2 _ mainPiece _ [] = return [(mainPiece, [location mainPiece], 1)]
generateChessZoneM2 pieces mainPiece target mainTrajectory = do
    let otherPices = (filter (\x -> x /= target && x /= mainPiece) pieces) 
    let actualMainTrajectory = tail mainTrajectory
    let gzTIMEbase = V.map (+1) $ appliedDistenceTable mainPiece (map location otherPices) 
    let gzTrajBase = V.fromList $ take 64 $ repeat 0
    let gzTraj     = V.update gzTrajBase $ V.fromList $ zip (map translateChessPairToVector actualMainTrajectory) (repeat 1)
    let gzTIME     = V.fromList $ zipWith (*) [x | x <- (V.toList gzTraj)] [y | y <- (V.toList gzTIMEbase)]

    --displayTable "mainDistance" $ appliedDistenceTable mainPiece (map location otherPices)
    --displayTable "gzTIME" gzTIME

    let primeTraj  = (mainPiece, mainTrajectory, (gzTIME V.! (translateChessPairToVector (last mainTrajectory))))
    let baseResult = primeTraj : [makeNetworkTraj (color mainPiece) piece dest otherPices (gzTIME V.! (translateChessPairToVector dest)) | piece <- otherPices, dest <- actualMainTrajectory]
    return $ filter (\x-> (length.scnd) x <= ((+1).fromInteger.thrd) x) $ filter (\x -> scnd x /= []) baseResult
    
-- This makes the trajectories of the pieces for the generateChessZoneMX
-- functions,  What this provides is the distence = 1 for same color and
-- distence = maxLength for opposing color.  Also, it simply takes the head of
-- the bundles, so this is where the trajectory selection will take place
makeNetworkTraj :: Color-> Piece-> Location-> [Piece]-> Integer-> (Piece, [Location], Integer)
makeNetworkTraj mColor piece dest obstPieces maxLength  
    | mColor == color piece = do
        --let bundle = bJT 1 piece dest (map location obstPieces)
        let bundlebase = bJT 1 piece dest (map location obstPieces)
        let bundle = filter (\x-> length x == 2) bundlebase 
            --not needed, but I feel like it's a good idea to filter here in
            --case generateChessZoneM2 changes it's filtering
        if bundle == [] then (piece, [], -1)
                        else (piece, head bundle, maxLength)
    | otherwise = do
        let bundle = bAJT 1 piece dest (map location obstPieces) maxLength
        if bundle == [] then (piece, [], -1)
                        else (piece, head bundle, maxLength)

-- More advanced, generateChessZoneM3 will increment the horizon until 8, and
-- return the first one that has a zone, if any.
generateChessZoneM3 :: Monad m =>[Piece]-> Piece-> Piece-> [(Int, Int)]-> m [(Piece, [Location], Integer)]
generateChessZoneM3 pieces mainPiece target [] = return [(mainPiece, [location mainPiece], 1)]
generateChessZoneM3 pieces mainPiece target mainTrajectory = do
    let zones' = [generateChessZoneM3' pieces mainPiece target mainTrajectory horizonMod | horizonMod <- [1..8]]
    let zones = dropWhile (\x -> length x > 1) zones'
    if zones == [] then return [] 
                   else return $ (head.head) zones 

generateChessZoneM3' pieces mainPiece target [] horizonMod = return [(mainPiece, [location mainPiece], 1)]
generateChessZoneM3' pieces mainPiece target mainTrajectory horizonMod = do
    let otherPices = (filter (\x -> x /= target && x /= mainPiece) pieces) 
    let actualMainTrajectory = tail mainTrajectory
    let gzTIMEbase = V.map (+1) $ appliedDistenceTable mainPiece (map location otherPices) 
    let gzTrajBase = V.fromList $ take 64 $ repeat 0
    let gzTraj     = V.update gzTrajBase $ V.fromList $ zip (map translateChessPairToVector actualMainTrajectory) (repeat 1)
    let gzTIME     = V.fromList $ zipWith (*) [x | x <- (V.toList gzTraj)] [y | y <- (V.toList gzTIMEbase)]

    --displayTable "mainDistance" $ appliedDistenceTable mainPiece (map location otherPices)
    --displayTable "gzTIME" gzTIME

    let primeTraj  = (mainPiece, mainTrajectory, (gzTIME V.! (translateChessPairToVector (last mainTrajectory))))
    let baseResultTail = [makeNetworkTraj (color mainPiece) piece dest otherPices (gzTIME V.! (translateChessPairToVector dest)) | piece <- otherPices, dest <- actualMainTrajectory]
    let resultTail = filter (\x-> (length.scnd) x <= ((+horizonMod).fromInteger.thrd) x) $ filter (\x -> scnd x /= []) baseResultTail

    -- this is where we need to add nTH negation loop
    let baseResultTail' = generateChessZoneM3applyNeg resultTail (color mainPiece) otherPices


    let baseResult = primeTraj : baseResultTail'
    let result = filter (\x-> (length.scnd) x <= ((+horizonMod).fromInteger.thrd) x) $ filter (\x -> scnd x /= []) baseResult
    return result

generateChessZoneM3applyNeg :: [(Piece, [Location], Integer)]-> Color -> [Piece] -> [(Piece, [Location], Integer)]
generateChessZoneM3applyNeg [] _ _ = []
generateChessZoneM3applyNeg result@(rh:rt) originalColor otherPices
    = generateChessZoneM3negations otherPices (frst rh) (scnd rh) originalColor (thrd rh - (toInteger.length.scnd) rh + (toInteger 1)) ++ 
        generateChessZoneM3applyNeg rt originalColor otherPices
    
    

-- hand this otherPices as pieces list to pre-eliminate mainPiece and target
generateChessZoneM3negations :: [Piece]-> Piece-> [Location]-> Color-> Integer-> [(Piece, [Location], Integer)]
generateChessZoneM3negations pieces mainPiece mainTrajectory originalColor maxLength = do
    let otherPices = filter (/=mainPiece) pieces
    let actualMainTrajectory = tail.init $ mainTrajectory
    let primeTraj  = (mainPiece, mainTrajectory, maxLength)
    let baseResult = primeTraj : [makeNetworkTraj originalColor piece dest otherPices maxLength | piece <- otherPices, dest <- actualMainTrajectory]
    filter (\x-> (length.scnd) x <= (fromInteger.thrd) x) $ filter (\x -> scnd x /= []) baseResult


---------------------------------------original Grammar----------------------

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

