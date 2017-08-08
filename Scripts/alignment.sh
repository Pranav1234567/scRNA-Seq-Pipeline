#!/bin/bash

echo "Enter the alignment software that you wish to use (type 1 for  bowtie2, 2 for bwa, 3 for  tophat2, 4 for STAR, 5 for hisat2): "

read -p 'Enter here: ' alignment

if [ $alignment = '1' ]
then	
	chmod 777 ../Alignment/bowtie2.sh
	../Alignment/bowtie2.sh ${1} ${2} ${3} ${4} ${5} ${7}
	name="bowtie2"
elif [ $alignment = '2' ]
	then
	chmod 777 ../Alignment/bwa.sh
	../Alignment/bwa.sh ${1} ${2} ${3} ${4} ${5} ${7}
	name="bwa"
elif [ $alignment = '3' ]
	then
	chmod 777 ../Alignment/tophat2.sh
	../Alignment/tophat2.sh ${1} ${2} ${3} ${4} ${5} ${7} ${8}
	name="tophat2"
elif [ $alignment = '4' ]
	then
	chmod 777 ../Alignment/STAR.sh
	../Alignment/STAR.sh ${1} ${2} ${3} ${4} ${5} ${7} ${8}
	name="STAR"
elif [ $alignment = '5' ]
	then
	chmod 777 ../Alignment/hisat2.sh
	../Alignment/hisat2.sh ${1} ${2} ${3} ${4} ${5} ${7}
	name="hisat2"
else 
	echo "There was an error in your input. We will re-run this script shortly..."
	./alignment.sh ${1} ${2} ${3} ${4} ${5} ${6} ${7} ${8}

fi

echo "Beginning to get counts..."

chmod 777 counts.sh
./counts.sh ${4} ${2} ${name} ${6} ${5} ${7} ${8}



