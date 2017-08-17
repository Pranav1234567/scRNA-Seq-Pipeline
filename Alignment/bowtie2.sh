#!/bin/bash

#$1 = ${TRIM}
#$2 = ${INDEX}
#$3 = ${rawname}
#$4 = ${ALIGN}
#$5 = ${INFO}
#$6 = $NUMCELLS

mkdir ${4}/bowtie2
NUMCELLS=$6

i=1
while ((i <= $NUMCELLS))
do
		for f in $(ls ${1}/$(basename ${3}_2)/trimCell.$i.fastq)
		do

			mkdir ${4}/bowtie2/cell$i
  			
			echo "Beginning Alignment using BOWTIE2..."
                        bowtie2 -q --local -t --un ${4}/bowtie2/cell$i/un.fastq --al ${4}/bowtie2/cell$i/al.fastq -p 8 --qc-filter -x ${2}/Bowtie2Index/genome -U ${f} -S ${4}/bowtie2/cell$i/output.sam
			echo "DONE"

			done 
			samtools view -bS ${4}/bowtie2/cell$i/output.sam > ${4}/bowtie2/cell$i/output.bam
			bamtools stats -in ${4}/bowtie2/cell$i/output.bam > ${4}/bowtie2/cell$i/align_summary.txt
			samtools view -b -F 4 ${4}/bowtie2/cell$i/output.sam > ${4}/bowtie2/cell$i/mapped.bam
			samtools view -b -f 4 ${4}/bowtie2/cell$i/output.sam > ${4}/bowtie2/cell$i/unmapped.bam
			samtools sort -n --threads 8 -o ${4}/bowtie2/cell$i/sorted_output.bam ${4}/bowtie2/cell$i/output.bam
			rm ${4}/bowtie2/cell$i/output.sam
			echo "outputted all the bam files"
			echo "---------------------------"
		done
((i+=1))
done
