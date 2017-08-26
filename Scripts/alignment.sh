#!/bin/bash

#$1 = ${TRIM}
#$2 = ${INDEX}
#$3 = ${ALIGN}
#$4 = ${INFO}
#$5 = ${COUNTS}
#$6 = $NUMCELLS
#$7 = ${GENES_DIR} 
#$8 = ${align_reqs[0]}

if [ "$8" = "--bowtie2" ]
then	
	chmod 777 ../Alignment/bowtie2.sh
	../Alignment/bowtie2.sh ${1} ${2} ${3} ${6}
	name="bowtie2"
elif [ "$8" = "--bwa" ]
	then
	chmod 777 ../Alignment/bwa.sh
	../Alignment/bwa.sh ${1} ${2} ${3} ${6}
	name="bwa"
elif [ "$8" = "--tophat2" ]
	then
	chmod 777 ../Alignment/tophat2.sh
	../Alignment/tophat2.sh ${1} ${2} ${3} ${6} ${7}
	name="tophat2"
elif [ "$8" = "--STAR" ]
	then
	chmod 777 ../Alignment/STAR.sh
	../Alignment/STAR.sh ${1} ${2} ${3} ${6} ${7}
	name="STAR"
elif [ "$8" = "--hisat2" ]
	then
	chmod 777 ../Alignment/hisat2.sh
	../Alignment/hisat2.sh ${1} ${2} ${3} ${6}
	name="hisat2"
fi

echo "Beginning to get counts..."

chmod 777 counts.sh
./counts.sh ${3} ${2} ${name} ${5} ${4} ${6} ${7}



