#!/bin/bash

#$1 = ${COUNTS}
#$2 = ${alignment name}
#$3 = $NUMCELLS

i=2

cd ${1}/${2}

cat trimCounts_cell1.txt > matrix1.txt

while ((i<=$3))
do
	j=$((i-1))
	f="matrix$j.txt"
	g="trimCounts_cell$i.txt"
	if [ -s $g ]
	then
		join $f $g > matrix$i.txt
	else 
		cat matrix$((i-1)).txt > matrix$i.txt 
	fi
	((i+=1))
done

j=1

while ((j<=$3 - 1))
do
	rm matrix$j.txt
	((j+=1))
done

k=1

while ((k <= $3))
do
	rm trimCounts_cell$k.txt
	((k+=1))
done


