
library(vegan)

setwd("C:/Users/spencer/Desktop/Data_Course/Data_Course/code_examples/Vegan_Example/")
meta = read.delim("vegan_example_metadata.tsv", sep = "\t")
otu = read.delim("vegan_example_otu_table.tsv", sep = "\t", row.names = 1)


names(otu)
otu$Tax_Name
tax = otu$Tax_Name
otu$Tax_Name = NULL


t_otu = as.data.frame(t(otu))


diversity(t_otu)
levels(meta$Ecosystem)

identical(row.names(t_otu), as.character(meta$Sample_ID))

adonis(t_otu ~ meta$Ecosystem)

NMDS = metaMDS(t_otu)
NMDS$points
MDS1 = NMDS$points[,1]
MDS2 = NMDS$points[,2]

plot(MDS1,MDS2)

library(ggplot2)

df = data.frame(MDS1 = MDS1, MDS2=MDS2, Ecosystem = meta$Ecosystem)

ggplot(df, aes(x=MDS1, y=MDS2,color=Ecosystem)) +
  geom_point() +
  stat_ellipse()

adonis(t_otu ~ meta$Ecosystem*meta$Host)




