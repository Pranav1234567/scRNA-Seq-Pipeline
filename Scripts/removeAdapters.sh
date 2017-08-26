#!/bin/bash

NUMCELLS=$4

i=1
while ((i<=$NUMCELLS))
do
	for f in $(ls $1/Read1/cell.$i.fastq)
	do
		 for g in $(ls $1/Read2/cell.$i.fastq)
		do
			fastq-mcf $3 -q 20 -x 0.5 ${f} ${g} -o $2/Read1/trimCell.$i.fastq -o $2/Read2/trimCell.$i.fastq 		
		done
	done
((i+=1))
done

