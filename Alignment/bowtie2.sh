#!/bin/bash

#$1 = ${DEMUX}
#$2 = ${REF}
#$3 = ${rawname}
#$4 = ${ALIGN}
#$5 = ${INFO}

mkdir ${4}/bowtie2
cd 
cd Documents/scripts
chmod 777 getNumCells.txt
./getNumCells.txt ${5}/barcodes.tab
typeset -i NUMCELLS=$(cat tempB.txt)

i=1
while ((i <= $NUMCELLS))
do
                for f in $(ls ${1}/$(basename ${3}_1)/cell.$i.fastq)
                do

			for g in $(ls ${1}/$(basename ${3}_2)/cell.$i.fastq)
			do

			mkdir ${4}/bowtie2/cell$i
  			
			echo "Beginning Alignment using BOWTIE2..."
                        bowtie2 -q --local -t --un-conc ${4}/bowtie2/cell$i/unconc.fastq --al-conc ${4}/bowtie2/cell$i/alconc.fastq -p 8 --qc-filter -x ${2}/Mus_musculus_UCSC_mm10/Mus_musculus/UCSC/mm10/Sequence/Bowtie2Index/genome -1 ${f} -2 ${g} -S ${4}/bowtie2/cell$i/output.sam
			echo "DONE"

			done 
                	cd ${4}/bowtie2/cell$i
			samtools view -bS output.sam > output.bam
			bamtools stats -in output.bam > align_summary.txt
			samtools view -b -F 4 output.sam > mapped.bam
			samtools view -b -f 4 output.sam > unmapped.bam
			rm output.sam
			echo "outputted all the bam files"
			echo "---------------------------"
		done
((i+=1))
done
