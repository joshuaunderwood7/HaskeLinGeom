import re
import LG.R as R
#import LG.Piece as P
import LG.Board as BO
import LG.ChessTables as C
from LG.B import * 
import LG.transitions as T
import itertools
from collections import Counter


""" so here I am assuming that the rest of my program written in haskell 
is working well.  which it may be, but I have reached the limits of what
I am capable of doing efficently in that launguage, given the time crunch
of the end of my semester.  I am choosing here then to simulate good input
for the state and the moves for this project.

I hope that this will be sufficient.

Right now though it is not in working condition.
I will be resubmitting this assignment again.
"""

#Here I assign the initial state of the ABG

INITIAL_STATE = {}
# X set, locations on ABG
for i in range(64):
    INITIAL_STATE['x_'+str(i)] = i 

# P for pices in ABG
INITIAL_STATE['p_1'] = "BB" 
INITIAL_STATE['p_2'] = "BF"
INITIAL_STATE['p_3'] = "WB"
INITIAL_STATE['p_4'] = "WF"
INITIAL_STATE['p_5'] = "BT"
INITIAL_STATE['p_6'] = "WT"

# initialize P1 and P2
INITIAL_STATE["P1"] = set([INITIAL_STATE['p_1'], INITIAL_STATE['p_2'], INITIAL_STATE['p_5']])
INITIAL_STATE["P2"] = set([INITIAL_STATE['p_3'], INITIAL_STATE['p_4'], INITIAL_STATE['p_6']])

INITIAL_STATE['ON_p_1'] = INITIAL_STATE['x_39']
INITIAL_STATE['ON_p_2'] = INITIAL_STATE['x_40']
INITIAL_STATE['ON_p_3'] = INITIAL_STATE['x_42']
INITIAL_STATE['ON_p_4'] = INITIAL_STATE['x_63']
INITIAL_STATE['ON_p_5'] = INITIAL_STATE['x_58']
INITIAL_STATE['ON_p_6'] = INITIAL_STATE['x_7']

# This is a specific CUT function, will only work for this problem
#  How this works, is that it tests if the White Bomber is in any of the 
#  Gateways.

def CUT(g_state):
    state = g_state.getSTATE()
    winstate = 0
    if state["ON_p_4"] in [state["x_" + str(x)] for x in range(45,48)] and state["ON_p_1"] == state["x_39"]: 
        winstate = winstate + 1
    elif state["ON_p_4"] in [state["x_" + str(x)] for x in range(36,40)] and state["ON_p_1"] == state["x_31"]: 
        winstate = winstate + 1
    elif state["ON_p_4"] in [state["x_" + str(x)] for x in range(28,32)] and state["ON_p_1"] == state["x_23"]: 
        winstate = winstate + 1
    elif state["ON_p_4"] in [state["x_" + str(x)] for x in range(21,24)] and state["ON_p_1"] == state["x_15"]: 
        winstate = winstate + 1
    elif state["ON_p_4"] in [state["x_" + str(x)] for x in range(14,16)] and state["ON_p_1"] == state["x_7"]: 
        winstate = winstate + 1
    else:
        winstate = winstate - 1

    if state["ON_p_4"] in [state["x_" + str(x)] for x in [61,53,45,37]] and state["ON_p_2"] == state["x_40"]: 
        winstate = winstate + 1
    elif state["ON_p_4"] in [state["x_" + str(x)] for x in [60,52,44,36]] and state["ON_p_2"] in [41, 49]: 
        winstate = winstate + 1
    else:
        winstate = winstate - 1

    if winstate > 1:   winstate = 1
    if winstate < -1:  winstate = -1

    return (winstate >= 0)


def Rp_1(g_state):
    INITIAL_STATE = g_state.getSTATE()
    x1 , x2 = BO.indexToLocation(INITIAL_STATE['ON_p_1'])
    for i in range(8):
        for j in range(8):
            locat = BO.Location(x=i+1,y=j+1)
            INITIAL_STATE["Rp_1_" + str(locat.x) + str(locat.y)] = R.r_pB(BO.Location(x=x1,y=x2),locat)
