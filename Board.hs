module Board where

data Shape = Square | Triangle | Hexagon

data Board = Board  { minX :: Maybe Int ,
                      maxX :: Maybe Int ,
                      minY :: Maybe Int ,
                      maxY :: Maybe Int ,
                      minZ :: Maybe Int ,
                      maxZ :: Maybe Int ,
                      shape :: Shape}


boardRange param_min param_max board = case param_min board of
    Just min_p -> case param_max board of
        Just max_p -> [min_p..max_p]
        Nothing    -> [min_p..]
    Nothing    -> [-1..1] --TODO: Infinite list in both directions??!

boardXrange = boardRange minX maxX
boardYrange = boardRange minY maxY
boardZrange = boardRange minZ maxZ

chessboard = Board (Just 1) (Just 8) (Just 1) (Just 8) (Just 1) (Just 1) Square
chessboard3D = Board (Just 1) (Just 8) (Just 1) (Just 8) (Just 1) (Just 8) Square
chessboardNxN = Board (Just 1) (Nothing) (Just 1) (Nothing) (Just 1) (Just 1) Square
distanceBoard = Board (Just 1) (Just 15) (Just 1) (Just 15) (Just 1) (Just 1) Square

{--
main = do 
    print $ boardXrange chessboard
    print $ boardYrange chessboard
    print $ boardZrange chessboard
    print $ take 10 $ boardXrange chessboardNxN
    print $ take 10 $ boardYrange chessboardNxN
--}
