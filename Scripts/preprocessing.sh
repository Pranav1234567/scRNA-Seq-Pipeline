#!/bin/bash

echo "Welcome "$USER", to this BASH script on PREPROCESSING scRNA-Seq Data"
echo "-----------------------------------------"

	#Predefined by user
	BASE=$1

	PREPROC=${BASE}/Preprocess

	RAW=${PREPROC}/Raw
	QC=${PREPROC}/QC
	INFO=${PREPROC}/Info
	DEMUX=${PREPROC}/Demux
	TRIM=${PREPROC}/Trim
	COUNTS=${PREPROC}/Counts
	ALIGN=${PREPROC}/Align
		
	mkdir ${PREPROC} ${RAW} ${QC} ${INFO} ${DEMUX} ${TRIM} ${ALIGN} ${COUNTS}

	#Once directories are created, we can take in the input data as 2 FASTQ files, move them to appropriate locations and generate quality reports
		rawname=`echo $2 | cut -f1 -d'.'`
		rawname=${rawname::${#rawname}-2}
		cp $2 ${RAW}/
		cp $3 ${RAW}/
                #echo "------------------------------------"
                #echo "Generating quality control reports (2 FASTQ files) using FASTQC..."
		#echo "------------------------------------"
		#mkdir ${QC}/original/
        	#fastqc --threads 8 ${RAW}/${rawname}_1.fastq -o ${QC}/original
        	#echo "-----------------------------------------"
        	#fastqc --threads 8 ${RAW}/${rawname}_2.fastq -o ${QC}/original
        	#echo "DONE generating quality control reports using FASTQC"
		echo "---------------------------------------"
	if [ "$8" = "" ]
	then
	#Make Barcode File
		chmod 777 extractBarcodes.sh
		echo "--------------------------------------"
		echo "Making Barcode file..."
		./extractBarcodes.sh ${INFO} ${RAW}
		echo "-------------------------------------"	
		echo "DONE making barcode file"
	else
		cp $8 ${INFO}/barcodes.tab
		echo "copied file to INFO directory"
	fi
	echo "-----------------------------------"
	#Number of Cells Constant
		echo "Getting the Number of Cells constant..."
		chmod 777 getNumCells.sh
                ./getNumCells.sh ${INFO}/barcodes.tab
                typeset -i NUMCELLS=$(cat tempB.txt)
		echo "DONE getting number of cells constant"
	echo "-----------------------------------"
	echo $NUMCELLS
	#Demultiplex
		chmod 777 demux.sh
		./demux.sh ${RAW} ${DEMUX} ${rawname} ${INFO}
		echo "DONE demultiplexing cells"
		echo "--------------------------------------"
 	: '
	#Quality Reports for demuxed Cells
		chmod 777 demuxQC.sh
		mkdir ${QC}/demux
		./demuxQC.sh ${DEMUX} ${rawname} ${QC}/demux $NUMCELLS
	' 
	#Trimming Adapters
		chmod 777 removeAdapters.sh
		echo "Starting to remove adapter sequences..."
		mkdir ${TRIM}/$(basename ${rawname}_1)/
        	mkdir ${TRIM}/$(basename ${rawname}_2)/
		./removeAdapters.sh ${DEMUX} ${TRIM} ${rawname} ${6} $NUMCELLS 				
		echo "DONE removing adapter sequences"
		echo "--------------------------------------"
	: '
	#Quality Reports for trimmed Cells
		chmod 777 trimDemuxQC.sh
                mkdir ${QC}/trim
                ./trimDemuxQC.sh ${TRIM} ${rawname} ${QC}/trim $NUMCELLS
	'

	#Alignment to the Genome and counts
		chmod 777 alignment.sh
		./alignment.sh ${TRIM} ${4} ${rawname} ${ALIGN} ${INFO} ${COUNTS} $NUMCELLS ${5} ${7}
	
