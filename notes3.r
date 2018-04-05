library(plyr)
library(ggplot2)
library(dplyr)
library(tidyr)


df = read.csv("c:/Users/spencer/Desktop/Data_Course/Data_Course/data/BioLog_Plate_Data.csv")

sub1 = subset(df, Substrate == "D-Cellobiose")


ggplot(df , aes(x=))

?gather
Sub1_Long = gather(sub1, key = "Time", value = "Abs", c("Hr_24","Hr_48","Hr_144"))

ggplot(Sub1_Long, aes(x=Time,y=Abs, col=Sample.ID)) +
  geom_point() +
  geom_smooth()

?mapvalues


Sub1_Long$Time = as.numeric(mapvalues(Sub1_Long$Time, from = c("Hr_24","Hr_48","Hr_144"), to = c(24,48,144)))


ggplot(Sub1_Long, aes(x=Time,y=Abs, col=Sample.ID)) + 
  geom_point() +
  geom_smooth()

df_Long = gather(df, key = "Time", value = "Abs", c("Hr_24","Hr_48","Hr_144"))

df_Long$Time = as.numeric(mapvalues(df_Long$Time, from = c("Hr_24","Hr_48","Hr_144"), to = c(24,48,144)))


substrates = levels(df_Long$Substrate)

plot.substrate = function(x){
  ggplot(df_Long[df_Long$Substrate == x,],aes(x=Time,y=Abs,col=Sample.ID)) + geom_point() + geom_smooth(se=FALSE) + ggtitle(x)
}

lapply(substrates, plot.substrate)