def Rp_2(g_state):
    INITIAL_STATE = g_state.getSTATE()
    x1 , x2 = BO.indexToLocation(INITIAL_STATE['ON_p_2'])
    for i in range(8):
        for j in range(8):
            locat = BO.Location(x=i+1,y=j+1)
            INITIAL_STATE["Rp_2_" + str(locat.x) + str(locat.y)] = R.r_k(BO.Location(x=x1,y=x2),locat)
def Rp_3(g_state):
    INITIAL_STATE = g_state.getSTATE()
    x1 , x2 = BO.indexToLocation(INITIAL_STATE['ON_p_3'])
    for i in range(8):
        for j in range(8):
            locat = BO.Location(x=i+1,y=j+1)
            INITIAL_STATE["Rp_3_" + str(locat.x) + str(locat.y)] = R.r_pW(BO.Location(x=x1,y=x2),locat)
def Rp_4(g_state):
    INITIAL_STATE = g_state.getSTATE()
    x1 , x2 = BO.indexToLocation(INITIAL_STATE['ON_p_4'])
    for i in range(8):
        for j in range(8):
            locat = BO.Location(x=i+1,y=j+1)
            INITIAL_STATE["Rp_4_" + str(locat.x) + str(locat.y)] = R.r_k(BO.Location(x=x1,y=x2),locat)
def Rp_5(g_state):
    INITIAL_STATE = g_state.getSTATE()
    #x1 , x2 = BO.indexToLocation(INITIAL_STATE['ON_p_5'])
    for i in range(8):
        for j in range(8):
            INITIAL_STATE.update({"Rp_5_" + str(i+1) + str(j+1) : False})
def Rp_6(g_state):
    INITIAL_STATE = g_state.getSTATE()
    #x1 , x2 = BO.indexToLocation(INITIAL_STATE['ON_p_6'])
    for i in range(8):
        for j in range(8):
            locat = BO.Location(x=i+1,y=j+1)
            INITIAL_STATE.update({"Rp_6_" + str(i+1) + str(j+1) : False})

def setR(g_state):
    Rp_1(g_state)
    Rp_2(g_state)
    Rp_3(g_state)
    Rp_4(g_state)
    Rp_5(g_state)
    Rp_6(g_state)

class GrammarState():
    def __init__(self):
        global INITIAL_STATE
        self._i       = 0
        self._END     = 0
        self._CHILD   = []
        self._SIBLING = []
        self._PARENT  = []
        # here starts for the GS in lecture 19
        self._d     = 0
        self._m     = []
        self._V     = []
        self._FROM  = []
        self._TO    = []
        self._WHO   = []
        self._SIGN  = 1 
        self._STATE = INITIAL_STATE
        self.BIG_NUMBER = 256
        setR(self)
        # here I added ZONES storage
        self.ZONES = []

    def _setter(self, var, index, val):
        while index >= len(var):
            var.append(0)
        var[index] = val
        return self
    def _getter(self, var, index):
        while index >= len(var):
            var.append(0)
        return var[index]

    def getI(self): return self._i
    def setI(self, value) : self._i = value; return self
    def getEND(self): return self._END
    def setEND(self, value) : self._END = value; return self
    # here starts for the GS in lecture 19
    def getSIGN(self): return self._SIGN
    def setSIGN(self, value) : self._SIGN= value; return self
    def getD(self): return self._d
    def setD(self, value) : self._d= value; return self

    def getZONES(self): return self._ZONES
    def setZONES(self, value) : self._ZONES = value; return self
    def getSTATE(self): return self._STATE
    def setSTATE(self, value) : self._STATE = value; return self

    def getCHILD(self, index): return self._getter( self._CHILD, index)
    def setCHILD(self, index, value) : return self._setter( self._CHILD, index, value)
    def getSIBLING(self, index): return self._getter( self._SIBLING, index)
    def setSIBLING(self, index, value) : return self._setter( self._SIBLING, index, value)
    def getPARENT(self, index): return self._getter( self._PARENT, index)
    def setPARENT(self, index, value) : return self._setter( self._PARENT, index, value)
    # here starts for the GS in lecture 19
    def getM(self, index): return self._getter( self._m, index)
    def setM(self, index, value) : return self._setter( self._m, index, value)
    def getV(self, index): return self._getter( self._V, index)
    def setV(self, index, value) : return self._setter( self._V, index, value)
    def getV(self, index): return self._getter( self._V, index)
    def setV(self, index, value) : return self._setter( self._V, index, value)
    def getFROM(self, index): return self._getter( self._FROM, index)
    def setFROM(self, index, value) : return self._setter( self._FROM, index, value)
    def getTO(self, index): return self._getter( self._TO, index)
    def setTO(self, index, value) : return self._setter( self._TO, index, value)
    def getWHO(self, index): return self._getter( self._WHO, index)
    def setWHO(self, index, value) : return self._setter( self._WHO, index, value)
        
    def __str__(self):
        result = ''
        result += 'i = ' + str(self._i)
        result += ' End = ' + str(self._END)
        result += ' CHILD = ' + str(self._CHILD)
        result += ' SIBLING = ' + str(self._SIBLING)
        result += ' PARENT = ' + str(self._PARENT)
        result += "\n"
        return result



