#!/bin/bash

#$1 = ${BASE}/Reference, where index files should be located
#$2 = genome FASTA 
#$3 = GTF/GFF file
#$4 = which alignment you want to run

mkdir ${1}/Indexes
mkdir ${1}/Genes

cp $3 ${1}/Genes/$(basename $3)

if [ "$4" = "--bowtie2" ] || [ "$4" = "--tophat2" ]
then
	mkdir ${1}/Indexes/Bowtie2Index
	ln -s $2 ${1}/Indexes/Bowtie2Index/genome.fa
	cd ${1}/Indexes/Bowtie2Index
	bowtie2-build --threads 8 ${1}/Indexes/Bowtie2Index/genome.fa genome
	cd ../../.. 
elif [ "$4" = "--bwa" ]
then
	mkdir ${1}/Indexes/BWAIndex
	ln -s $2 ${1}/Indexes/BWAIndex/genome.fa
	bwa index ${1}/Indexes/BWAIndex/genome.fa 
elif [ "$4" = "--hisat2" ]
then
	mkdir ${1}/Indexes/HiSat2Index
	cd ${1}/Indexes/HiSat2Index
	ln -s $2 genome.fa
	hisat2-build genome.fa genome
	cd ../../..
elif [ "$4" = "--STAR" ]
then
	mkdir ${1}/Indexes/STARIndex
	cd ${1}/Indexes/STARIndex
	ln -s $2 genome.fa
	STAR --runThreadN 8 --runMode genomeGenerate --genomeDir ${1}/Indexes/STARIndex --genomeFastaFiles genome.fa  --sjdbGTFfile $3
	cd ../../..
else 
	echo "there was an error processing input, please re-run run.sh with your options..."
fi
