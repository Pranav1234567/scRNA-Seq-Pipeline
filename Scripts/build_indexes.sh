#!/bin/bash

#$1 = ${BASE}/Reference, where index files should be located
#$2 = genome FASTA 
#$3 = GTF/GFF file

mkdir ${1}/Indexes
mkdir ${1}/Genes

cp $3 ${1}/Genes/$(basename $3)

read -p 'What Alignment Index file do you wish to create (1 for bowtie2, 2 for bwa, 3 for hisat2, or 4 for STAR): ' index

if [ $index = '1' ]
then
	mkdir ${1}/Indexes/Bowtie2Index
	cd ${1}/Indexes/Bowtie2Index
	bowtie2-build --threads 8 $2 genome 
	cd ../../..
elif [ $index = '2' ]
then
	mkdir ${1}/Indexes/BWAIndex
	cd ${1}/Indexes/BWAIndex
	bwa index $2
	cd ../../..
elif [ $index = '3' ]
then
	mkdir ${1}/Indexes/HiSat2Index
	cd ${1}/Indexes/HiSat2Index
	hisat2-build $2 genome
	cd ../../..
elif [ $index = '4' ]
then
	mkdir ${1}/Indexes/STARIndex
	STAR --runThreadN 8 --runMode genomeGenerate --genomeDir ${BASE}/Indexes/STARIndex --genomeFastaFiles $2  --sjdbGTFfile $3
else 
	echo "there was an error processing input, we will re-run this file..."
	./build_indexes.sh $1 $2 $3
fi
