setwd("C:/Users/jgo_awd/Documents/Ciencia_de_Dados/Didatica-Tech/6-KNN")

df <- iris

View(iris)
library(caret)

# Criando o modelo
set.seed(1)

modelo <- train (Species ~ .,
                 data = iris,
                method = "knn",
                tuneLength =7,
                preProcess= "scale",
                trControl = trainControl(method = "cv",
                                         number = 5))

modelo

# Modelo com preProcess center 

modelo <- train (Species ~ .,
                 data = iris,
                 method = "knn",
                 tuneLength =7,
                 preProcess= "center",
                 trControl = trainControl(method = "cv",
                                          number = 5))

modelo
