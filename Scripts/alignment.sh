#!/bin/bash

echo "Enter the alignment software that you wish to use (type 1 for  bowtie2, 2 for bwa, 3 for  tophat2, 4 for STAR): "

read -p 'Enter here: ' alignment

if [ $alignment = '1' ]
then	
	chmod 777 ./Alignment/bowtie2.sh
	./Alignment/bowtie2.sh ${1} ${2} ${3} ${4} ${5}
	name="bowtie2"
elif [ $alignment = '2' ]
	then
	chmod 777 ./Alignment/bwa.sh
	./Alignment/bwa.sh ${1} ${2} ${3} ${4} ${5} ${6}
	name="bwa"
elif [ $alignment = '3' ]
	then
	chmod 777 ./Alignment/bwa.sh
	./Alignment/tophat2.sh ${1} ${2} ${3} ${4} ${5} ${6}
	name="tophat2"
elif [ $alignment = '4' ]
	then
	chmod 777 ./Alignment/STAR.sh
	./Alignment/STAR.sh
	name="STAR"
else 
	echo "please try again: type './alignment.txt' in the command line"

fi

echo "Beginning to get counts..."

chmod 777 counts.sh
./counts.sh ${4} ${2} ${name} ${7} ${5} ${8}




