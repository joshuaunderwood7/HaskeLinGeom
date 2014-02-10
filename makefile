all:
	#ghc Main.hs -threaded -O -with-rtsopts="-N -s" -o compiled/Distance
	#ghc Main.hs -threaded -O -o compiled/Distance
	#ghc Main.hs -threaded -o compiled/DistanceNoOpt
	ghc Main.hs -O -o compiled/Distance
	rm *.hi *.o
	strip compiled/Distance
