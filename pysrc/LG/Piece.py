import R
import Board

class Piece:
    def __init__(self):
        self.xPos = 0
        self.yPos = 0
        self.zPos = 0
        self.xVel = 0
        self.yVel = 0
        self.zVel = 0
        self.color = 'grey'
        self.rank = 'none'
        self.board = Board.chessboard

    def setBoard(self, board):
        self.board = board

    def makePiece(self, color, rank, location):
        self.xPos = location.x
        self.yPos = location.y
        self.zPos = location.z
        self.rank = rank
        self.color = color
        return self

    def movement(self, y):
        if(self.rank.upper()=='PAWN' and self.color.upper()=="BLACK"):
            return R.MakeRForBoard(self.board)(R.r_pB, Board.Location(self.xPos, self.yPos, self.zPos), y)
        elif(self.rank.upper()=='PAWN' and self.color.upper()=="WHITE"):
            return R.MakeRForBoard(self.board)(R.r_pW, Board.Location(self.xPos, self.yPos, self.zPos), y)
        elif(self.rank.upper()=='BISHOP'):
            return R.MakeRForBoard(self.board)(R.r_b, Board.Location(self.xPos, self.yPos, self.zPos), y)
        elif(self.rank.upper()=='KNIGHT'):
            return R.MakeRForBoard(self.board)(R.r_n, Board.Location(self.xPos, self.yPos, self.zPos), y)
        elif(self.rank.upper()=='ROOK'):
            return R.MakeRForBoard(self.board)(R.r_r, Board.Location(self.xPos, self.yPos, self.zPos), y)
        elif(self.rank.upper()=='QUEEN'):
            return R.MakeRForBoard(self.board)(R.r_q, Board.Location(self.xPos, self.yPos, self.zPos), y)
        elif(self.rank.upper()=='KING'):
            return R.MakeRForBoard(self.board)(R.r_k, Board.Location(self.xPos, self.yPos, self.zPos), y)
        else: return False


    def __repr__(self):
        returnString =  self.color + " " +\
                        self.rank + " at (" + \
                        str(self.xPos) + "," + str(self.yPos) + ")"
        return returnString

    def __eq__(self, other):
        return (isinstance(other, self.__class__) and self.__dict__ == other.__dict__)

    def __ne__(self, other):
        return not self.__eq__(other)

    def __hash__(self):
        return hash(str(self))

