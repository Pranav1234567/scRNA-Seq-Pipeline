#!/bin/bash

for f in $(ls ${2}/SRR*_1.fastq)
do
	CUTNUM=8

	cut -c1-${CUTNUM} ${f} > temp.txt
	awk 'NR % 4 == 2' temp.txt > temp2.txt

	#An approximate number needed here
	NUMBARCODES=96

	./pyscript.py temp2.txt $NUMBARCODES >> python_out.txt

	grep -o "'[^']*'" python_out.txt > onlySeq_python_out.txt
	awk '{print substr($0, 2, length($0)-2)}' onlySeq_python_out.txt > noQuotes_python_out.txt
	cat -n noQuotes_python_out.txt > ${1}/barcodes.tab

	rm noQuotes_python_out.txt onlySeq_python_out.txt python_out.txt temp.txt                      
done
