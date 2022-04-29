# Naive Bayes 

df <- iris

install.packages("naivebayes")
library(naivebayes)
library(caret)

# Criar o modelo 

set.seed(1)
modelo_Naive <- train(Species ~. , 
                      data =df,
                      method = "naive_bayes",
                      trControl = trainControl(method = "cv",
                                               number = 5))

mean(modelo_Naive$resample$Accuracy)