def m_S(state):
    return None

def ELEMENT(move):
    """ Returns the piece involved in a move """
    piece = None
    return piece

def X(move):
    """ Returns location where move originates """
    location = None
    return location

def Y(move):
    """ Returns location where move terminates """
    location = None
    return location

def q0(g_state):
    print "There was an error with GrammarState being", g_state

def q1(g_state, inputString):
    _q1 = True
    if _q1: 
        #--S(i) -> A(i)
        _S_i_re = re.compile('S\((?P<si>[0-9]+)\)')
        isGroup = _S_i_re.search(inputString)
        g_state.setI(int(isGroup.group('si')))

        theNewString = inputString[:isGroup.start()]
        theNewString += "A(" + str(g_state.getI()) + ")"
        theNewString += inputString[isGroup.end():]

        #--formulas for G s
        theNewG_state = g_state

        return q2(theNewG_state, theNewString)

    else:
        q0(g_state)
        return (g_state, inputString)

def q2_gs(g_state, inputString):
    """
      So right now I get that these are all safeguards, and that
      The Grammar it's self will generate the transitions, but
      I can simulate all of that to make sure that there are good moves,
      and all I really care about is that CUT returns True.
    """
    return not CUT(g_state)

    signAndTeam = True
    onSpot = True
    canReach = True
    distLessThanMax = True
    # q2_gs = (Ep Ex Ey (
    #for p in range(7):
     #for x in range(65):
     #for y in range(65):
        #                        ( ((SIGN =  1) and (p in P_1)) or 
        #                          ((SIGN = -1) and (p in P_2)) ) 
     #   signAndTeam = (g_state.getSIGN() == 1  and p in g_state.getSTATE['P_1']) or \
     #                 (g_state.getSIGN() == -1 and p in g_state.getSTATE['P_2'])
        #                        and ( ON(p) = x) and (R_p(x,y)) 
     #   onSpot = g_state.getSTATE['ON_p_' + str(p)] == g_state.getSTATE['x_' + str(x)]
     #   canReach = g_state.getSTATE['R_p_' + str(p)]
        #                        and (d < dmax) 
     #   distLessThanMax = C.distance(g_state.getSTATE['p_' + str(p)], C.indexToLocation(x), C.indexToLocation(y)) < g_state.getD
        #                        and not CUT(g_state, inputString)
        #                      ))
    notCUT = CUT(g_state)
    return all([onSpot, canReach, distLessThanMax, notCUT])



