#!/bin/bash

#./preprocessing.sh </path/to/project> <path/to/scripts> </path/to/Data> 

cd
 
#Where this script is located
cd Desktop/scRNA-Seq-Pipeline/Scripts

BASE="/Users/Pranav/Documents/scripts"
SCRIPTS="/Users/Pranav/Documents/Scripts"
DATA="/Users/Pranav/Documents/Research/AnalysisResults/Raw/SRR3106546.sra"

./preprocessing.sh ${BASE} ${SCRIPTS} ${DATA}
