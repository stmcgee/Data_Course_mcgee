library(dada2)
library(vegan)

path <- "c:/Users/spencer/Desktop/Data_Course/Data_Course_mcgee/Final_Project/SpencerMcGee_Seqs_and_Metadata/"
list.files(path)

setwd(path)

snmeta = read.csv("Snail_MetaData.csv")
read.csv("Snail_MetaData.csv")



fq.files = dir(path = getwd(), full.names = TRUE, pattern = ".fastq")

plotQualityProfile(fq.files[12])

# get filenames for files without path
filt.files = dir(path = getwd(), full.names = FALSE, pattern = ".fastq")

# make new directory
dir.create(file.path(getwd(),"filtered"))

# stringent quality filter to remove N's etc


for(i in filt.files){
  fastqFilter(i,paste0(getwd(),"/filtered/",i,".filt"))
  
}

setwd(file.path(paste0(getwd(),"/filtered")))
filtered = dir(path = getwd(), pattern = ".filt")

dr = derepFastq(filtered)
err = learnErrors(dr)

plotErrors(err)

clean = dada(dr,err)

SeqTable = makeSequenceTable(clean)

?assignTaxonomy


taxonomy = assignTaxonomy(SeqTable, refFasta = "c:/Users/spencer/Desktop/Data_Course/Data_Course_mcgee/Final_Project/sh_general_release_dynamic_01.12.2017.fasta")

 taxa.print <- taxonomy # Removing sequence rownames for display only
rownames(taxa.print) <- NULL
taxa.print

which(names(as.data.frame(SeqTable)) %in% row.names(as.data.frame(taxonomy)))
RSV = as.data.frame(SeqTable)

taxa = as.data.frame(taxonomy)
View(RSV)
names(RSV) <- paste0(taxa$Family,"_",taxa$Genus)
View(RSV)

