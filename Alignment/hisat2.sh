#!/bin/bash

#$1 = ${TRIM}
#$2 = ${REF}
#$3 = ${rawname}
#$4 = ${ALIGN}
#$5 = ${INFO}
#$6 = $NUMCELLS

mkdir ${4}/hisat2
NUMCELLS=$6
i=1
while ((i <= $NUMCELLS))
do
                for f in $(ls ${1}/$(basename ${3}_2)/trimCell.$i.fastq)
                do
                        mkdir ${4}/hisat2/cell$i
			echo "Beginning Alignment using HISAT2..."
                        hisat2 -q -I 40 -X 100 -t --un ${4}/hisat2/cell$i/unaligned.fastq --al ${4}/hisat2/cell$i/aligned.fastq -p 8 --qc-filter -x ${2}/Mus_musculus_UCSC_mm10/Mus_musculus/UCSC/mm10/Sequence/HiSat2Index/genome -U $f -S ${4}/hisat2/cell$i/output.sam  
			cd ${4}/hisat2/cell$i
                        samtools view -bS ${4}/hisat2/cell$i/output.sam > ${4}/hisat2/cell$i/output.bam
			bamtools stats -in ${4}/hisat2/cell$i/output.bam > ${4}/hisat2/cell$i/align_summary.txt
                        samtools view -b -F 4 ${4}/hisat2/cell$i/output.sam > ${4}/hisat2/cell$i/mapped.bam
                        samtools view -b -f 4 ${4}/hisat2/cell$i/output.sam >${4}/hisat2/cell$i/unmapped.bam
			samtools sort -n --threads 8 -o ${4}/hisat2/cell$i/sorted_output.bam ${4}/hisat2/cell$i/output.bam
                        rm ${4}/hisat2/cell$i/output.sam
                done
((i+=1))
done
