
#!/bin/bash

#$1 = ${TRIM}
#$2 = ${INDEX}
#$3 = ${ALIGN}
#$4 = $NUMCELLS
#$5 = ${GENES_DIR}

mkdir ${3}/tophat2

i=1
while ((i <= $4))
do
	for f in $(ls ${1}/Read2/trimCell.$i.fastq)
        do
		mkdir ${3}/tophat2/cell$i
		echo "Beginning Alignment using TOPHAT2"
		tophat2 -G ${5}/genes.gtf -o ${3}/tophat2/cell$i --num-threads 16 --transcriptome-max-hits 1 --max-multihits 1 --no-coverage-search --no-novel-juncs ${2}/Bowtie2Index/genome ${f} 	
		samtools sort -n --threads 8 -o ${3}/tophat2/cell$i/sorted_output.bam ${3}/tophat2/cell$i/accepted_hits.bam
		echo "DONE"
	done	
((i+=1))
done



