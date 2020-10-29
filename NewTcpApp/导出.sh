#!/bin/bash
echo "please enter a file name"
read NAME
find ./ -name "*.m" | xargs cat > $NAME.txt
cat $NAME.txt |tr -s '\n' > temp; mv temp $NAME.txt
echo "******************end*******************"
