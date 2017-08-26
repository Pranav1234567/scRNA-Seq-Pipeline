#!/bin/bash

#$1 = ${TRIM}
#$2 = ${INDEX}
#$3 = ${ALIGN}
#$4 = $NUMCELLS

mkdir ${3}/bwa

i=1
while ((i <= $4))
do
	for f in $(ls ${1}/Read2/trimCell.$i.fastq)
	do
		mkdir ${3}/bwa/cell$i
			
		echo "Beginning Alignment using BWA..."
		bwa mem -t 16 ${2}/BWAIndex/genome.fa ${f} > ${3}/bwa/cell$i/output.sam
		echo "DONE"
			
	done
		samtools view -bS ${3}/bwa/cell$i/output.sam > ${3}/bwa/cell$i/output.bam 
                bamtools stats -in ${3}/bwa/cell$i/output.bam > ${3}/bwa/cell$i/alignment_summary.txt
		#samtools flagstat ${3}/bwa/cell$i/output.bam > ${3}/bwa/cell$i/flagstats.txt
		#samtools view -b -F 4 ${3}/bwa/cell$i/output.sam > ${3}/bwa/cell$i/mapped.bam
                #samtools view -b -f 4 ${3}/bwa/cell$i/output.sam > ${3}/bwa/cell$i/unmapped.bam
                samtools sort -n --threads 8 -o ${3}/bwa/cell$i/sorted_output.bam ${3}/bwa/cell$i/output.bam
		rm ${3}/bwa/cell$i/output.sam
                echo "outputted all the bam files"
                echo "---------------------------"
((i+=1))
done


