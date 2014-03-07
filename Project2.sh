#!/bin/bash

#make the project
make

#all obsicals are at c3, d3:6, e3:6, f4:5
OBST=" 6 3 0 5 3 1 5 4 1 5 5 1 5 6 1 4 3 1 4 4 1 4 5 1 4 6 1 3 4 1 3 5 1 "
STARTA=" 3 2 1 "
STARTB=" 6 4 1 "
ENDA=" 3 6 1 "
ENDB="6 6 1 "

#draw the graphs
#king from f3 -> f6
echo 'King'
./compiled/Distance ACCEPTABLEBUNDLESTRING \"\" Black King $STARTA $ENDA 5 $OBST
./compiled/Distance ACCEPTABLEBUNDLE \"\" Black King $STARTA $ENDA 5 $OBST>> king.dot
dot -Kfdp -n -Tpng -o king.png ./king.dot

echo 'Knight'
./compiled/Distance ACCEPTABLEBUNDLESTRING \"\" Black Knight $STARTA $ENDA 4 $OBST
./compiled/Distance ACCEPTABLEBUNDLE \"\" Black Knight $STARTA $ENDA 4 $OBST>> knight.dot
dot -Kfdp -n -Tpng -o knight.png ./knight.dot

echo 'Bishop'
./compiled/Distance ACCEPTABLEBUNDLESTRING \"\" Black Bishop $STARTA $ENDA 3 $OBST
./compiled/Distance ACCEPTABLEBUNDLE \"\" Black Bishop $STARTA $ENDA 3 $OBST>> bishop.dot
dot -Kfdp -n -Tpng -o bishop.png ./bishop.dot

echo 'Rook'
./compiled/Distance ACCEPTABLEBUNDLESTRING \"\" Black Rook $STARTA $ENDA 4 $OBST
./compiled/Distance ACCEPTABLEBUNDLE \"\" Black Rook $STARTA $ENDA 4 $OBST>> rook.dot
dot -Kfdp -n -Tpng -o rook.png ./rook.dot

echo 'Queen'
./compiled/Distance ACCEPTABLEBUNDLESTRING \"\" Black Queen $STARTB $ENDB 2 $OBST
./compiled/Distance ACCEPTABLEBUNDLE \"\" Black Queen $STARTB $ENDB 2 $OBST>> queen.dot
dot -Kfdp -n -Tpng -o queen.png ./queen.dot

echo 'Pawn'
./compiled/Distance ACCEPTABLEBUNDLESTRING \"\" Black Pawn $STARTB $ENDB 3 $OBST
./compiled/Distance ACCEPTABLEBUNDLE \"\" Black Pawn $STARTB $ENDB 3 $OBST>> pawn.dot
dot -Kfdp -n -Tpng -o pawn.png ./pawn.dot

echo 'Underwood piece'
./compiled/Distance ACCEPTABLEBUNDLESTRING \"\" Black Underwood $STARTA $ENDA 5 $OBST
./compiled/Distance ACCEPTABLEBUNDLE \"\" Black Underwood $STARTA $ENDA 5 $OBST>> underwood.dot
dot -Kfdp -n -Tpng -o underwood.png ./underwood.dot

#clean up the temp files
rm king.dot
rm knight.dot
rm bishop.dot
rm rook.dot
rm queen.dot
rm pawn.dot
rm underwood.dot
# Here to display
display ./king.png
display ./knight.png
display ./bishop.png
display ./rook.png
display ./queen.png
display ./pawn.png
display ./underwood.png

echo 'Show King from a5 to h5'
./compiled/Distance ACCEPTABLEBUNDLESTRING \"\" Black King 8 5 1 1 5 1 7 >> a5h5traj.txt
./compiled/Distance ACCEPTABLEBUNDLE \"\" Black King 8 5 1 1 5 1 7 >> king.dot
dot -Kfdp -n -Tpng -o king2.png ./king.dot
rm king.dot
cat a5h5traj.txt
wc -l a5h5traj.txt
rm a5h5traj.txt
display ./king2.png
