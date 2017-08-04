
#!/bin/bash

#$1 = ${DEMUX}
#$2 = ${REF}
#$3 = ${rawname}
#$4 = ${ALIGN}
#$5 = ${INFO}
#$6 = $NUMCELLS

mkdir ${4}/tophat2
NUMCELLS=$6

i=1
while ((i <= $NUMCELLS))
do
	for f in $(ls ${1}/$(basename ${3}_2)/cell.$i.fastq)
        do
		mkdir ${4}/tophat2/cell$i
		echo "Beginning Alignment using TOPHAT2"
		samtools sort -n --threads 8 -o ${4}/tophat2/cell$i/sorted_output.bam ${4}/tophat2/cell$i/accepted_hits.bam
		tophat2 -G ${2}/Mus_musculus_UCSC_mm10/Mus_musculus/UCSC/mm10/Annotation/Genes/genes.gtf -o ${4}/tophat2/cell$i --num-threads 16 --transcriptome-max-hits 1 --max-multihits 1 --no-coverage-search --no-novel-juncs ${2}/Mus_musculus_UCSC_mm10/Mus_musculus/UCSC/mm10/Sequence/Bowtie2Index/genome ${f} 	
		echo "DONE"
	done	
((i+=1))
done



