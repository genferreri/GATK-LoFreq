## This script will construct the table to start the analysis.
##Takes input from LoFreq Variant analysis workflow
#setwd("/Users/lucasmatiasferreri/Documents/226variantAnalysis/Files/7dpi/DC7dpi-varLQ")

#!/usr/bin/env R

file1 <- list.files(path = ".", pattern = "\\.tsv")

library(readr)
coverage <- read_delim(file1, "\t", escape_double = FALSE, col_names = FALSE, trim_ws = TRUE)
colnames(coverage) <- c("Segment", "Position", "Cov")

#Start with the depth file and then plug the AF into 

file2 <- list.files(path = ".", pattern = "\\.vcf")

Varfreq <- read.table(file2, header = FALSE, sep = "\t")
colnames(Varfreq) <- c("Segment", "Position", "REF", "ALT", "AF") 
#Varfreq <- Varfreq[Varfreq$AF >= 0.02, ]

Varfreq$AF[Varfreq$Position == 4] <- NA #assignes NA to position 4 since this position is detected as variant because of the primers
Varfreq$REF[Varfreq$Position == 4] <- NA
Varfreq$ALT[Varfreq$Position == 4] <- NA
##The AA position 226 may bear more than one variant position. This will shift the total number of variant nucleotides in the genome by repetition of sites.
Varfreq<-Varfreq[!duplicated(Varfreq[c('Segment','Position')]),]

#merge *Varfreq with coverage table 
AF.Cov <- merge(coverage, Varfreq, by = c("Segment", "Position"), all = TRUE)

#Keep variants with coverage higher than 400
AF.Cov$AF[AF.Cov$Cov < 400] <- NA 
AF.Cov["Group"]<-"Contact" #create new colum
#AF.Cov["Sample"]<-"AO207" #create new colum
AF.Cov["length"]<- seq.int(nrow(AF.Cov)) #adds number of nucleotides from PB2 to NS consecutively. This helps to plot the entire genome consecutively

#Delete "NA" rows
AF.Cov.vcf<-na.omit(AF.Cov)
#export the table
write_tsv(AF.Cov.vcf, sep="\t")
##After this step Syn and non Syn AA analysis are produced using SNPdat in Linux
