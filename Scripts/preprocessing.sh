#!/bin/bash

#$1 = ${BASE} 
#$2 = ${FASTQ1} 
#$3 = ${FASTQ2} 
#$4 = ${INDEX} 
#$5 = ${GENES_DIR} 
#$6 = ${ADAPTERS} 
#$7 = ${align_reqs[0]} 
#$8 = ${barcode_option}

echo "Welcome "$USER", to this BASH script on PREPROCESSING scRNA-Seq Data"
echo "--------------------------------------"

	#Predefined by user
	BASE=$1

	today=`date +%m-%d-%Y.%H:%M:%S`

	Preprocess="Preprocess_$today"

	PREPROC=${BASE}/$Preprocess

	RAW=${PREPROC}/Raw
	QC=${PREPROC}/QC
	INFO=${PREPROC}/Info
	DEMUX=${PREPROC}/Demux
	TRIM=${PREPROC}/Trim
	COUNTS=${PREPROC}/Counts
	ALIGN=${PREPROC}/Align
		
	mkdir ${PREPROC} ${RAW} ${QC} ${INFO} ${DEMUX} ${TRIM} ${ALIGN} ${COUNTS}

	#Once directories are created, we can take in the input data as 2 FASTQ files, move them to appropriate locations and generate quality reports
		
		rawname_1=$(basename $2)
		rawname_2=$(basename $3)
		
		ln -s $2 ${RAW}/
		ln -s $3 ${RAW}/
                
		#echo "------------------------------------"
                #echo "Generating quality control reports (2 FASTQ files) using FASTQC..."
		#echo "------------------------------------"
		#mkdir ${QC}/original/
        	#fastqc --threads 8 ${RAW}/${rawname_1} -o ${QC}/original
        	#echo "-----------------------------------------"
        	#fastqc --threads 8 ${RAW}/${rawname_2} -o ${QC}/original
        	#echo "DONE generating quality control reports using FASTQC"
		
		#echo "---------------------------------------"
	if [ "$8" = "" ]
	then
	#Make Barcode File
		chmod 777 extractBarcodes.sh
		echo "Making Barcode file..."
		./extractBarcodes.sh ${INFO} ${RAW} ${rawname_1} ${rawname_2}
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
		./demux.sh ${RAW} ${DEMUX} ${INFO} ${rawname_1} ${rawname_2}
		echo "DONE demultiplexing cells"
		echo "--------------------------------------"
 	: '
	#Quality Reports for demuxed Cells
		chmod 777 demuxQC.sh
		mkdir ${QC}/Demux
		./demuxQC.sh ${DEMUX} ${QC}/Demux $NUMCELLS 
	' 
	#Trimming Adapters
		chmod 777 removeAdapters.sh
		echo "Starting to remove adapter sequences..."
		mkdir ${TRIM}/Read1/
        	mkdir ${TRIM}/Read2/
		./removeAdapters.sh ${DEMUX} ${TRIM} ${6} $NUMCELLS 				
		echo "DONE removing adapter sequences"
		echo "--------------------------------------"
	: '
	#Quality Reports for trimmed Cells
		chmod 777 trimDemuxQC.sh
                mkdir ${QC}/trim
                ./trimDemuxQC.sh ${TRIM} ${QC}/trim $NUMCELLS
	'
	# Reduce storage
		 rm -R ${DEMUX}
	
	#Alignment to the Genome and counts
		chmod 777 alignment.sh
		./alignment.sh ${TRIM} ${4} ${ALIGN} ${INFO} ${COUNTS} $NUMCELLS ${5} ${7}
	
	# Reduce storage
		 rm -R ${TRIM}

	#(If barcodes generated) Relocation of barcodes for reuse
		if [ "$8" = "" ]
		then
			mv ${INFO}/barcodes.tab ${BASE}
		fi
		
