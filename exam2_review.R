library(tidyr)

x = rnorm(10)
y = rnorm(10)
z = rnorm(10)
obs = 1:10

??obs

df = data.frame(obs = obs,
                X=x,
                y=y,
                z=z)

df.1 = gather(df, key = "Stock", value = "PriceChage", c("X","y","z"))

spread(df.1, Stock, PriceChage)

df.1

aov1 = aov(PriceChage ~ Stock*obs, data = df.1)


df.1







library(dplyr)

dplyr::
  
df %>% mutate(total = x+y+z, max = max(x,y,z))







############# building a model


df2 = read.csv("../Data_Course/data/iris.csv")

plot(df2)

mod1 = aov(Petal.Length ~ Petal.Width*Species, data = df2)
mod2 = aov(Petal.Length ~ Petal.Width+Species, data = df2)

summary(mod1)
summary(mod2)
 anova(mod1,mod2)

 
 # which one is better?
 library(modelr)

 #add perticions
df2 = add_predictions(df2,mod1,var = "mod1")
df2 = add_predictions(df2,mod2,var = "mod2")

 #then plot it
 library(ggplot2)

 ggplot(df2) +
   geom_point(aes(x=Petal.Width,y=Petal.Length, color=Species)) +
   geom_smooth(aes(x=Petal.Width,y=mod1,col=Species),method = "lm") +
   geom_smooth(aes(x=Petal.Width,y=mod2,col=Species),method = "lm",linetype=5)

 ##now to see the predicted value to the actual value.
 
sqrt(mean((df2$mod1 - df2$Petal.Length)^2))
sqrt(mean((df2$mod2 - df2$Petal.Length)^2))
 
  