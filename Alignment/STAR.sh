#/bin/bash

#$1 = ${TRIM}
#$2 = ${INDEX}
#$3 = ${ALIGN}
#$4 = $NUMCELLS
#$5 = ${GENES_DIR}

i=1

mkdir ${3}/STAR

while((i<=$4))
do
	for f in $(ls ${1}/Read2/trimCell.$i.fastq) 
	do
		
		mkdir ${3}/STAR/cell$i
		echo "Beginning Alignment using STAR..."
		STAR --runThreadN 8 --runMode alignReads --genomeDir ${2}/STARIndex/ --sjdbGTFfile ${5}/genes.gtf --readFilesIn ${f} --outFileNamePrefix output STAR_alignment --outTmpDir ${3}/STAR/ --outStd BAM_Unsorted --outSAMtype BAM Unsorted --outSAMunmapped Within KeepPairs --outBAMcompression 0 --bamRemoveDuplicatesType UniqueIdentical --quantMode GeneCounts    
		echo "DONE"
                bamtools stats -in ${3}/STAR/cell$i/output.bam > ${3}/STAR/cell$i/align_summary.txt
                #samtools view -b -F 4 ${3}/STAR/cell$i/output.sam > ${3}/STAR/cell$i/mapped.bam
                #samtools view -b -f 4 ${3}/STAR/cell$i/output.sam > ${3}/STAR/cell$i/unmapped.bam
                samtools sort -n --threads 8 -o ${3}/STAR/cell$i/sorted_output.bam ${3}/STAR/cell$i/output.bam
                rm ${3}/STAR/cell$i/output.sam
                echo "outputted all the bam files"
                echo "---------------------------"
		((i+=1))
	done
done
