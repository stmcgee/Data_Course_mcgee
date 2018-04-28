
library(vegan)

setwd("C:/Users/spencer/Desktop/Data_Course/Data_Course/Exam3/")

meta = read.csv("exam3_metadata.csv")
otu = read.csv("exam3_otu_table.csv", row.names = 1)

names(otu)
otu$Consensus.lineage
otu$Consensus.lineage = NULL

t_otu = as.data.frame(t(otu))

diversity(t_otu)
row.names(t_otu)
row.names(meta)

levels(meta$SampleID)

identical(row.names(t_otu), (meta$Sample_ID))

adonis(t_otu ~ meta$Location)
