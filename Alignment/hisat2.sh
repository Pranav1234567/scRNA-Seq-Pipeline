#!/bin/bash

DEMUX="/Users/Pranav/Documents/Research/AnalysisResults/Demux"
REF="/Users/Pranav/Documents/Research/AnalysisResults/Reference"
ALIGN="/Users/Pranav/Documents/Research/AnalysisResults/Align"

mkdir ${ALIGN}/hisat2

i=1
while ((i <= 96))
do
                for f in $(ls ${DEMUX}/SRR3106546_2/cell.$i.fq)
                do
                        mkdir ${ALIGN}/hisat2/cell$i
			cd /Users/Pranav/Documents/Research/AnalysisTools/hisat2-2.1.0
                        ./hisat2 -q -I 40 -X 100 -t --summary-file ${ALIGN}/hisat2/cell$i/align_summary.txt --un ${ALIGN}/hisat2/cell$i/unaligned.fq --al ${ALIGN}/hisat2/cell$i/aligned.fq -p 8 --qc-filter -x ${REF}/Mus_musculus_UCSC_mm10/Mus_musculus/UCSC/mm10/Sequence/HiSat2Index/genome -U $f -S ${ALIGN}/hisat2/cell$i/output.sam  
			cd ${ALIGN}/hisat2/cell$i
                        samtools view -bS output.sam > output.bam
                        samtools view -b -F 4 > mapped.bam
                        samtools view -b -f 4 > unmapped.bam
                        rm output.sam
                done
((i+=1))
done
