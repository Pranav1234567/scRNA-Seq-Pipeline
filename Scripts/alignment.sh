#!/bin/bash

if [ "$9" = "--bowtie2" ]
then	
	chmod 777 ../Alignment/bowtie2.sh
	../Alignment/bowtie2.sh ${1} ${2} ${3} ${4} ${5} ${7}
	name="bowtie2"
elif [ "$9" = "--bwa" ]
	then
	chmod 777 ../Alignment/bwa.sh
	../Alignment/bwa.sh ${1} ${2} ${3} ${4} ${5} ${7}
	name="bwa"
elif [ "$9" = "--tophat2" ]
	then
	chmod 777 ../Alignment/tophat2.sh
	../Alignment/tophat2.sh ${1} ${2} ${3} ${4} ${5} ${7} ${8}
	name="tophat2"
elif [ "$9" = "--STAR" ]
	then
	chmod 777 ../Alignment/STAR.sh
	../Alignment/STAR.sh ${1} ${2} ${3} ${4} ${5} ${7} ${8}
	name="STAR"
elif [ "$9" = "--hisat2" ]
	then
	chmod 777 ../Alignment/hisat2.sh
	../Alignment/hisat2.sh ${1} ${2} ${3} ${4} ${5} ${7}
	name="hisat2"
fi

echo "Beginning to get counts..."

chmod 777 counts.sh
./counts.sh ${4} ${2} ${name} ${6} ${5} ${7} ${8}



