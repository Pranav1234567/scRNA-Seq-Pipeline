#!/bin/bash

#$1 = ${BASE}/Reference, where index files should be located
#$2 = genome FASTA 
#$3 = GTF/GFF file
#$4 = which alignment you want to run

mkdir ${1}/Indexes
mkdir ${1}/Genes

cp $3 ${1}/Genes/$(basename $3)

if [ "$4" = "--bowtie2" ] || ["$4" = "--tophat2"]
then
	mkdir ${1}/Indexes/Bowtie2Index
	cd ${1}/Indexes/Bowtie2Index
	bowtie2-build --threads 8 $2 genome 
	cd ../../..
elif [ "$4" = "--bwa" ]
then
	mkdir ${1}/Indexes/BWAIndex
	cd ${1}/Indexes/BWAIndex
	bwa index $2
	cd ../../..
elif [ "$4" = "--hisat2" ]
then
	mkdir ${1}/Indexes/HiSat2Index
	cd ${1}/Indexes/HiSat2Index
	hisat2-build $2 genome
	cd ../../..
elif [ "$4" = "--STAR" ]
then
	mkdir ${1}/Indexes/STARIndex
	cd ${1}/Indexes/STARIndex
	STAR --runThreadN 8 --runMode genomeGenerate --genomeDir ${BASE}/Indexes/STARIndex --genomeFastaFiles $2  --sjdbGTFfile $3
	cd ../../..
else 
	echo "there was an error processing input, please re-run run.sh with your options..."
fi
