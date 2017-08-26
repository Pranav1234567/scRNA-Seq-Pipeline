#!/bin/bash

#${1} = ${TRIM}
#${2} = ${QC}/trim
#${3} = $NUMCELLS
echo "Generating quality control reports (Trimmed and Demuxed Cells) using FASTQC..."

i=1

mkdir ${2}/Read1
mkdir ${2}/Read2

while ((i<=$3))
do

	for f in $(ls ${1}/Read1/trimCell.$i.fastq) 
	do
		echo "------------------------------------"
                mkdir ${2}/Read1/trimCell$i
		fastqc --threads 8 ${f} -o ${2}/Read1/trimCell$i
                echo "-----------------------------------------"
                echo "DONE"
	done

	for f in $(ls ${1}/Read2/trimCell.$i.fastq)
	do
                echo "------------------------------------"
		mkdir ${2}/Read2/trimCell$i
                fastqc --threads 8 ${f} -o ${2}/Read2/trimCell$i      
                echo "-----------------------------------------"
                echo "DONE"
	done

((i+=1))

done

