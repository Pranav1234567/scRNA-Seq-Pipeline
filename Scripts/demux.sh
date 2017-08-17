#!/bin/bash

#${1} = ${RAW}
#${2} = ${DEMUX}
#${3} = ${rawname}
#${4} = ${INFO}

gunzip ${1}/*.gz

for f in $(ls ${1}/SRR*_1.fastq)
 	do
 	for g in $(ls ${1}/SRR*_2.fastq)
        do
        	mkdir ${2}/$(basename ${3}_1)/
                mkdir ${2}/$(basename ${3}_2)/
                echo "Starting to demultiplex cells..."
                fastq-multx ${4}/barcodes.tab ${f} ${g} -o ${2}/$(basename ${3}_1)/cell.%.fastq ${2}/$(basename ${3}_2)/cell.%.fastq
        done
 done
