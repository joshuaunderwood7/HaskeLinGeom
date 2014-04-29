#These are the distance tables for Chess pieces

ChessBoard = [ x for x in range(64) ]
Rook = ["2", "2", "2", "2", "2", "2", "2", "1", "2", "2", "2", "2", "2", "2", "2", 
        "2", "2", "2", "2", "2", "2", "2", "1", "2", "2", "2", "2", "2", "2", "2",
        "2", "2", "2", "2", "2", "2", "2", "1", "2", "2", "2", "2", "2", "2", "2",
        "2", "2", "2", "2", "2", "2", "2", "1", "2", "2", "2", "2", "2", "2", "2",
        "2", "2", "2", "2", "2", "2", "2", "1", "2", "2", "2", "2", "2", "2", "2",
        "2", "2", "2", "2", "2", "2", "2", "1", "2", "2", "2", "2", "2", "2", "2",
        "2", "2", "2", "2", "2", "2", "2", "1", "2", "2", "2", "2", "2", "2", "2",
        "1", "1", "1", "1", "1", "1", "1", "0", "1", "1", "1", "1", "1", "1", "1",
        "2", "2", "2", "2", "2", "2", "2", "1", "2", "2", "2", "2", "2", "2", "2",
        "2", "2", "2", "2", "2", "2", "2", "1", "2", "2", "2", "2", "2", "2", "2",
        "2", "2", "2", "2", "2", "2", "2", "1", "2", "2", "2", "2", "2", "2", "2",
        "2", "2", "2", "2", "2", "2", "2", "1", "2", "2", "2", "2", "2", "2", "2",
        "2", "2", "2", "2", "2", "2", "2", "1", "2", "2", "2", "2", "2", "2", "2",
        "2", "2", "2", "2", "2", "2", "2", "1", "2", "2", "2", "2", "2", "2", "2",
        "2", "2", "2", "2", "2", "2", "2", "1", "2", "2", "2", "2", "2", "2", "2"]
Knight = ["6", "5", "4", "5", "4", "5", "4", "5", "4", "5", "4", "5", "4", "5", "6",
          "5", "4", "5", "4", "3", "4", "3", "4", "3", "4", "3", "4", "5", "4", "5",
          "4", "5", "4", "3", "4", "3", "4", "3", "4", "3", "4", "3", "4", "5", "4",
          "5", "4", "3", "4", "3", "2", "3", "2", "3", "2", "3", "4", "3", "4", "5",
          "4", "3", "4", "3", "2", "3", "2", "3", "2", "3", "2", "3", "4", "3", "4",
          "5", "4", "3", "2", "3", "4", "1", "2", "1", "4", "3", "2", "3", "4", "5",
          "4", "3", "4", "3", "2", "1", "2", "3", "2", "1", "2", "3", "4", "3", "4",
          "5", "4", "3", "2", "3", "2", "3", "0", "3", "2", "3", "2", "3", "4", "5",
          "4", "3", "4", "3", "2", "1", "2", "3", "2", "1", "2", "3", "4", "3", "4",
          "5", "4", "3", "2", "3", "4", "1", "2", "1", "4", "3", "2", "3", "4", "5",
          "4", "3", "4", "3", "2", "3", "2", "3", "2", "3", "2", "3", "4", "3", "4",
          "5", "4", "3", "4", "3", "2", "3", "2", "3", "2", "3", "4", "3", "4", "5",
          "4", "5", "4", "3", "4", "3", "4", "3", "4", "3", "4", "3", "4", "5", "4",
          "5", "4", "5", "4", "3", "4", "3", "4", "3", "4", "3", "4", "5", "4", "5",
          "6", "5", "4", "5", "4", "5", "4", "5", "4", "5", "4", "5", "4", "5", "6"]
