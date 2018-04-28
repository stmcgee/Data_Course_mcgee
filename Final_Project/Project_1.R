library(dada2)

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

?knitr::knit

SeqTable = makeSequenceTable(clean)


# #taxonomy = assignTaxonomy(SeqTable, refFasta = "c:/Users/spencer/Desktop/Data_Course/Data_Course_mcgee/Final_Project/sh_general_release_dynamic_01.12.2017.fasta")
# 
# taxa.print <- taxonomy # Removing sequence rownames for display only
# rownames(taxa.print) <- NULL
# taxa.print
# 
# which(names(as.data.frame(SeqTable)) %in% row.names(as.data.frame(taxonomy)))
# RSV = as.data.frame(SeqTable)
# 
# taxa = as.data.frame(taxonomy)
# View(RSV)
# names(RSV) <- paste0(taxa$Family,"_",taxa$Genus)
# View(RSV)

#get nmsd graph look for aboundace example.

library(vegan)

otu = SeqTable

t_otu = as.data.frame(otu)

diversity(t_otu)

identical(row.names(t_otu), as.character(snmeta$InputFileName))

adonis(t_otu ~ snmeta$SiteName)

#summary(colSums(t_otu))

summary(t_otu[,1])
plot(t_otu)

NMDS = metaMDS(t(t_otu))
NMDS$points
MDS1 = NMDS$points[,1]
MDS2 = NMDS$points[,2]

plot(MDS1,MDS2)

library(ggplot2)

df = data.frame(MDS1 = MDS1, MDS2=MDS2, sitename = snmeta$SiteName)

ggplot(df, aes(x=MDS1, y=MDS2)) +
  geom_point() +
  stat_ellipse()


Heatmap = heatmap(as.matrix(t_otu))

#transpose the transpose
Heatmap_t = heatmap(as.matrix(t(t_otu)))


#color it
library(plyr)

color = as.character(mapvalues(snmeta$SiteName, from = c("D_Sievert","Ekahanui","Kaala_Bog","Kaaikukai","Skeets_Pass"), 
                               to = c("Blue","Red","Green","Yellow","Black")))

heatmap2 = heatmap(as.matrix(t(t_otu)), ColSideColors = color, col = gray.colors(100)) 

png(filename = "c:/Users/spencer/Desktop/Data_Course/Data_Course_mcgee/Final_Project/Heatmap.png")
heatmap(as.matrix(t(t_otu)), ColSideColors = color, col = gray.colors(100))
dev.off()


