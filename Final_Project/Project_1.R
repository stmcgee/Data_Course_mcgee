library(dada2)

path <- "c:/Users/spencer/Desktop/Data_Course/Data_Course_mcgee/Final_Project/SpencerMcGee_Seqs_and_Metadata/"
list.files(path)

setwd(path)
snmeta = read.csv("Snail_MetaData.csv")


