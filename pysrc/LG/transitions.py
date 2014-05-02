#!/usr/local/bin/python2.7
    
# Simulating Zone Creation. B(x:y) represents the bundle from space x to y
#  The B function always chooses shortest path, and knows how long the trajectory
#  is if needed.  May or may not be implemented.
mainZone1 = "t(BB, a(h5)a(h4)a(h3)a(h2)a(h1), 7)t(WF, B(h8:h5), 3)t(WF, B(h8:h4), 4)t(WF, B(h8:h3), 5)t(WF, B(h8:h2), 6)t(WF, B(h8:h1), 7)"

mainZone2 = "t(WB, a(c6)a(c7)a(c8), 7)t(BF, B(a6:c6), 5)t(BF, B(a6:c7), 6)t(BF, B(a6:c8), 7)t(WF, B(h8:d6), 5)t(WF, B(h8:d7), 6)"

def objectify(zoneString):  # This makes the strings into the objects for this module
  return map((lambda x: x[1:-1].split(',')), filter((lambda x: x!=' '), zoneString).split('t'))[1:]

def stringify(zone):
  final = ""
  for t in zone: final += "t(" + t[0] + ", " + t[1] + ", " + t[2] + ")"
  return final

preZone1 =  objectify(mainZone1)
preZone2 =  objectify(mainZone2)


def transition(zone, piece, start, dest):
  if piece == zone[0][0]: # if moving piece is along main trajectory
    for t in zone:
      t[2] = str(int(t[2]) - 1) # decrease time for system
      if t[1][0] == 'B' and t[1][5:7] == start:
          print "should remove trajectory", t
#          t[1] = '!'

  for t in zone:
    if t[0] == piece:
      if t[1][0] == 'a':
        t[1] = t[1][5:]
      elif t[1][0] == 'B':
        t[1] = "B(" + dest + t[1][4:]
        t[2] = str(int(t[2]) + 0)

  return [z for z in zone if z[1] != '!']

def printZone(zone):
  print stringify(zone)
  return zone

def snagBs(piece, zone):
    return [move[1] for move in objectify(zone) if move[0] == piece]

#printZone(preZone1)
#printZone(transition(preZone1, "WF", '', 'g7'))
#printZone(transition(preZone1, "BB", '', ''))
#print snagBs("WF", mainZone1)
