all:
	ghc Main.hs -threaded -O -with-rtsopts="-N" -o compiled/Distance
	rm *.hi *.o
	strip compiled/Distance
