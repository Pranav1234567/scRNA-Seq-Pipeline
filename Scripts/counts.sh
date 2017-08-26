#!/bin/bash

#$1 = ${ALIGN}
#$2 = ${INDEX}
#$3 = which alignment name
#$4 = ${COUNTS}
#$5 = ${INFO}
#$6 = $NUMCELLS
#$7 = ${GENES_DIR}

i=1
mkdir ${4}/${3}

while((i <= $6))
do
    htseq-count --quiet --format=bam --stranded=reverse --idattr=gene_id ${1}/${3}/cell$i/sorted_output.bam ${7}/genes.gtf > ${4}/${3}/counts_cell$i.txt	
    ((i+=1))
done

echo "DONE"

#Removes the last 5 lines of each counts file
chmod 777 cutlines.sh
./cutlines.sh ${4} ${3} ${5} ${6}

#Converts the counts files into one big matrix text file
chmod 777 combineCol.sh
./combineCol.sh ${4} ${3} ${6}

#Converts big matrix text file into csv

./formatMatrix.sh ${4} ${3} ${6}

echo "outputted GENE EXPRESSION MATRIX"

rm tempA.txt tempB.txt
