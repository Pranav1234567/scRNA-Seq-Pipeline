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
                for f in $(ls ${1}/$(basename ${3}_1)/trimCell.$i.fastq)
                do
			for g in $(ls ${1}/$(basename ${3}_2)/trimCell.$i.fastq)
			do

			mkdir ${4}/bwa/cell$i
			
			echo "Beginning Alignment using BWA..."
			bwa mem -M -t 16 ${2}/Mus_musculus_UCSC_mm10/Mus_musculus/UCSC/mm10/Sequence/BWAIndex/genome.fa ${f} ${g} > ${4}/bwa/cell$i/aln-pe.sam
			echo "DONE"
			
			done
			cd ${4}/bwa/cell$i
			samtools view -bS aln-pe.sam > aln-pe.bam 
                	bamtools stats -in aln-pe.bam > alignment_summary.txt
			samtools flagstat aln-pe.bam > flagstats.txt
			samtools view -b -F 4 aln-pe.sam > mapped.bam
                        samtools view -b -f 4 aln-pe.sam > unmapped.bam
                        rm aln-pe.sam
                        echo "outputted all the bam files"
                        echo "---------------------------"
		done
((i+=1))
done


