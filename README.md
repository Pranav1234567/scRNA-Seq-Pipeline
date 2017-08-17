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
- shyaml at this link: https://github.com/0k/shyaml
- sircel at this link: https://github.com/pachterlab/sircel 

Alternatively, if you are a Mac/Linux user you can run the download_analysis_tools.sh
script to download these tools after you have installed homebrew/Linuxbrew package manager
and have installed PyPi - Python Package Index. 

Once you have downloaded these tools, you can download/clone the repo.

### Usage

In order to run the pipeline,
modify the config.yaml script by opening it in a text editor, changing the directories listed. Then, in the command-line run this script by typing ./run.sh [options].

### Options

` --build ` --> to build alignment index files (default is to input index files) <br /> 
` --generateBarcodes ` --> to have the pipeline generate cell Barcodes, given that there were no barcodes provided <br />
` --[alignment] ` --> (Must provide this option or pipeline will halt!) either type '--bowtie2', '--bwa', '--tophat2', or '--hisat2' <br />

Notes: Making barcodes functionality uses the python package sircel, whose source code is slightly modified. The following code in split_reads.py is commented out to delay demultiplexing to later in the pipeline.

```python
print('Splitting reads by cell')
	output_files['split'] = write_split_fastqs( 
		(reads_assigned_db,
		reads_assigned_pipe, 
		output_dir, 
		reads_unzipped, 
		barcodes_unzipped))
```

STAR index building and alignment are yet to be configured. <br />

For any questions, please feel free to reach out to pnpiano@gmail.com.
   
