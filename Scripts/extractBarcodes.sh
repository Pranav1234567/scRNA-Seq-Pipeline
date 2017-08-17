#!/bin/bash

gzip ${2}/*.fastq

for f in $(ls ${2}/SRR*_1.fastq.gz)
do
	for g in $(ls ${2}/SRR*_2.fastq.gz)
	do
		#brew services restart redis
		python3 -m sircel --threads 8 --output_dir ${1} --reads ${g} --barcodes ${f} --barcode_start 0 --barcode_end 8 --umi_start 8 --umi_end 12
	done
done

awk '{print $1}' ${1}/threshold_paths.txt > ${1}/barcodes.txt
cat -n ${1}/barcodes.txt > ${1}/barcodes.tab
rm ${1}/barcodes.txt

