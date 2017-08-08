# scRNA-Seq-Pipeline

This repository handles creating a analysis pipeline for single cell RNA-seq data.

### Installation

In order to use this repository, first download the following programs:
- FastQC at this link: https://www.bioinformatics.babraham.ac.uk/projects/fastqc/ 
- sratoolkit at this link: https://www.ncbi.nlm.nih.gov/sra/docs/toolkitsoft/ 
- samtools at this link: http://www.htslib.org/
- bamtools at this link: https://github.com/pezmaster31/bamtools/wiki
- bowtie2 at this link: http://bowtie-bio.sourceforge.net/bowtie2/index.shtml 
- tophat2 at this link: https://ccb.jhu.edu/software/tophat/index.shtml
- bwa at this link: https://sourceforge.net/projects/bio-bwa/files/ 
- STAR at this link: https://github.com/alexdobin/STAR 
- HiSat2 at this link: https://ccb.jhu.edu/software/hisat2/manual.shtml
- HTSeq at this link: http://htseq.readthedocs.io/en/release_0.9.1/ 

Alternatively, if you are a Mac/Linux user you can run the download_analysis_tools.sh
script to download these tools after you have installed homebrew/Linuxbrew package manager
and have installed PyPi - Python Package Index. 

Once you have downloaded these tools, you can download/clone the repo.

### Usage

In order to run the pipeline,
modify the run.sh script by opening it in a text editor, changing the directories listed. Then, 
in the command-line run this script by typing ./run.sh [options].

Currently, this is the way to use the pipeline. In the future, I will make this easier, so 
look out for updates!  

### Options

 --build --> to build alignment index files (default is to input index files)

Notes: Making barcodes functionality is configured to produce a set number of barcodes. 
This number can be adjusted in pyscript.py. 

For any questions, please feel free to reach out to pnpiano@gmail.com.
   
