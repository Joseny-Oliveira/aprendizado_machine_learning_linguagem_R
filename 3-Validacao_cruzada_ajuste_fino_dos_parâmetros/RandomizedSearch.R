setwd("C:/Users/jgo_awd/Documents/Ciencia_de_Dados/Didatica-Tech/3-Validacao_cruzada_ajuste_fino_dos_parâmetros")


# Importando a base de dados

df <- read.csv("Admission_Predict.csv")
df$Serial.No. <- NULL

library(caret)

# Criando o modelo 

controle <- trainControl(method = "cv",
                         number = 5)

set.seed(1)
modelo <- train(Chance.of.Admit ~.,
                data =df,
                method = "glmnet",
                tuneLength = 10,
                trControl = controle,
                metric = "Rsquared")

modelo$bestTune
mean(modelo$resample$Rsquared)

View(modelo$results[c(1,2,4)])

summary(modelo$resample$Rsquared)



set.seed(1)
modelo1 <- train(Chance.of.Admit ~.,
                data =df,
                method = "glmnet",
                tunegrid = data.frame(alpha = 0.2, lambda = 0.003781034),
                trControl = controle)

modelo1$results$Rsquared  


# Ajuste fino

seq(0.001,0.009 , length.out = 20)
seq(0.2, 0.5, length.out = 05)
 
lambda <- seq(0.001,0.009 , length.out = 20)
alpha <- seq(0.2, 0.5, length.out = 5)

valores <- expand.grid(alpha = alpha,
                       lambda = lambda)

set.seed(1)
modelo <- train(Chance.of.Admit ~.,
                data =df,
                method = "glmnet",
                tuneGrid = valores,
                trControl = controle,
                metric = "Rsquared")
modelo$bestTune
mean(modelo$resample$Rsquared)

summary (modelo$resample$Rsquared)


print(c(
  paste("Resultado do primeiro modelo:",
        round(modelo1$results$Rsquared *100,2),
        "%"),
  paste("Resultado após o ajuste:",
        round(mean(modelo$resample$Rsquared)*100,2),
        "%")
))