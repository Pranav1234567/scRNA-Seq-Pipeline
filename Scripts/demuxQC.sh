#!/bin/bash

#${1} = ${DEMUX}
#${2} = ${QC}/demux
#$3 = number of cells = # lines in the barcode file

echo "Generating quality control reports (Demuxed Cells) using FASTQC..."

i=1

mkdir ${2}/Read1
mkdir ${2}/Read2

while (($i<=$3))
do

	for f in $(ls ${1}/Read1/cell.$i.fastq) 
	do
		echo "------------------------------------"
                mkdir ${2}/Read1/cell$i
		fastqc --threads 8 ${f} -o ${2}/Read1/cell$i
                echo "-----------------------------------------"
                echo "DONE"
	done

	for f in $(ls ${1}/Read2/cell.$i.fastq)
	do
                echo "------------------------------------"
		mkdir ${2}/Read2/cell$i
                fastqc --threads 8 ${f} -o ${2}/Read2/cell$i          
                echo "-----------------------------------------"
                echo "DONE"
	done

((i+=1))

done
