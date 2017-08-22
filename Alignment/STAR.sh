#/bin/bash

#$1 = ${TRIM}
#$2 = ${INDEX}
#$3 = ${rawname}
#$4 = ${ALIGN}
#$5 = ${INFO}
#$6 = $NUMCELLS
#$7 = ${GENES_DIR}

i=1

NUMCELLS=$6

mkdir ${4}/STAR

while((i<=$NUMCELLS))
do
	for f in $(ls ${1}/$(basename ${3}_2)/trimCell.$i.fastq) 
	do
		
		mkdir ${4}/STAR/cell$i
		echo "Beginning Alignment using STAR..."
		STAR --runThreadN 8 --runMode alignReads --genomeDir ${2}/STARIndex/ --sjdbGTFfile ${8}/genes.gtf --readFilesIn ${f} --outFileNamePrefix output STAR_alignment --outTmpDir ${4}/STAR/ --outStd BAM_Unsorted --outSAMtype BAM Unsorted --outSAMunmapped Within KeepPairs --outBAMcompression 0 --bamRemoveDuplicatesType UniqueIdentical --quantMode GeneCounts    
		echo "DONE"
                bamtools stats -in ${4}/STAR/cell$i/output.bam > ${4}/STAR/cell$i/align_summary.txt
                #samtools view -b -F 4 ${4}/STAR/cell$i/output.sam > ${4}/STAR/cell$i/mapped.bam
                #samtools view -b -f 4 ${4}/STAR/cell$i/output.sam > ${4}/STAR/cell$i/unmapped.bam
                samtools sort -n --threads 8 -o ${4}/STAR/cell$i/sorted_output.bam ${4}/STAR/cell$i/output.bam
                rm ${4}/STAR/cell$i/output.sam
                echo "outputted all the bam files"
                echo "---------------------------"
		((i+=1))
	done
done
