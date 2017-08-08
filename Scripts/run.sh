#!/bin/bash

BASE="/Users/Pranav/Documents/scripts"
DATA="/Users/Pranav/Documents/Research/AnalysisResults/Raw/SRR3106546.sra"
ADAPTERS="/Users/Pranav/Documents/Research/AnalysisResults/adapters.fa"
REF="/Users/Pranav/Documents/Research/AnalysisResults/Reference/Mus_musculus_UCSC_mm10/Mus_musculus/UCSC/mm10"
GENOME=${REF}/Sequence/WholeGenomeFasta/genome.fa
GENES=${REF}/Annotation/Genes/genes.gtf

if [ "$1" = "--build" ] 
then
	mkdir ${BASE}/Reference
	./build_indexes.sh ${BASE}/Reference ${GENOME} ${GENES}
	INDEX=${BASE}/Reference/Indexes
	GENES_DIR=${BASE}/Reference/Genes
else
	INDEX=${REF}/Sequence
	GENES_DIR=${REF}/Annotation/Genes
fi

#./preprocessing.sh </path/to/project - where user wants project to exist> </path/to/Data> <path/to/Reference Genome Files>

./preprocessing.sh ${BASE} ${DATA} ${INDEX} ${GENES_DIR} ${ADAPTERS}
