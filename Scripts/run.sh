#!/bin/bash

#./preprocessing.sh </path/to/project - where user wants project to exist> </path/to/Data> <path/to/Reference Genome Files>
 
BASE="/Users/Pranav/Documents/scripts"
DATA="/Users/Pranav/Documents/Research/AnalysisResults/Raw/SRR3106546.sra"
REF="/Users/Pranav/Documents/Research/AnalysisResults/Reference"
ADAPTERS="/Users/Pranav/Documents/Research/AnalysisResults/adapters.fa"

./preprocessing.sh ${BASE} ${DATA} ${REF} ${ADAPTERS}
