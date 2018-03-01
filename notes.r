setwd("/Users/spencer/Desktop/Data_Course/Data_Course/assignments/")

setwd

list.files()[1:5]
df = read.csv("Fake_grade_data.csv")

names(df)

row.names(df) <- df$Student # how to name rows
names(df) #shows the names
df = df[,-c(1,2)] #removing columns

df$total = rowSums(df) #adding a new column and suming up the points

A = df[df$total >= 700,] #creating a new data with just totals over 700
A[order(A$total,decreasing = TRUE),] #reording data, and making it in decending order with the largest on top


sort(A$total)

sample(df$total, 3)

levels(dat$Headwidth)[levels(dat$Headwidth)=="41mm"] <- "41.000" #change levels names

## try http:// if https:// URLS are not supporte
source("https://bioconductor.org/biocLite.R")
biocLite(c("GenomicFeatures", "AnnotationDbi"))
update()


library("devtools")
devtools::install_github("benjjneb/dada2")


  #For practie data set.
library(gapminder)
df = gapminder
glimpse(df)


?Save

