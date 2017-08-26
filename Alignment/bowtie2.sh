#!/bin/bash

#$1 = ${TRIM}
#$2 = ${INDEX}
#$3 = ${ALIGN}
#$4 = $NUMCELLS

mkdir ${3}/bowtie2

i=1
while ((i <= $4))
do
	for f in $(ls ${1}/Read2/trimCell.$i.fastq)
	do

		mkdir ${3}/bowtie2/cell$i
  			
		echo "Beginning Alignment using BOWTIE2..."
                bowtie2 -q --local -t -p 8 --qc-filter -x ${2}/Bowtie2Index/genome -U ${f} -S ${3}/bowtie2/cell$i/output.sam
		echo "DONE"

	done 
	samtools view -bS ${3}/bowtie2/cell$i/output.sam > ${3}/bowtie2/cell$i/output.bam
	bamtools stats -in ${3}/bowtie2/cell$i/output.bam > ${3}/bowtie2/cell$i/align_summary.txt
	#samtools view -b -F 4 ${3}/bowtie2/cell$i/output.sam > ${3}/bowtie2/cell$i/mapped.bam
	#samtools view -b -f 4 ${3}/bowtie2/cell$i/output.sam > ${3}/bowtie2/cell$i/unmapped.bam
	samtools sort -n --threads 8 -o ${3}/bowtie2/cell$i/sorted_output.bam ${3}/bowtie2/cell$i/output.bam
	rm ${3}/bowtie2/cell$i/output.sam
	echo "outputted all the bam files"
	echo "---------------------------"
((i+=1))
done
