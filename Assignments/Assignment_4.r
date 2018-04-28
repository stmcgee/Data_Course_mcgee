
setwd ("/Users/spencer/Desktop/Data_Course/Data_Course_mcgee/")

library(modelr)
library(broom)
library(dplyr)
library(fitdistrplus)
library(ggplot2)

df = read.csv("/Users/spencer/Desktop/Data_Course/Data_Course/data/mushroom_growth.csv")

list(df)

glimpse(df)

plot(df)

plot(fitdist(df$GrowthRate, distr = "norm"))

for (i in names(df)){
  plot(df[,"GrowthRate"] ~ df[,i], xlab = "GrowthRate", ylab = i, main = i)
}

mod1 = glm(GrowthRate ~ Species + Light + Humidity + Temperature + Nitrogen, data = df) 
summary(mod1)

mod1 = aov(GrowthRate ~ Species + Light + Humidity + Temperature + Nitrogen, data = df) 
summary(mod1)

mod2 = aov(GrowthRate ~ Species*Light*Humidity*Temperature*Nitrogen, data = df) 
summary(mod2)


