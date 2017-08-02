#!/bin/bash

echo "Welcome "$USER", to this BASH script on PREPROCESSING scRNA-Seq Data"
echo "-----------------------------------------"

	#Predefined by user
	BASE=$1

	PROJ=${BASE}/Project

	ANALYSIS=${PROJ}/Analysis

	RAW=${ANALYSIS}/Raw
	QC=${ANALYSIS}/QC
	INFO=${ANALYSIS}/Info
	DEMUX=${ANALYSIS}/Demux
	TRIM=${ANALYSIS}/Trim
	COUNTS=${ANALYSIS}/Counts
	SCRIPTS="Documents/scripts"
	ALIGN=${ANALYSIS}/Align

	mkdir ${PROJ} ${ANALYSIS} ${RAW} ${QC} ${INFO} ${DEMUX} ${TRIM} ${ALIGN} ${COUNTS}

	#Once directories are created, we can take in the input data, convert to FASTQ and generate quality reports
        	rawname=`echo $2 | cut -f1 -d'.'`
		echo "--------------------------------------"
        	echo "Making two FASTQ files from SRA..."
        	echo "----------------------------------"
                cd $3
               	./fastq-dump -O ${RAW} -I --split-files $2
               # echo "----------------------------------"
               # echo "DONE"
               # echo "------------------------------------"
               # echo "Generating quality control reports (2 FASTQ files) using FASTQC..."
		#echo "------------------------------------"
		#mkdir ${QC}/original/
        	#$4 --threads 8 ${rawname}_1.fastq -o ${QC}/original
        	#echo "-----------------------------------------"
        	#$4 --threads 8 ${rawname}_2.fastq -o ${QC}/original
        	#echo "DONE"

 	#Make Barcode File
		cd ${1}
		chmod 777 extractBarcodes.sh

		for f in $(ls ${RAW}/SRR*_1.fastq)
		do	
			echo "--------------------------------------"
			echo "Starting to make barcode file..."
			./extractBarcodes.sh ${f} ${INFO}
		done   
		echo "DONE"
		echo "-------------------------------------"

	#Demultiplex
		chmod 777 demux.sh
		./demux.sh ${RAW} ${DEMUX} ${rawname} ${INFO}
		echo "DONE"
		echo "--------------------------------------"
 
	#Quality Reports for demuxed Cells
		#chmod 777 demuxQC.sh
		#mkdir ${QC}/demux
		#./demuxQC.sh ${DEMUX} ${rawname} ${QC}/demux $4
 
	#Trimming Adapters
		chmod 777 removeAdapters.sh
		echo "Starting to remove adapter sequences..."
		mkdir ${TRIM}/$(basename ${rawname}_1)/
        	mkdir ${TRIM}/$(basename ${rawname}_2)/
		./removeAdapters.sh ${DEMUX} ${TRIM} ${rawname} /Users/Pranav/Documents/Research/AnalysisResults/adapters.fa 				
		echo "DONE"
		echo "--------------------------------------"
	
	#Quality Reports for trimmed Cells
		#chmod 777 trimDemuxQC.sh
                #mkdir ${QC}/trim
		#chmod 777 getNumCells.sh
		#./getNumCells.sh ${INFO}/barcodes.tab
		#typeset -i NUMCELLS=$(cat tempB.txt)
                #./trimDemuxQC.sh ${TRIM} ${rawname} ${QC}/trim $4 $NUMCELLS

	#Alignment to the Genome and counts
		chmod 777 alignment.sh
		./alignment.sh ${TRIM} /Users/Pranav/Documents/Research/AnalysisResults/Reference ${rawname} ${ALIGN} ${INFO} /Users/Pranav/Documents/Research/AnalysisTools/ ${COUNTS}

