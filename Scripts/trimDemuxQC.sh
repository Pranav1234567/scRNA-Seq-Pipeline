#!/bin/bash

#${1} = ${TRIM}
#${2} = ${rawname}
#${3} = ${QC}/trim
#$4 = path/to/FASTQC
#$5 = number of cells = # lines in the barcode file
echo "Generating quality control reports (Trimmed and Demuxed Cells) using FASTQC..."

i=1

mkdir ${3}/$(basename ${2}_1)
mkdir ${3}/$(basename ${2}_2)

NUMCELLS=$5

while ((i<=NUMCELLS))
do

	for f in $(ls ${1}/$(basename ${2}_1)/trimCell.$i.fastq) 
	do
		echo "------------------------------------"
                mkdir ${3}/$(basename ${2}_1)/trimCell$i
		$4 --threads 8 ${f} -o ${3}/$(basename ${2}_1)/trimCell$i
                echo "-----------------------------------------"
                echo "DONE"
	done

	 for f in $(ls ${1}/$(basename ${2}_2)/trimCell.$i.fastq)
	do
                echo "------------------------------------"
		mkdir ${3}/$(basename ${2}_2)/trimCell$i
                $4 --threads 8 ${f} -o ${3}/$(basename ${2}_2)/trimCell$i      
                echo "-----------------------------------------"
                echo "DONE"
	done

((i+=1))

done

