setwd("C:/Users/jgo_awd/Documents/Ciencia_de_Dados/Didatica-Tech/6-KNN")

# Pacote que contem o dataset
library(mclust)

# Carregando o dataset 

df <- wdbc
df$ID <- NULL

View(df)

library(caret)

# Criando matriz com linhas dos dados de treino  - 70 % 

set.seed(1)
filtro <- createDataPartition(y=df$Diagnosis, p = 0.7, list = F)

# dados de treino e teste

treino <- df[filtro,]
teste <- df[-filtro,]

# https://github.com/topepo/caret/available-models.html
# https://github.com/topepo/caret

# Criando o modelo
set.seed(1)

modelo <- train(Diagnosis ~ .,
                data = treino,
                method = "knn",
                preProcess= "scale")

mean(modelo$results$Accuracy)
modelo$bestTune$k
modelo$results

# Confusion Matrix

Prev <- predict(modelo,teste)
confusionMatrix(Prev,
                teste$Diagnosis,
                dnn =c('Previsto', 'Real'))