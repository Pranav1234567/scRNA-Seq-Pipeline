#!/bin/bash

#brew services restart redis
python3 -m sircel --threads 8 --output_dir ${1} --reads ${2}/${4} --barcodes ${2}/${3} --barcode_start 0 --barcode_end 8 --umi_start 8 --umi_end 12

awk '{print $1}' ${1}/threshold_paths.txt > ${1}/barcodes.txt
cat -n ${1}/barcodes.txt > ${1}/barcodes.tab
rm ${1}/barcodes.txt

