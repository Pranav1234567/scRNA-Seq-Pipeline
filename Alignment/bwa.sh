#!/bin/bash

#$1 = ${DEMUX}
#$2 = ${REF}
#$3 = ${rawname}
#$4 = ${ALIGN}
#$5 = ${INFO}
#$6 = $NUMCELLS

mkdir ${4}/bwa
NUMCELLS=$6

i=1
while ((i <= $NUMCELLS))
do
	for f in $(ls ${1}/$(basename ${3}_2)/trimCell.$i.fastq)
	do
		mkdir ${4}/bwa/cell$i
			
		echo "Beginning Alignment using BWA..."
		bwa mem -t 16 ${2}/Mus_musculus_UCSC_mm10/Mus_musculus/UCSC/mm10/Sequence/BWAIndex/genome.fa ${f} > ${4}/bwa/cell$i/output.sam
		echo "DONE"
			
	done
		samtools view -bS ${4}/bwa/cell$i/output.sam > ${4}/bwa/cell$i/output.bam 
                bamtools stats -in ${4}/bwa/cell$i/output.bam > ${4}/bwa/cell$i/alignment_summary.txt
		samtools flagstat ${4}/bwa/cell$i/output.bam > ${4}/bwa/cell$i/flagstats.txt
		samtools view -b -F 4 ${4}/bwa/cell$i/output.sam > ${4}/bwa/cell$i/mapped.bam
                samtools view -b -f 4 ${4}/bwa/cell$i/output.sam > ${4}/bwa/cell$i/unmapped.bam
                samtools sort -n --threads 8 -o ${4}/bwa/cell$i/sorted_output.bam ${4}/bwa/cell$i/output.bam
		rm ${4}/bwa/cell$i/output.sam
                echo "outputted all the bam files"
                echo "---------------------------"
((i+=1))
done


