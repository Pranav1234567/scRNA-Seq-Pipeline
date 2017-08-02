#!/bin/bash

#${1} = ${DEMUX}
#${2} = ${rawname}
#${3} = ${QC}/demux
#$4 = number of cells = # lines in the barcode file
echo "Generating quality control reports (Demuxed Cells) using FASTQC..."

i=1

mkdir ${3}/$(basename ${2}_1)
mkdir ${3}/$(basename ${2}_2)

NUMCELLS=$4

while ((i<=$NUMCELLS))
do

	for f in $(ls ${1}/$(basename ${2}_1)/cell.$i.fastq) 
	do
		echo "------------------------------------"
                mkdir ${3}/$(basename ${2}_1)/cell$i
		fastqc --threads 8 ${f} -o ${3}/$(basename ${2}_1)/cell$i
                echo "-----------------------------------------"
                echo "DONE"
	done

	 for f in $(ls ${1}/$(basename ${2}_2)/cell.$i.fastq)
	do
                echo "------------------------------------"
		mkdir ${3}/$(basename ${2}_2)/cell$i
                fastqc --threads 8 ${f} -o ${3}/$(basename ${2}_2)/cell$i          
                echo "-----------------------------------------"
                echo "DONE"
	done

((i+=1))

done
