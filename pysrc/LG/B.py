import ChessTables as C
#import GrammarOfReducedSearches as GRS

def B(g_state, piecetype, inputString): 
    """
        piecetype in "'BB','WB','WF','BF'"
        expected inputString 'B(XX:YY)'
        This is a simplified trajectory builder. 
        This does not take into account any blocked path, and 
        only returns along the shortest path.
        What will be returned is b((xx,xx,zz,...),B(XX:YY))
        where zz,yy,zz,... are possible next moves along shortest
        path and B(XX:YY) is the inputString.

        This is useful because it will allow us to compare bundles
        and choose a next move that satisfies the most.
        But also this should be used to compare zones, to find
        which move satisfies the most of them.
        """
    XX = inputString[2:4]
    YY = inputString[5:7]
    return B_prime(g_state, piecetype, C.chessLocationToLocation(XX), C.chessLocationToLocation(YY)) + inputString + ")"

def B_prime(g_state, piecetype, start, finish):

    #fetch the pieceNumber for R_p_x movements
    STATE = g_state.getSTATE()
    pieceNumber = 0
    for x in range(1,7): 
        if STATE["p_" + str(x)] == piecetype: 
            pieceNumber = x

    # error check
    if pieceNumber == 0:
        print "Could not find pice in state"
        return "b(();"

    # get the big oval
    fromDtable = C.applyToChessBoard(start, C.getDistanceboard(piecetype)) 
    toDTable = C.applyToChessBoard(finish, C.getDistanceboard(piecetype)) 
    distance = C.distance(piecetype, start, finish) 
    bigOval = [str(int(a)+int(b)) for (a,b) in zip(fromDtable, toDTable)]
    bigOval = map((lambda x: int(x) == int(distance)),bigOval) 

    # get smallOval (already filtered down to next moves)
    smallOval = [(x,y) for x in range(1,9) for y in range(1,9) if STATE["Rp_" + str(pieceNumber) + "_" + str(x) + str(y)] and bigOval[C.locationToIndex((y,x))] and (x,y) != start] 
    nextMoves =  map((lambda x: C.locationToChessLocation(x)), smallOval)

    returnString = "b(("
    for move in nextMoves:
        returnString += move + ','
    if len(nextMoves) != 0: # removes extra ','
        returnString = returnString[:-1]
    returnString += ');' 

    return returnString


def nextMovesToList(inputString):
    if inputString[0] != 'b': return []
    parts = inputString[2:-1].split(';')
    nextMoves = parts[0][1:-1].split(',')
    return nextMoves