Bishop = ["1", "X", "2", "X", "2", "X", "2", "X", "2", "X", "2", "X", "2", "X", "1",
          "X", "1", "X", "2", "X", "2", "X", "2", "X", "2", "X", "2", "X", "1", "X",
          "2", "X", "1", "X", "2", "X", "2", "X", "2", "X", "2", "X", "1", "X", "2",
          "X", "2", "X", "1", "X", "2", "X", "2", "X", "2", "X", "1", "X", "2", "X",
          "2", "X", "2", "X", "1", "X", "2", "X", "2", "X", "1", "X", "2", "X", "2",
          "X", "2", "X", "2", "X", "1", "X", "2", "X", "1", "X", "2", "X", "2", "X",
          "2", "X", "2", "X", "2", "X", "1", "X", "1", "X", "2", "X", "2", "X", "2",
          "X", "2", "X", "2", "X", "2", "X", "0", "X", "2", "X", "2", "X", "2", "X",
          "2", "X", "2", "X", "2", "X", "1", "X", "1", "X", "2", "X", "2", "X", "2",
          "X", "2", "X", "2", "X", "1", "X", "2", "X", "1", "X", "2", "X", "2", "X",
          "2", "X", "2", "X", "1", "X", "2", "X", "2", "X", "1", "X", "2", "X", "2",
          "X", "2", "X", "1", "X", "2", "X", "2", "X", "2", "X", "1", "X", "2", "X",
          "2", "X", "1", "X", "2", "X", "2", "X", "2", "X", "2", "X", "1", "X", "2",
          "X", "1", "X", "2", "X", "2", "X", "2", "X", "2", "X", "2", "X", "1", "X",
          "1", "X", "2", "X", "2", "X", "2", "X", "2", "X", "2", "X", "2", "X", "1"]
Queen = ["1", "2", "2", "2", "2", "2", "2", "1", "2", "2", "2", "2", "2", "2", "1",
         "2", "1", "2", "2", "2", "2", "2", "1", "2", "2", "2", "2", "2", "1", "2",
         "2", "2", "1", "2", "2", "2", "2", "1", "2", "2", "2", "2", "1", "2", "2",
         "2", "2", "2", "1", "2", "2", "2", "1", "2", "2", "2", "1", "2", "2", "2",
         "2", "2", "2", "2", "1", "2", "2", "1", "2", "2", "1", "2", "2", "2", "2",
         "2", "2", "2", "2", "2", "1", "2", "1", "2", "1", "2", "2", "2", "2", "2",
         "2", "2", "2", "2", "2", "2", "1", "1", "1", "2", "2", "2", "2", "2", "2",
         "1", "1", "1", "1", "1", "1", "1", "0", "1", "1", "1", "1", "1", "1", "1",
         "2", "2", "2", "2", "2", "2", "1", "1", "1", "2", "2", "2", "2", "2", "2",
         "2", "2", "2", "2", "2", "1", "2", "1", "2", "1", "2", "2", "2", "2", "2",
         "2", "2", "2", "2", "1", "2", "2", "1", "2", "2", "1", "2", "2", "2", "2",
         "2", "2", "2", "1", "2", "2", "2", "1", "2", "2", "2", "1", "2", "2", "2",
         "2", "2", "1", "2", "2", "2", "2", "1", "2", "2", "2", "2", "1", "2", "2",
         "2", "1", "2", "2", "2", "2", "2", "1", "2", "2", "2", "2", "2", "1", "2",
         "1", "2", "2", "2", "2", "2", "2", "1", "2", "2", "2", "2", "2", "2", "1"]
King = ["7", "7", "7", "7", "7", "7", "7", "7", "7", "7", "7", "7", "7", "7", "7",
        "7", "6", "6", "6", "6", "6", "6", "6", "6", "6", "6", "6", "6", "6", "7",
        "7", "6", "5", "5", "5", "5", "5", "5", "5", "5", "5", "5", "5", "6", "7",
        "7", "6", "5", "4", "4", "4", "4", "4", "4", "4", "4", "4", "5", "6", "7",
        "7", "6", "5", "4", "3", "3", "3", "3", "3", "3", "3", "4", "5", "6", "7",
        "7", "6", "5", "4", "3", "2", "2", "2", "2", "2", "3", "4", "5", "6", "7",
        "7", "6", "5", "4", "3", "2", "1", "1", "1", "2", "3", "4", "5", "6", "7",
        "7", "6", "5", "4", "3", "2", "1", "0", "1", "2", "3", "4", "5", "6", "7",
        "7", "6", "5", "4", "3", "2", "1", "1", "1", "2", "3", "4", "5", "6", "7",
        "7", "6", "5", "4", "3", "2", "2", "2", "2", "2", "3", "4", "5", "6", "7",
        "7", "6", "5", "4", "3", "3", "3", "3", "3", "3", "3", "4", "5", "6", "7",
        "7", "6", "5", "4", "4", "4", "4", "4", "4", "4", "4", "4", "5", "6", "7",
        "7", "6", "5", "5", "5", "5", "5", "5", "5", "5", "5", "5", "5", "6", "7",
        "7", "6", "6", "6", "6", "6", "6", "6", "6", "6", "6", "6", "6", "6", "7",
        "7", "7", "7", "7", "7", "7", "7", "7", "7", "7", "7", "7", "7", "7", "7"]
