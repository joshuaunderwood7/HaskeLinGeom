HaskeLinGeom
============

1) ./compiled/GrammarOfZones 

This is an impilentation for zone generation.

At thee moment it only will compute first negations.

2) ./compiled/Distance

This program will generate trajectory bundles and create Distance tables


How to run
----------

I am using:
joshua@OldnTired:~$ ghc -V
The Glorious Glasgow Haskell Compilation System, version 7.6.3

The Directed graphs require Dot and Graphviz
Also display is used to show .png files.

I am also running Ubuntu 13.10.
joshua@OldnTired:~$ dot -V
dot - graphviz version 2.26.3 (20100126.1600)


to install the haskell platform I ran
joshua@OldnTired:~$ sudo apt-get install haskell-platform

to install the dot and graphviz I ran
joshua@OldnTired:~$ sudo apt-get install graphviz

(this will bring in most of the core libraries,
runghc (which is an interpreter), ghci (the REPL),
and ghc (the compiler). Graphviz is needed to generate
the directed graph images. )

Ubuntu comes with make and display.

so from the command line simply un-tar the file and
run make and it should produce ./compiled/Distance

There is an included one, but it was compiled for my system and it may
or may not run on another system.

---

How this works is:
------------------

The newest edition is the Network Generation.

from the command line run

user@system:~$ ./compiled/GrammarOfZones

The output will be TIME table for the main trajectory and a set of trajectories
that represent the network.

Each trajectory is printed on it's own line for clarity, but know that they are
only printed this way to be easier to read.

These networks only have first negations right now. second negations coming.


from the command line run

user@system:~$ ./compiled/Distance "table name" Color Rank X_location Y_location 1 {Obstacle_X_location Obstacle_Y_location 1}

The part in the {} is optional and may be repeated as much as needed
Locations start with 1,1 on the bottom right.  There is no Z coordinate yet, but I am working on that.

for example a rook, with obstacles at (4,7), (4,2), and  (5,4):
compiled/Distance "Rook" Black Rook 4 4 1 4 7 1 4 2 1 5 4 1

will yield:
Rook
3 3 3 3 3 3 3 3 2 2 2 2 2 2 2
3 3 3 3 3 3 3 3 2 2 2 2 2 2 2
3 3 3 3 3 3 3 3 2 2 2 2 2 2 2
3 3 3 3 3 3 3 3 2 2 2 2 2 2 2
3 3 3 3 3 3 3 # 2 2 2 2 2 2 2
2 2 2 2 2 2 2 1 2 2 2 2 2 2 2
2 2 2 2 2 2 2 1 2 2 2 2 2 2 2
3 3 3 3 3 3 # 0 1 1 1 1 1 1 1
2 2 2 2 2 2 2 1 2 2 2 2 2 2 2
3 3 3 3 3 3 3 # 2 2 2 2 2 2 2
3 3 3 3 3 3 3 3 2 2 2 2 2 2 2
3 3 3 3 3 3 3 3 2 2 2 2 2 2 2
3 3 3 3 3 3 3 3 2 2 2 2 2 2 2
3 3 3 3 3 3 3 3 2 2 2 2 2 2 2
3 3 3 3 3 3 3 3 2 2 2 2 2 2 2

I have included a BASH script to run this
called Project1.sh

The printout of each piece:
---------------------------

compiled/Distance "Black_Pawn" Black Pawn 4 7 1
Black_Pawn
X X X X X X X X X X X X X X X
X X X X X X X X X X X X X X X
X X X X X X X X X X X X X X X
X X X X X X X X X X X X X X X
X X X X X X X X X X X X X X X
X X X X X X X X X X X X X X X
X X X X X X X X X X X X X X X
X X X X X X X 0 X X X X X X X
X X X X X X X 1 X X X X X X X
X X X X X X X 2 X X X X X X X
X X X X X X X 3 X X X X X X X
X X X X X X X 4 X X X X X X X
X X X X X X X 5 X X X X X X X
X X X X X X X 6 X X X X X X X
X X X X X X X 7 X X X X X X X

compiled/Distance "Black_Pawn" White Pawn 4 2 1
Black_Pawn
X X X X X X X 7 X X X X X X X
X X X X X X X 6 X X X X X X X
X X X X X X X 5 X X X X X X X
X X X X X X X 4 X X X X X X X
X X X X X X X 3 X X X X X X X
X X X X X X X 2 X X X X X X X
X X X X X X X 1 X X X X X X X
X X X X X X X 0 X X X X X X X
X X X X X X X X X X X X X X X
X X X X X X X X X X X X X X X
X X X X X X X X X X X X X X X
X X X X X X X X X X X X X X X
X X X X X X X X X X X X X X X
X X X X X X X X X X X X X X X
X X X X X X X X X X X X X X X

compiled/Distance "Rook" Black Rook 4 1 1
Rook
2 2 2 2 2 2 2 1 2 2 2 2 2 2 2
2 2 2 2 2 2 2 1 2 2 2 2 2 2 2
2 2 2 2 2 2 2 1 2 2 2 2 2 2 2
2 2 2 2 2 2 2 1 2 2 2 2 2 2 2
2 2 2 2 2 2 2 1 2 2 2 2 2 2 2
2 2 2 2 2 2 2 1 2 2 2 2 2 2 2
2 2 2 2 2 2 2 1 2 2 2 2 2 2 2
1 1 1 1 1 1 1 0 1 1 1 1 1 1 1
2 2 2 2 2 2 2 1 2 2 2 2 2 2 2
2 2 2 2 2 2 2 1 2 2 2 2 2 2 2
2 2 2 2 2 2 2 1 2 2 2 2 2 2 2
2 2 2 2 2 2 2 1 2 2 2 2 2 2 2
2 2 2 2 2 2 2 1 2 2 2 2 2 2 2

