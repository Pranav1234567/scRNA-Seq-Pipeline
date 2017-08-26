#!/bin/bash

#$1 = ${TRIM}
#$2 = ${INDEX}
#$3 = ${ALIGN}
#$4 = $NUMCELLS

mkdir ${3}/hisat2

i=1
while ((i <= $4))
do
                for f in $(ls ${1}/Read2/trimCell.$i.fastq)
                do
                        mkdir ${3}/hisat2/cell$i
			echo "Beginning Alignment using HISAT2..."
                        hisat2 -q -I 40 -X 100 -t -p 8 --qc-filter -x ${2}/HiSat2Index/genome -U $f -S ${3}/hisat2/cell$i/output.sam  
			cd ${3}/hisat2/cell$i
                        samtools view -bS ${3}/hisat2/cell$i/output.sam > ${3}/hisat2/cell$i/output.bam
			bamtools stats -in ${3}/hisat2/cell$i/output.bam > ${3}/hisat2/cell$i/align_summary.txt
                        #samtools view -b -F 4 ${3}/hisat2/cell$i/output.sam > ${3}/hisat2/cell$i/mapped.bam
                        #samtools view -b -f 4 ${3}/hisat2/cell$i/output.sam > ${3}/hisat2/cell$i/unmapped.bam
			samtools sort -n --threads 8 -o ${3}/hisat2/cell$i/sorted_output.bam ${3}/hisat2/cell$i/output.bam
                        rm ${3}/hisat2/cell$i/output.sam
                done
((i+=1))
done
