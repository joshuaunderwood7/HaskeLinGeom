import re
import LG.Piece as P
import LG.Board as B


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

# initialize P1 and P2
INITIAL_STATE["P1"] = set([INITIAL_STATE['p_1'], INITIAL_STATE['p_2']])
INITIAL_STATE["P2"] = set([INITIAL_STATE['p_3'], INITIAL_STATE['p_4']])


def Rp_1():
    x1 = 1
    x2 = 2
    for i in range(8):
        for j in range(8):
            INITIAL_STATE["Rp_1" + str(i) + str(j)] = P.r_pB(B.Location(x=x1,y=x2),B.Location(x=i+1,y=j+1))

print INITIAL_STATE


class GrammarState():
    def __init__(self):
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
        self._STATE = ""
        self.BIG_NUMBER = 256

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
    """ q2_gs = (Ep Ex Ey (
                            ( ((SIGN =  1) and (p in P_1)) or 
                              ((SIGN = -1) and (p in P_2)) ) 
                            and ( ON(p) = x) and (R_p(x,y)) 
                            and (d < dmax) 
                            and not CUT(g_state, inputString)
                          ))
    """
    return True



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

def main(): 
    g_state = GrammarState()
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

if __name__ == "__main__" :
    main()
