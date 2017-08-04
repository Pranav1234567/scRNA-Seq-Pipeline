#!/bin/bash
#STAR - generate genome files
STAR --runThreadN 8 --runMode genomeGenerate --genomeDir /Users/Pranav/Documents/Research/AnalysisResults/Reference/Mus_musculus_UCSC_mm10/Mus_musculus/UCSC/mm10/Sequence/ --genomeFastaFiles /Users/Pranav/Documents/Research/AnalysisResults/Reference/Mus_musculus_UCSC_mm10/Mus_musculus/UCSC/mm10/Sequence/WholeGenomeFasta/genome.fa --sjdbGTFfile /Users/Pranav/Documents/Research/AnalysisResults/Reference/Mus_musculus_UCSC_mm10/Mus_musculus/UCSC/mm10/Annotation/Genes/genes.gtf --sjdbOverhang 74
