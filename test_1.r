setwd("/Users/spencer/Desktop/Data_Course/Data_Course/Exam_1/")

df = read.csv("DNA_Conc_by_Extraction_Date.csv")

names(df)

levels(df$DNA_Concentration_Katy)
plot(levels(df$DNA_Concentration_Katy), ), type = "h")

str(df)
 
duration = df$DNA_Concentration_Katy
hist(duration, right=FALSE)     

duration2 = df$DNA_Concentration_Ben
hist(duration2, right = FALSE)

summary(df$DNA_Concentration_Katy)
summary(duration2)

year = df$Year_Collected

boxplot(duration ~ year, data = df, xlab ="year", ylab = "DNA Concentration", main = "Katy's Extractions")

boxplot(duration2 ~ year, data = df, xlab ="year", ylab = "DNA Concentration", main = "Ben's Extractions")
jpeg(filename = "plot1.jpeg" )
