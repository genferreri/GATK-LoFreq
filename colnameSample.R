#!/usr/local/bin/Rscript

file1 <- list.files(path = ".", pattern = "\\.tsv")

library(readr)
AF.Cov.clean.temp <- read_delim(file1, "\t", escape_double = FALSE, col_names = FALSE, trim_ws = TRUE)
colnames(AF.Cov.clean.temp) <- c("Segment", "Position", "Coverage", "REF", "ALT", "AF", "length", "Sample")
write.table(AF.Cov.clean.temp, file='AF.Cov.clean.temp.tsv', sep="\t", col.names = NA)

