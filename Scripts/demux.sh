#!/bin/bash

#${1} = ${RAW}
#${2} = ${DEMUX}
#${3} = ${INFO}
#${4} = ${rawname_1}
#${5} = ${rawname_2}

mkdir ${2}/Read1/
mkdir ${2}/Read2/
echo "Starting to demultiplex cells..."
fastq-multx ${3}/barcodes.tab ${1}/${4} ${1}/${5} -o ${2}/Read1/cell.%.fastq ${2}/Read2/cell.%.fastq
