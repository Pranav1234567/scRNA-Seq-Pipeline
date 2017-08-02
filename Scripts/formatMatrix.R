#!/usr/bin/env Rscript
args <- commandArgs(TRUE)
infile = paste(args[1], args[2], "/matrix96.txt", sep = "")
data <- read.table(infile)
outfile = paste(args[1], args[2], "/sample.csv", sep = "")
write.csv(data, file = outfile, quote = FALSE)

