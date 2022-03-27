library(mlbench)
data("PimaIndiansDiabetes")
df <- PimaIndiansDiabetes

cor(df)
str(df)
df$diabetes <- as.numeric(df$diabetes)
str(df)

View(df)

library(corrplot)
corrplot(cor(df))