White_Pawn = ["X", "X", "X", "X", "X", "X", "X", "7", "X", "X", "X", "X", "X", "X", "X",
              "X", "X", "X", "X", "X", "X", "X", "6", "X", "X", "X", "X", "X", "X", "X",
              "X", "X", "X", "X", "X", "X", "X", "5", "X", "X", "X", "X", "X", "X", "X",
              "X", "X", "X", "X", "X", "X", "X", "4", "X", "X", "X", "X", "X", "X", "X",
              "X", "X", "X", "X", "X", "X", "X", "3", "X", "X", "X", "X", "X", "X", "X",
              "X", "X", "X", "X", "X", "X", "X", "2", "X", "X", "X", "X", "X", "X", "X",
              "X", "X", "X", "X", "X", "X", "X", "1", "X", "X", "X", "X", "X", "X", "X",
              "X", "X", "X", "X", "X", "X", "X", "0", "X", "X", "X", "X", "X", "X", "X",
              "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X",
              "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X",
              "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X",
              "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X",
              "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X",
              "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X",
              "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X"]
Black_Pawn = ["X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X",
              "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X",
              "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X",
              "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X",
              "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X",
              "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X",
              "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X", "X",
              "X", "X", "X", "X", "X", "X", "X", "0", "X", "X", "X", "X", "X", "X", "X",
              "X", "X", "X", "X", "X", "X", "X", "1", "X", "X", "X", "X", "X", "X", "X",
              "X", "X", "X", "X", "X", "X", "X", "2", "X", "X", "X", "X", "X", "X", "X",
              "X", "X", "X", "X", "X", "X", "X", "3", "X", "X", "X", "X", "X", "X", "X",
              "X", "X", "X", "X", "X", "X", "X", "4", "X", "X", "X", "X", "X", "X", "X",
              "X", "X", "X", "X", "X", "X", "X", "5", "X", "X", "X", "X", "X", "X", "X",
              "X", "X", "X", "X", "X", "X", "X", "6", "X", "X", "X", "X", "X", "X", "X",
              "X", "X", "X", "X", "X", "X", "X", "7", "X", "X", "X", "X", "X", "X", "X"]

def breakIntoRows(table):
    print [[table[x+(y*15)] for x in range(15)] for y in range(15)]

def indexToLocation(x):
    return ( (8-(x%8)) , (int(x/8)+1) )

def locationToDestIndex(locat):
    x, y = locat
    return (15 - x) + ((y-1) * 15)

def locationToIndex(locat):
    x, y = locat
    return (8 - x) + ((y-1) * 8)

def applyToChessBoard(locat, dTable): 
    x0, y0 = locat
    x0 = 9 - x0
    offsetBoard = [(x,y) for x in range(x0, x0+8) for y in range(y0, y0+8)] 
    temp =  [dTable[locationToDestIndex(locat)] for locat in offsetBoard]
    pprintChessTable(temp)
    return temp

def pprintChessTable(dTable):
    for yi in range(8): 
        y = 8 - yi
        for xi in range(8):
            x = 8 - xi
            print dTable[locationToIndex((x,y))],
        print

def distance(piecetype, fromLocat, toLocat):
    """ piecetype: 
        BK, BF, WK, Wk = King
        BP, BB = Black_Pawn
        WP, WB = White_Pawn
        all others will be implemented ad needed
        """
    if piecetype in ["BK", "BF", "WF", "WK"] : piecetype = King
    elif piecetype in ["BB", "BP"] : piecetype = Black_Pawn
    elif piecetype in ["WB", "WP"] : piecetype = White_Pawn

    return applyToChessBoard(fromLocat, piecetype)[locationToIndex(toLocat)]

#pprintChessTable(ChessBoard)
#pprintChessTable(applyToChessBoard((5,5), Knight))
#print  distance("BF", (5,5), (5,6)) 

