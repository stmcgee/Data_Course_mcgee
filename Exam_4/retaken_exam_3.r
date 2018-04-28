### first was ran in Git bash
cd ~/Desktop/Data_Course/Data_Course/Exam3

#alias fqtofa='sed -n '\''1~4s/^@/>/p;2~4p'\'''
#for fn in *.fastq; do fqtofa $fn > $fn.fasta; done
# grep -c "^>" *.fasta
# mv Sample1.fastq.fasta Sample1.fasta
# mv Sample2.fastq.fasta Sample2.fasta

#for fn in *.fasta; do cut -f 6 -d ";" *.fasta $fn > $fn.trim; done


###then in R i started to work on the Data.

library(vegan)
setwd("C:/Users/spencer/Desktop/Data_Course/Data_Course/Exam3/")
meta = read.csv("exam3_metadata.csv")
otu = read.csv("exam3_otu_table.csv")


###I then tried to compare the two data sets.

names(otu)
meta2 = subset(meta, meta$SampleType %in% c("Soil","rhizosphere"))
s_r_samples = meta2$SampleID
otu2 = otu[,names(otu) %in% s_r_samples]

t_otu2 = t(otu2)

adonis(t_otu2 ~ meta2$SampleType * meta2$Location)


S_meta = subset(meta2, SampleType == "Soil")
R_meta = subset(meta2, SampleType == "rhizosphere")

S_otu = otu2[,names(otu2) %in% S_meta$SampleID]
R_otu = otu2[,names(otu2) %in% R_meta$SampleID]

max_s = max(rowSums(S_otu))
max_r = max(rowSums(R_otu))

S_max_tax = which(rowSums(S_otu) == max_s)
r_max_tax = which(rowSums(R_otu) == max_r)

otu$Consensus.lineage[S_max_tax]
otu$Consensus.lineage[r_max_tax]
