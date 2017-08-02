#!/bin/bash

#$1 = ${COUNTS}
#$2 = name of alignment
#$3 = ${INFO}

i=1

typeset -i NUMCELLS=$(cat tempB.txt)

while((i <= $NUMCELLS))
do
        LINECOUNT=`cat ${1}/${2}/counts_cell$i.txt | grep -v ^$ | wc -l`
        let REMOVEFIVE=LINECOUNT-5
        head -n $REMOVEFIVE ${1}/${2}/counts_cell$i.txt > ${1}/${2}/trimCounts_cell$i.txt
        ((i+=1))
done
