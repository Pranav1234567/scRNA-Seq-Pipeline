#!/bin/bash

#${1} = ${COUNTS}
#${2} = alignment name

cd
cd Documents/scripts
typeset -i NUMCELLS=$(cat tempB.txt)

#Converts big matrix text file into csv

Rscript formatMatrix.R ${1} ${2} $NUMCELLS

cd ${1}/${2}
cut -d , -f 2- sample.csv > GeneExpressionMatrix.csv

cd ${1}/${2}

i=1
STRING="GENEID"
while((i<=$NUMCELLS))
do
	g="trimCounts_cell$i.txt"
        	if [ -s $g ]	
		then
			STRING+=", Cell${i}"
		fi
	((i+=1))
done

cd ${1}/${2}

sed -i.bak "1 s/^.*$/$STRING/" GeneExpressionMatrix.csv
