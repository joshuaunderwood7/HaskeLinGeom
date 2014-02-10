HaskeLinGeom
============

A Linguistic Geometry Distance Table application written in Haskell

For this assignment, I have not completed the 3d board or the board
locations input.

I apologize for the crazy moon language.
I intended to do this assignment (and future assignments) in python,
but when running this program it took about 5 seconds to run the python
program and .014s to run the Haskell program.

So I intend to use the Haskell program to generate the tables, and use python to
do the other less time consuming pieces. I hope.


How to run
----------

I am using:
joshua@OldnTired:~$ ghc -V
The Glorious Glasgow Haskell Compilation System, version 7.6.3

I am also running Ubuntu 13.10.

to install the haskell platform I ran
joshua@OldnTired:~$ sudo apt-get install haskell-platform

(this will bring in most of the core libraries,
runghc (which is an interpreter), ghci (the REPL),
and ghc (the compiler) )

Ubuntu comes with make.

so from the command line simply un-tar the file and
run make and it should produce ./compiled/Distance

There is an included one, but it was compiled for my system and it may
or may not run on another system.

---

How this works is:
------------------

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
