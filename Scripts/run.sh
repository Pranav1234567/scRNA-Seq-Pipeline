#!/bin/bash

#./preprocessing.sh </path/to/project> </path/to/Data> </path/to/SRAToolkit> </path/to/FastQC>

cd 
#Where this script is located
cd Desktop/scRNA-Seq-Pipeline/Scripts

SCRIPTS="/Users/Pranav/Documents/scripts"
DATA="/Users/Pranav/Documents/Research/AnalysisResults/Raw/SRR3106546.sra"
TOOLKIT="/Users/Pranav/Documents/Research/AnalysisTools/sratoolkit/bin"
FASTQC="/Applications/FastQC.app/Contents/MacOS/fastqc"

./preprocessing.sh ${SCRIPTS} ${DATA} ${TOOLKIT} ${FASTQC} 
