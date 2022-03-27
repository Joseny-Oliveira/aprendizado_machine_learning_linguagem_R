setwd("C:/Users/jgo_awd/Documents/Ciencia_de_Dados/Didatica-Tech/3-Validacao_cruzada_ajuste_fino_dos_parâmetros")

df <- read.csv("Admission_Predict.csv")
df$Serial.No. <- NULL

library(caret)

# Criando o modelo

?trainControl

set.seed(1)

modelo <- train(Chance.of.Admit ~.,
                data = df,
                method = "glmnet",
                trControl  = trainControl(method = "cv", number = 5)) 



# Resultado

modelo$resample$Rsquared
summary(modelo$resample$Rsquared)
mean(modelo$resample$Rsquared)

modelo$bestTune

modelo$results

modelo$results[c(1,2,4)]
