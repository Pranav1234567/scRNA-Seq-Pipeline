#!/bin/bash

NUMCELLS=$5

i=1
while ((i<=$NUMCELLS))
do
	for f in $(ls $1/$(basename ${3}_1)/cell.$i.fastq)
	do
		 for g in $(ls $1/$(basename ${3}_2)/cell.$i.fastq)
		do
			fastq-mcf $4 -q 20 -x 0.5 ${f} ${g} -o $2/$(basename ${3}_1)/trimCell.$i.fastq -o $2/$(basename ${3}_2)/trimCell.$i.fastq 		
		done
	done
((i+=1))
done
