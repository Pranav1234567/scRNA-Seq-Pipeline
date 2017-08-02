#!/bin/bash

#$1 = ${COUNTS}
#$2 = ${alignment name}

#paste counts_cell1.txt counts_cell2.txt counts_cell3.txt counts_cell4.txt counts_cell5.txt counts_cell6.txt counts_cell7.txt counts_cell8.txt counts_cell9.txt counts_cell10.txt counts_cell11.txt counts_cell12.txt counts_cell13.txt counts_cell14.txt counts_cell15.txt counts_cell16.txt counts_cell17.txt counts_cell18.txt counts_cell19.txt counts_cell20.txt counts_cell21.txt counts_cell22.txt counts_cell23.txt counts_cell24.txt counts_cell25.txt counts_cell26.txt counts_cell27.txt counts_cell28.txt counts_cell29.txt counts_cell30.txt counts_cell31.txt counts_cell32.txt counts_cell33.txt counts_cell34.txt counts_cell35.txt counts_cell36.txt counts_cell37.txt counts_cell38.txt counts_cell39.txt counts_cell40.txt counts_cell41.txt counts_cell42.txt counts_cell43.txt counts_cell44.txt counts_cell45.txt counts_cell46.txt counts_cell47.txt counts_cell48.txt counts_cell49.txt counts_cell50.txt counts_cell51.txt counts_cell52.txt counts_cell53.txt counts_cell54.txt counts_cell55.txt counts_cell56.txt counts_cell57.txt counts_cell58.txt counts_cell59.txt counts_cell60.txt counts_cell61.txt counts_cell62.txt counts_cell63.txt counts_cell64.txt counts_cell65.txt counts_cell66.txt counts_cell67.txt counts_cell68.txt counts_cell69.txt counts_cell70.txt counts_cell71.txt counts_cell72.txt counts_cell73.txt counts_cell74.txt counts_cell75.txt counts_cell76.txt counts_cell77.txt counts_cell78.txt counts_cell79.txt counts_cell80.txt counts_cell81.txt counts_cell82.txt counts_cell83.txt counts_cell84.txt counts_cell85.txt counts_cell86.txt counts_cell87.txt counts_cell88.txt counts_cell89.txt counts_cell90.txt counts_cell91.txt counts_cell92.txt counts_cell93.txt counts_cell94.txt counts_cell95.txt counts_cell96.txt| column -s $'\t' -t > counts_all_cells.csv

i=2

cd ${1}/${2}

cat trimCounts_cell1.txt > matrix1.txt


NUMCELLS=96

while ((i<=$NUMCELLS))
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

while ((j<=$NUMCELLS - 1))
do
	rm matrix$j.txt
	((j+=1))
done

while ((k <= $NUMCELLS))
do
	rm trimCounts_cell$k.txt
done


