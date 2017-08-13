#!/bin/bash

# If your current OS is MacOS and have downloaded the package manager homebrew 
# or you have a Linux OS and have downloaded Linuxbrew, you can alternatively 
# download the necessary analysis software through running this script 
# ./download_analysis_tools.sh

brew tap homebrew/science

#FASTQC java application
brew install fastqc

#SRATOOLKIT
brew install sratoolkit

#SAMTOOLS
brew install samtools

#BAMTOOLS
brew install bamtools

#bowtie2
brew install bowtie2

#hisat2
brew install hisat2

#tophat2
brew install tophat

#STAR
brew install Rna-star

#BWA
brew install bwa

#HTSeq-count ---- this requires python and it uses PyPi, so make sure to have this

pip install 'matplotlib>=1.4'
pip install Cython
pip install 'pysam>=0.9'
pip install HTSeq

#shyaml 
pip install shyaml
