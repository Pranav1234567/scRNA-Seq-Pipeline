#!/bin/bash

#$1 = ${ALIGN}
#$2 = ${REF}
#$3 = which alignment name
#$4 = ${COUNTS}
#$5 = ${INFO}

i=1

cd
cd Documents/scripts
chmod 777 getNumCells.txt
./getNumCells.txt ${5}/barcodes.tab
typeset -i NUMCELLS=$(cat tempB.txt)

mkdir ${4}/${3}

while((i <= $NUMCELLS))
do
    mkdir ${4}/${3}/cell$i
    mkdir ${1}/${3}/cell$i 
    samtools sort -n --threads 8 -o ${1}/${3}/cell$i/sorted_output.bam ${1}/${3}/cell$i/output.bam		
    htseq-count --quiet --format=bam --stranded=reverse --idattr=gene_id ${1}/${3}/cell$i/sorted_output.bam ${2}/Mus_musculus_UCSC_mm10/Mus_musculus/UCSC/mm10/Annotation/Genes/genes.gtf > ${4}/${3}/counts_cell$i.txt	
    ((i+=1))
done