compiled/Distance "Knight" Black Knight 4 1 1
Knight
6 5 4 5 4 5 4 5 4 5 4 5 4 5 6
5 4 5 4 3 4 3 4 3 4 3 4 5 4 5
4 5 4 3 4 3 4 3 4 3 4 3 4 5 4
5 4 3 4 3 2 3 2 3 2 3 4 3 4 5
4 3 4 3 2 3 2 3 2 3 2 3 4 3 4
5 4 3 2 3 4 1 2 1 4 3 2 3 4 5
4 3 4 3 2 1 2 3 2 1 2 3 4 3 4
5 4 3 2 3 2 3 0 3 2 3 2 3 4 5
4 3 4 3 2 1 2 3 2 1 2 3 4 3 4
5 4 3 2 3 4 1 2 1 4 3 2 3 4 5
4 3 4 3 2 3 2 3 2 3 2 3 4 3 4
5 4 3 4 3 2 3 2 3 2 3 4 3 4 5
4 5 4 3 4 3 4 3 4 3 4 3 4 5 4
5 4 5 4 3 4 3 4 3 4 3 4 5 4 5
6 5 4 5 4 5 4 5 4 5 4 5 4 5 6

compiled/Distance "Bishop" Black Bishop 4 1 1
Bishop
1 X 2 X 2 X 2 X 2 X 2 X 2 X 1
X 1 X 2 X 2 X 2 X 2 X 2 X 1 X
2 X 1 X 2 X 2 X 2 X 2 X 1 X 2
X 2 X 1 X 2 X 2 X 2 X 1 X 2 X
2 X 2 X 1 X 2 X 2 X 1 X 2 X 2
X 2 X 2 X 1 X 2 X 1 X 2 X 2 X
2 X 2 X 2 X 1 X 1 X 2 X 2 X 2
X 2 X 2 X 2 X 0 X 2 X 2 X 2 X
2 X 2 X 2 X 1 X 1 X 2 X 2 X 2
X 2 X 2 X 1 X 2 X 1 X 2 X 2 X
2 X 2 X 1 X 2 X 2 X 1 X 2 X 2
X 2 X 1 X 2 X 2 X 2 X 1 X 2 X
2 X 1 X 2 X 2 X 2 X 2 X 1 X 2
X 1 X 2 X 2 X 2 X 2 X 2 X 1 X
1 X 2 X 2 X 2 X 2 X 2 X 2 X 1

compiled/Distance "Queen" Black Queen 4 1 1
Queen
1 2 2 2 2 2 2 1 2 2 2 2 2 2 1
2 1 2 2 2 2 2 1 2 2 2 2 2 1 2
2 2 1 2 2 2 2 1 2 2 2 2 1 2 2
2 2 2 1 2 2 2 1 2 2 2 1 2 2 2
2 2 2 2 1 2 2 1 2 2 1 2 2 2 2
2 2 2 2 2 1 2 1 2 1 2 2 2 2 2
2 2 2 2 2 2 1 1 1 2 2 2 2 2 2
1 1 1 1 1 1 1 0 1 1 1 1 1 1 1
2 2 2 2 2 2 1 1 1 2 2 2 2 2 2
2 2 2 2 2 1 2 1 2 1 2 2 2 2 2
2 2 2 2 1 2 2 1 2 2 1 2 2 2 2
2 2 2 1 2 2 2 1 2 2 2 1 2 2 2
2 2 1 2 2 2 2 1 2 2 2 2 1 2 2
2 1 2 2 2 2 2 1 2 2 2 2 2 1 2
1 2 2 2 2 2 2 1 2 2 2 2 2 2 1

compiled/Distance "King" Black King 4 1 1
King
7 7 7 7 7 7 7 7 7 7 7 7 7 7 7
7 6 6 6 6 6 6 6 6 6 6 6 6 6 7
7 6 5 5 5 5 5 5 5 5 5 5 5 6 7
7 6 5 4 4 4 4 4 4 4 4 4 5 6 7
7 6 5 4 3 3 3 3 3 3 3 4 5 6 7
7 6 5 4 3 2 2 2 2 2 3 4 5 6 7
7 6 5 4 3 2 1 1 1 2 3 4 5 6 7
7 6 5 4 3 2 1 0 1 2 3 4 5 6 7
7 6 5 4 3 2 1 1 1 2 3 4 5 6 7
7 6 5 4 3 2 2 2 2 2 3 4 5 6 7
7 6 5 4 3 3 3 3 3 3 3 4 5 6 7
7 6 5 4 4 4 4 4 4 4 4 4 5 6 7
7 6 5 5 5 5 5 5 5 5 5 5 5 6 7
7 6 6 6 6 6 6 6 6 6 6 6 6 6 7
7 7 7 7 7 7 7 7 7 7 7 7 7 7 7
