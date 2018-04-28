### first was ran in Git bash
cd ~/Desktop/Data_Course/Data_Course/Exam3

alias fqtofa='sed -n '\''1~4s/^@/>/p;2~4p'\'''
for fn in *.fastq; do fqtofa $fn > $fn.fasta; done

 for fn in *.fasta; do cut -f 6 -d ";" *.fasta $fn > $fn.trim; done


###then in R i started to work on the Data.

```{r}
library(vegan)
setwd("C:/Users/spencer/Desktop/Data_Course/Data_Course/code_examples/Vegan_Example/")
meta = read.delim("vegan_example_metadata.tsv", sep = "\t")
otu = read.delim("vegan_example_otu_table.tsv", sep = "\t", row.names = 1)
```

###I then tried to compare the two data sets.
```{R}
names(otu)
otu$Tax_Name
tax = otu$Tax_Name
otu$Tax_Name = NULL


t_otu = as.data.frame(t(otu))


diversity(t_otu)
levels(meta$Ecosystem)

identical(row.names(t_otu), as.character(meta$Sample_ID))

adonis(t_otu ~ meta$Ecosystem)
```