def q2(g_state, inputString):
    _q2_gs = q2_gs(g_state, inputString)
    if _q2_gs: 
        #--A(i) -> A(End)_pi_(End)A(i)
        _A_i_re = re.compile('A\((?P<ai>[0-9]+)\)')
        isGroup = _A_i_re.search(inputString)
        g_state.setI(int(isGroup.group('ai')))

        #Parent(End) := i 
        g_state.setPARENT(g_state.getEND(), g_state.getI())
        #    If Child(i) /= 0
        if g_state.getI() != 0:
            # then
            #    Sibling(Child(i)):=End
            g_state.setSIBLING(g_state.getCHILD(g_state.getI()), g_state.getEND())
        else:
            #    Sibling(i):= 0
            g_state.setSIBLING(g_state.getI(), 0)
        #Endif
        #Child(i):=End
        g_state.setCHILD(g_state.getI(), g_state.getEND())
        #End:=End+1
        g_state.setEND(g_state.getEND() + 1)

        # here starts for the GS in lecture 19
        #d := d+1
        g_state.setD(g_state.getD() + 1)
        #SIGN := -SIGN
        g_state.setSIGN(g_state.getSIGN() * (-1))
        
        
        NEWSTATE = "" #TRANSITION(Element(NEWMOVE), X(NEWMOVE), Y(NEWMOVE)) (STATE) 
        #STATE := NEWSTATE
        g_state.setSTATE = NEWSTATE
        #m(End) := m_S (NEWSTATE)
        g_state.setM(g_state.getEND(), m_S(NEWSTATE))
        #V(End) := BIG_NUMBER * SIGN
        g_state.setV(g_state.getEND(), g_state.BIG_NUMBER * g_state.getSIGN())


        NEWMOVE = "" # MV Grs (d, End, SIGN, m, V, WHO, FROM, TO, Child, Parent, Sibling, STATE, ...)
        #              MV yields the ordinal of a triple from the list MOVE

        #WHO(End) := Element(NEWMOVE)
        g_state.setWHO(g_state.getEND(), ELEMENT(NEWMOVE))
        #FROM(End) := X(NEWMOVE)
        g_state.setFROM(g_state.getEND(), X(NEWMOVE))
        #TO(End) := Y(NEWMOVE)
        g_state.setTO(g_state.getEND(), Y(NEWMOVE))
        
        #formulas for G s 

        theNewString = inputString[:isGroup.start()]
        theNewString += "A(" + str(g_state.getEND()) + ")"
        theNewString += "pi(" + str(g_state.getEND()) + ")"
        theNewString += "A(" + str(g_state.getI()) + ")"
        theNewString += inputString[isGroup.end():]

        return (g_state, theNewString)
        return q2(g_state, theNewString)

    else:
        return q3(g_state, inputString)


def q3(g_state, inputString):
    _q3 = True
    if _q3: 
        #--A(i) -> e
        _A_i_re = re.compile('A\((?P<ai>[0-9]+)\)')
        isGroup = _A_i_re.search(inputString)
        g_state.setI(int(isGroup.group('ai')))

        theNewString = inputString[:isGroup.start()]
        theNewString += inputString[isGroup.end():]

        #--formulas for G s
        theNewG_state = g_state

        return (g_state, theNewString)

    else:
        q0(g_state)
        return (g_state, inputString)

