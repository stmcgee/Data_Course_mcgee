rm(list = ls())

setwd("c:/Users/spencer/Desktop/Data_Course/Data_Course_mcgee/")

# Load the libraries that you use here:
library(plyr)
library(ggplot2)
library(dplyr)
library(tidyr)
library(modelr)


############# Part 1 - Preparing wide data ################## ---------------- (30 points possible)

# read in salaries.csv
df = read.csv("c:/Users/spencer/Desktop/Data_Course/Data_Course/exam2/salaries.csv")

# This is faculty salary information from 1995 - Split up by university, state, faculty rank, and university tier

# convert to usable format so we can look at salaries as a dependent variable (10 points)
glimpse(df)
list(df)
plot(df)

df.1 = gather(df, key = "Rank", value = "Salaries", c("AssistProf","AssocProf","FullProf"))

list(df.1)
glimpse(df.1)

df.1$Rank = as.factor(mapvalues(df.1$Rank, from = c("AssistProf","AssocProf","FullProf"), to = c("Assist","Assoc","Full")))

# create boxplot of salary by University Tier, colored by Faculty Rank (10 points)
# x-axis = Tier
# y-axis = Salary
# Boxplot fill color = Rank
# Title = "Faculty Salaries - 1995"

ggplot(df.1, aes(x=Tier, y=Salaries, fill=Rank)) +
  geom_boxplot() +
  ggtitle("Faculty Salaries - 1995")


# export this boxplot to a file in your personal repository named "LASTNAME_exam2_plot1.jpeg" (10 points)

save.image("Mcgee_exam2_plot1.jpeg")



################# PART 2 ################### ------------ (70 points possible)

# read in atmosphere.csv
# this data frame has microbial diversity values over time found in atmospheric observation station air filters
# sampling date and two environmental variables [CO2] and [Aerosols] are reported for each measurement
# "Diversity" is the dependent variable

df2 = read.csv("c:/Users/spencer/Desktop/Data_Course/Data_Course/exam2/atmosphere.csv") 
glimpse(df2)

# First, check whether your response variable is normally distributed (5 points)

mod1 = aov(Diversity ~ Year+Quarter+Month+Mday+BarcodeSequence+CO2_Concentration+Aerosol_Density, data = df2)
summary(mod1)     
plot(mod1)     


# Next, convert "Year" to a factor...just because (5 points)

df2$Year <- factor(df2$Year)

# Create a simple ANOVA model with "Year" as the only explanatory variable (5 points)

mod2 = aov(Diversity ~ Year, data = df2)

summary(mod2)

# Now, create an ANOVA model that incorporates "Year", "Aerosol_Density", and their interaction (5 points)

mod3 = aov(Diversity ~ Year*Aerosol_Density, data = df2)

# Compare the two models mean-squared difference method to see which is better at making predictions 
# (20 points)

test1 = anova(mod2,mod3)


# Export the summary ANOVA table of the better model to a text file in your repository named:
# "LASTNAME_exam2_table1.txt" (10 points)

write.table(test1, "Mcgee_exam2_table1.txt", sep=",")

# use this model to predict what diversity should be for the following hypothetical conditions:
# note: only include the conditions that are part of your chosen model! (10 points)

# Year = 2007
# Quarter = "Q4"
# Month = August
# Mday = 10
# BarcodeSequence = "CTCTCTATCAGTGAGT"
# Aerosol_Density = 1000,
# CO2_Concentration = 384

df2.p <- rbind(df2.p, c(na,na,2007,Q4,))



# Now, make a pretty plot to the following specifications:
# x-axis = Day
# y-axis = Aerosol_Density
# point transparency based on values of "Diversity"
# Title: "Decadal Aerosol Density"
# Subtitle: "More aerosols contribute to greater microbial diversity in the atmosphere"



# Save this plot in your repository as "LASTNAME_exam2_plot2.jpeg" (10 points)


#### When you are all finished, push the files, including this R script, onto your GitHub repo
#### I will look at your script and look for the three properly named files that you generated


