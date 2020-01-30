setwd("/Users/lucasmatiasferreri/Documents/226variantAnalysis/Files/DI/Concatenated")
library(dplyr)
#Import table
DI3dpi.var <- read.table("DI3dpi.var.txt", header = FALSE)
colnames(DI3dpi.var) <- c("Segment", "Position", "Cov", "REF", "ALT", "Freq", "Length", "Sample")

#Add Group
DI3dpi.var["Group"]<-"varQ"

#Add day sampled
DI3dpi.var["day"]<-"3"

#combine into one table
DI.Peak <-rbind(DI1dpi.var, DI1dpi.varL, DI1dpi.varLQ, DI1dpi.varQ, 
                DI3dpi.var, DI3dpi.varL, DI3dpi.varLQ, DI3dpi.varQ, 
                DI5dpi.var, DI5dpi.varL, DI5dpi.varLQ, DI5dpi.varQ)

#Sum total number of iSNVs per sample per day
DI.Peak.Count <- DI.Peak %>% 
  group_by(Group, day) %>% 
  count(Sample)

library(ggplot2)
DI.Peak.Count.plot <- 
  
ggplot(DI.Peak.Count, aes(x=day, y=n, fill=Group)) +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"),
        axis.text.x= element_text(), 
        axis.text.y = element_text(face="bold", size=22)) + 
  geom_boxplot()