def movePiece(g_state, piece, start, dest, zone):
    print "locations before move", [C.indexToChessLocation(g_state.getSTATE()["ON_p_" + str(x)]) for x in range(1,7)]
    STATE = g_state.getSTATE()
    zoneList = []
    for z in g_state.getZONES():
        if z != zone: zoneList.append(z)
    pieceNumber = 0
    for x in range(1,7): 
        if STATE["p_" + str(x)] == piece: 
            pieceNumber = x

    # error check
    if pieceNumber == 0:
        print "Could not find pice in state"
        return g_state

    if STATE['ON_p_' + str(pieceNumber)] != C.locationToIndex(start):
        print "p_" + str(pieceNumber) + " is not on " + str(start)
        return g_state
    x,y = dest
    if not STATE['Rp_' + str(pieceNumber) + "_" + str(x) + str(y)]:
        print "p_" + str(pieceNumber) + " cannot reach " + str(dest)
        print 'Rp_' + str(pieceNumber) + "_" + str(x) + str(y) + ' = ' + str(STATE['Rp_' + str(pieceNumber) + "_" + str(x) + str(y)]) 
        return g_state

    STATE['ON_p_' + str(pieceNumber)] = STATE["x_" + str(C.locationToIndex(dest))]  
    g_state.setSTATE(STATE)
    print "----------SOURCE-DEST------------"
    print C.locationToChessLocation(start), C.locationToChessLocation(dest)
    print "----------ZONE------------"
    print zone
    zone = T.transition(T.objectify(zone), piece, C.locationToChessLocation(start), C.locationToChessLocation(dest))
    zone = T.stringify(zone)
    print zone
    zoneList.append(zone)
    print "----------ZONE------------"

    setR(g_state)
    g_state.setZONES(zoneList)

    
    print "locations after move", [C.indexToChessLocation(g_state.getSTATE()["ON_p_" + str(x)]) for x in range(1,7)]
    return g_state

def MV(g_state, turn, zones):
    """
    This is the big one.
    turn in {"P1", "P2"}
    """
    pieces = g_state.getSTATE()[turn]
    As = []
    Bs = []
    for piece in pieces:
        for zone in zones:
            snagged = T.snagBs(piece,zone)
            for s in snagged:
                if len(s) == 0: continue
                if s[0] == 'a': As.append((piece, zone, nextMovesToList(s)))
                if s[0] == 'B': 
                    for x in nextMovesToList(B(g_state, piece, s)):
                        if x: Bs.append((piece, zone, x)) 
    return [x[0] for x in Counter(As).most_common()] + [x[0] for x in Counter(Bs).most_common()]


def getPieceNumber(g_state, piece):
    pieceNumber = 0
    for x in range(1,7): 
        if g_state.getSTATE()["p_" + str(x)] == piece: 
            print "p_" + str(x)
            pieceNumber = x
    return pieceNumber


def main(): 
    g_state = GrammarState()
    g_state.setZONES([T.mainZone1, T.mainZone2])
    print "White Move"
    p2Moves =  MV(g_state, "P2", g_state.getZONES())
    theMove = p2Moves[0]
    print "White will move ", str(theMove)
    piece = theMove[0]
    dest = C.chessLocationToLocation(theMove[2])

    pieceNumber = getPieceNumber(g_state, piece)

    source = C.indexToLocation(g_state.getSTATE()["ON_p_" + str(pieceNumber)])
    g_state = movePiece(g_state,theMove[0],source,dest, theMove[1])
    print "new white moves"
    p2Moves =  MV(g_state, "P2", g_state.getZONES())

    print
    print "Black Move"
    p1Moves =  MV(g_state, "P1", g_state.getZONES())
    from pprint import pprint
    pprint(p1Moves)
    print




    """
    movePiece(g_state,"WF",C.chessLocationToLocation("h8"),C.chessLocationToLocation("g7"))
    print B(g_state, "WF", "B(g7:h1)")
    print nextMovesToList(B(g_state, "WF", "B(g7:h1)"))
    """
    """
    inputString = "S(0)"
    print "before Start"
    print g_state, inputString
    print 'one loop'
    theNewG_state , theNewString = q1(g_state, inputString)
    print theNewG_state, theNewString
    print 'two loop'
    theNewG_state , theNewString = q2(theNewG_state, theNewString)
    print theNewG_state, theNewString
    print 'three loop'
    theNewG_state , theNewString = q3(theNewG_state, theNewString)
    print theNewG_state, theNewString
    print 'two loop'
    theNewG_state , theNewString = q2(theNewG_state, theNewString)
    print theNewG_state, theNewString
    """


if __name__ == "__main__" :
    main()
