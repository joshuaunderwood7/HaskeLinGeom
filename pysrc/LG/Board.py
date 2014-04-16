class Location:
    def __init__(self, x=1, y=1, z=1):
        self.x = x
        self.y = y
        self.z = z

    def parseStr(self, inStr):
        inStr = inStr[1:-1]
        inStr = inStr.split(',')
        self.x = int(inStr[0])
        self.y = int(inStr[1])
        self.z = int(inStr[2])

    def arrayShift(self):
        self.x-=1
        self.y-=1
        self.z-=1
        return self

    def shiftBack(self):
        self.x+=1
        self.y+=1
        self.z+=1
        return self

    def __repr__(self):
        return '(' + str(self.x) + ', ' + \
               str(self.y) + ', ' + \
               str(self.z) + ')'

    def __eq__(self, other):
        return (isinstance(other, self.__class__) and self.__dict__ == other.__dict__)

    def __ne__(self, other):
        return not self.__eq__(other)

    def __hash__(self):
        return hash(str(self))


class Board:
    def __init__(self, minx=1, maxx=1, miny=1, maxy=1, minz=1, maxz=1):
        """Default board is 1x1x1 and filled with #'s"""
        self.minX = minx
        self.maxX = maxx
        self.minY = miny
        self.maxY = maxy
        self.minZ = minz
        self.maxZ = maxz
        self.locations = set()
        for loc in [ (x,y,z) for z in range(minz, maxz+1) for y in range(miny, maxy+1) for x in range(minx, maxx+1)]:
            self.locations.add(loc)

    def fill(self, locations):
        """give a Location to assign to each square"""
        self.locations.union(locations)
        return self

    def canAccess(self, location):
        return (location in self.locations)

    def get(self, location):
        if self.canAccess(location):
            return  '#'
        return ''


    def set(self, location):
        self.locations.add(location)
        return self

    def rangeOfX(self):
        """Return an eager list of X values"""
        return range(self.minX, self.maxX+1)
    def rangeOfY(self):
        """Return an eager list of Y values"""
        return range(self.minY, self.maxY+1)
    def rangeOfZ(self):
        """Return an eager list of Z values"""
        return range(self.minZ, self.maxZ+1)

    def __repr__(self):
        returnString = "loacations = set("
        for loc in self.locations:
            returnString += srt(loc) + ", "
        returnString += ")"
        return returnString

    def __eq__(self, other):
        return (isinstance(other, self.__class__) and self.__dict__ == other.__dict__)

    def __ne__(self, other):
        return not self.__eq__(other)

    def getDistanceboard(self):
        return Board(maxx=((self.maxX*2)-1), maxy=((self.maxY*2)-1), maxz=((self.maxZ*2)-1))

    def middle(self):
        """Only returns approximate middle of the distance Board"""
        return Location(self.maxX, self.maxY, self.maxZ)

chessboard    = Board(maxx= 8, maxy=8)
distanceboard = chessboard.getDistanceboard()
chessboard3D  = Board(maxx= 8, maxy=8, maxz=8)

