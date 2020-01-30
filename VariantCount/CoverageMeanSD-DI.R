setwd("/Users/lucasmatiasferreri/Documents/226variantAnalysis/Files/DI/Concatenated")
library(dplyr)
#Import tables
DI5dpi.Cov.varQ <- read.table("DI5dpi.Cov.varQ.txt", header = FALSE)
colnames(DI5dpi.Cov.varQ) <- c("Segment", "Position", "Cov", "Sample")
#Add Group
DI5dpi.Cov.varQ["Group"]<-"varQ"
#Add day sampled
DI5dpi.Cov.varQ["day"]<-"5"


#combine into one table per day
DI1dpi.Cov.Peak <-rbind(DI1dpi.Cov.var, DI1dpi.Cov.varL, DI1dpi.Cov.varLQ, DI1dpi.Cov.varQ)
DI3dpi.Cov.Peak <-rbind(DI3dpi.Cov.var, DI3dpi.Cov.varL, DI3dpi.Cov.varLQ, DI3dpi.Cov.varQ)
DI5dpi.Cov.Peak <-rbind(DI5dpi.Cov.var, DI5dpi.Cov.varL, DI5dpi.Cov.varLQ, DI5dpi.Cov.varQ)
##plot distribution using boxplots
ggplot(DI1dpi.Cov.Peak, aes(x=Segment, y=Cov, fill=Group)) + geom_boxplot()
as.character(DI1dpi.Cov.Peak$Segment)


##Calculate Mean and SD for Coverage
DI5dpi.Cov.Peak.Mean <- DI5dpi.Cov.Peak %>% 
                        group_by(Segment, Group) %>% 
                        summarise( Cov.center = mean(Cov), sd = sd(Cov))

##Plot Mean and SD by day
DI5dpi.Cov.Peak.Mean.plot <- ggplot(DI5dpi.Cov.Peak.Mean, aes(x=Segment, y=Cov.center, color=Group)) + geom_point(size=3, position=position_dodge(width = 0.9)) +
  geom_errorbar(position=position_dodge(width=0.9), aes(ymin=Cov.center-sd, ymax=Cov.center+sd)) + #geom_jitter() +
  scale_x_continuous(breaks=c(1, 2, 3, 4, 5, 6, 7, 8)) +
  scale_y_continuous(limits = c(100, 10000)) +
  geom_hline(yintercept = 400) +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"),
        axis.text.x= element_text(), 
        axis.text.y = element_text(face="bold", size=15))
ggsave("DI5dpi.Cov.Peak.Mean.plot.pdf", dpi=300)
