make
rm kingpic.dot
cp ./files/chesstemplate.dot ./kingpic.dot
./compiled/Distance >> kingpic.dot
dot -Kfdp -n -Tpng -o kingpic.png ./kingpic.dot
display ./kingpic.png
