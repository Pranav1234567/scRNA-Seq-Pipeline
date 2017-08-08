
#!/bin/bash

#$1 = ${DEMUX}
#$2 = ${INDEX}
#$3 = ${rawname}
#$4 = ${ALIGN}
#$5 = ${INFO}
#$6 = $NUMCELLS
#$7 = ${GENES_DIR}

mkdir ${4}/tophat2
NUMCELLS=$6

i=1
while ((i <= $NUMCELLS))
do
	for f in $(ls ${1}/$(basename ${3}_2)/trimCell.$i.fastq)
        do
		mkdir ${4}/tophat2/cell$i
		echo "Beginning Alignment using TOPHAT2"
		tophat2 -G ${8}/genes.gtf -o ${4}/tophat2/cell$i --num-threads 16 --transcriptome-max-hits 1 --max-multihits 1 --no-coverage-search --no-novel-juncs ${2}/Bowtie2Index/genome ${f} 	
		samtools sort -n --threads 8 -o ${4}/tophat2/cell$i/sorted_output.bam ${4}/tophat2/cell$i/accepted_hits.bam
		echo "DONE"
	done	
((i+=1))
done



