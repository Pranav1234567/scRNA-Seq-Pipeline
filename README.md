# scRNA-Seq-Pipeline

This repository handles creating a analysis pipeline for single cell RNA-seq data using a combination of shell scripts, python packages, genomic analysis tools and R scripts.

Layout of directories created:

```
├── Base Directory (location of project results)
	├── Preprocess
		├── Raw
			├── SRR***_1.fastq 
			├── SRR***_2.fastq
		├── QC
			├── Original (QC for original FASTQs)
			├── Demux (QC for demultiplexed reads)
			├── Trimmed and Demuxed (QC for trimmed and demultiplexed reads)
		├── Info
			├── Sircel Output (extra file barcodes.tab for demultiplexing)
		├── Demux
			├── folder containing FASTQ file 1, demultiplexed
			├── folder containing FASTQ file 2, demultiplexed
		├── Trim
			├── folder containing FASTQ file 1, demultiplexed and trimmed
			├── folder containing FASTQ file 2, demultiplexed and trimmed
		├── Align
			├── folder (i.e. ‘bowtie2’ or other alignment procedure)
				├── folders (corresponding to cell id)
				.
				.
				.
		├── Counts
			├── folder (i.e. ‘bowtie2’ or other alignment procedure)
				├── counts for each cell (txt files)
				├── GeneExpressionMatrix.csv
	├── Reference (if building Indexes)
		├── Genes
			├── GFF/GTF file
		├── Indexes
			├── Index folder (i.e. ‘Bowtie2Index’ contains all the Index files)
```

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
modify the config.yaml script by opening it in a text editor, changing the directories listed. If you opt for generating barcodes, make sure the redis server is running. Then, in the command-line run this script by typing ./run.sh [options].

### Options

` --build ` --> to build alignment index files (default is to input index files) <br /> 
` --generateBarcodes ` --> to have the pipeline generate cell Barcodes, given that there were no barcodes provided <br />
` --[alignment] ` --> (Must provide this option or pipeline will halt!) either type '--bowtie2', '--bwa', '--tophat2', '--STAR' or '--hisat2' <br />

Notes: 

When not building indexes, make sure the REF variable in config.yaml points to a directory that is structured like so:

```
REF 
├── Sequence
	├── Index folder (containing all the indexes, i.e. 'Bowtie2Index')               
├── Annotation
	├── Genes
		├── GTF/GFF file
```

Making barcodes functionality uses the python package sircel, whose source code is slightly modified. The following code in split_reads.py is commented out to delay demultiplexing to later in the pipeline.

```python
print('Splitting reads by cell')
	output_files['split'] = write_split_fastqs( 
		(reads_assigned_db,
		reads_assigned_pipe, 
		output_dir, 
		reads_unzipped, 
		barcodes_unzipped))
```

Quality Control reports can be produced by uncommenting the following segments of code in Scripts/preprocessing.sh

```
#echo "------------------------------------"
                #echo "Generating quality control reports (2 FASTQ files) using FASTQC..."
                #echo "------------------------------------"
                #mkdir ${QC}/original/
                #fastqc --threads 8 ${RAW}/${rawname}_1.fastq -o ${QC}/original
                #echo "-----------------------------------------"
                #fastqc --threads 8 ${RAW}/${rawname}_2.fastq -o ${QC}/original
                #echo "DONE generating quality control reports using FASTQC"
                echo "---------------------------------------"
```

```
 : '
        #Quality Reports for demuxed Cells
                chmod 777 demuxQC.sh
                mkdir ${QC}/demux
                ./demuxQC.sh ${DEMUX} ${rawname} ${QC}/demux $NUMCELLS
        '
```

```
: '
        #Quality Reports for trimmed Cells
                chmod 777 trimDemuxQC.sh
                mkdir ${QC}/trim
                ./trimDemuxQC.sh ${TRIM} ${rawname} ${QC}/trim $NUMCELLS
        '
```

Default location of the cell barcode/umi for barcode generation is given by the values in extractBarcodes.sh. 

STAR index building and alignment are yet to be configured. <br />

For any questions, please feel free to reach out to pnpiano@gmail.com.
   
