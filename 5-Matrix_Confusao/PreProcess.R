setwd("C:/Users/jgo_awd/Documents/Ciencia_de_Dados/Didatica-Tech/5-Matrix_Confusao")

# Normalização 

df <- data.frame(altura =c(1.5,1.4,1.6,1.8),
                 peso =c(40,45,60,80))

df

library(caret)

?preProcess


# Scale - Valor dividido pelo desvio padrão

scale <- predict(preProcess(df,method = "scale"), df)
scale


sd(c(1.5,1.4,1.6,1.8))
c(1.5,1.4,1.6,1.8) / 0.1707825

sd(c(40,45,60,80))
c(40,45,60,80) / 17.96
