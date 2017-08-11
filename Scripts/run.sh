#!/bin/bash

BASE="/Users/Pranav/Documents/scripts"
DATA="/Users/Pranav/Documents/Research/AnalysisResults/Raw/SRR3106546.sra"
ADAPTERS="/Users/Pranav/Documents/Research/AnalysisResults/adapters.fa"
REF="/Users/Pranav/Documents/Research/AnalysisResults/Reference/Mus_musculus_UCSC_mm10/Mus_musculus/UCSC/mm10"
GENOME=${REF}/Sequence/WholeGenomeFasta/genome.fa
GENES=${REF}/Annotation/Genes/genes.gtf
BARCODES="/Users/Pranav/Documents/Research/AnalysisResults/Demux/GSE76983_cel-seq_barcodes.csv"

#################### obtaining user options #######################################

#Alignment softwares that are available
declare -a align_arr=("--bowtie2" "--bwa" "--tophat2" "--hisat2" "--STAR");

#user options input
args=()
for i in "$@"; do
    args+=("$i")
done

declare -a no_build_reqs=( ${args[@]/--build*/} );
declare -a no_barcode_reqs=( ${no_build_reqs[@]/--generateBarcodes*/} );

#user request for options
align_reqs=()

#separates alignment requests and other requests
for j in "${!args[@]}"
do
	for k in "${!align_arr[@]}"
	do
		if [ "${args[$j]}" = "${align_arr[$k]}" ]
		then
			align_reqs+=("${args[$j]}")							
		fi
	done
done

#################### processing user options ########################################

#check if one alignment request is made
if [ ${#align_reqs[@]} != 1 ] 
then
	echo "must specify exactly one alignment procedure, please re-run the script.."	
else
	if [  ${#no_build_reqs[@]} -lt  ${#args[@]} ]
	then

		build="yes"
		
		mkdir ${BASE}/Reference
        	INDEX=${BASE}/Reference/Indexes
        	GENES_DIR=${BASE}/Reference/Genes

        	./build_indexes.sh ${BASE}/Reference ${GENOME} ${GENES} ${align_reqs[0]}

		if [  ${#no_barcode_reqs[@]} -lt  ${#no_build_reqs[@]} ]
		then
			barcode_option=""
		else
			barcode_option=${BARCODES}
		fi

	else
		build="no"

		INDEX=${REF}/Sequence
        	GENES_DIR=${REF}/Annotation/Genes

		if [  ${#no_barcode_reqs[@]} -lt ${#no_build_reqs[@]} ]
                then
                        barcode_option=""
                else
                        barcode_option=${BARCODES}
                fi
			
	fi

################ running main scripts w/ user options #########################

	#./preprocessing.sh </path/to/project - where user wants project to exist> </path/to/Data> <path/to/Index files> <path/to/Genes Directory> <path/to/adapters> <alignment type> <barcode option>

	./preprocessing.sh ${BASE} ${DATA} ${INDEX} ${GENES_DIR} ${ADAPTERS} ${align_reqs[0]} ${barcode_option}

fi	

