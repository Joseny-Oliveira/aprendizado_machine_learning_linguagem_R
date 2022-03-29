# Definir area de trabalho

setwd("C:/Users/jgo_awd/Documents/Ciencia_de_Dados/Didatica-Tech/4-Regressão_Logística")

# Pacote com o dataset de prática

#install.packages("mclust")

library(mclust)
library(dplyr)
library(caret)

?wdbc

# carregando o dataset 

df <- wdbc
View(df)


df$ID <- NULL

str(df) # Todas as variaveis são numericas 

# Verificando dados faltantes 

anyNA(df)

# Correlação 

library(corrplot)
corrplot(cor(df), method = "color")


# Criando o modelo 

set.seed(1)
modelo <- train(Diagnosis ~ ., 
                data = df,
                method = "glmnet",
                trControl = trainControl(method = "cv",
                                         number = 5))
# Acuracia 

modelo
modelo$bestTune
mean(modelo$resample$Accuracy)
View(modelo$results[1:3])


# Ajuste Fino (Alpha / modelo1)

seq(0.1, 1 , length.out = 20)
alpha <- seq(0.1, 1 , length.out = 20)
lambda <- modelo$bestTune$lambda

ajuste <- expand.grid(alpha = alpha,
                      lambda = lambda)
set.seed(1)
modelo1 <- train(Diagnosis ~ .,
                 data = df,
                 method = "glmnet",
                 tuneGrid = ajuste, 
                 trControl = trainControl(method = "cv", 
                                          number = 5))

modelo1$bestTune
mean(modelo1$resample$Accuracy)
View(modelo1$results[1:3])


# Ajuste Fino (Lambda / modelo2)
alpha <- c(0.1,0.6)
lambda <- seq(0.001 , 1, length.out =10)
ajuste <- expand.grid(alpha = alpha,
                      lambda = lambda)

set.seed(1)
modelo2 <- train(Diagnosis ~ .,
                 data = df,
                 method = "glmnet",
                 tuneGrid = ajuste, 
                 trControl = trainControl(method = "cv", 
                                          number = 5))


modelo2$bestTune
mean(modelo2$resample$Accuracy)
View(modelo2$results[1:3])


# Medindo os 3 modelos
mean(modelo$resample$Accuracy)
mean(modelo1$resample$Accuracy)
mean(modelo2$resample$Accuracy)






# Modelo extra da correção  

set.seed(1)
modelo3 <- train(Diagnosis ~ .,
                 data = df,
                 method = "glmnet",
                 tuneLength = 4, 
                 trControl = trainControl(method = "cv", 
                                          number = 5))

modelo3$bestTune
mean(modelo3$resample$Accuracy)
