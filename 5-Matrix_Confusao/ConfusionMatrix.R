setwd("C:/Users/jgo_awd/Documents/Ciencia_de_Dados/Didatica-Tech/5-Matrix_Confusao")

# Pacote com dataset
library(mclust)

# Carregando o dataset

df <- wdbc
df$ID <- NULL

# Quantidade de cada classe
table(df$Diagnosis)

# Proporcao de cada classe

prop.table(table(df$Diagnosis)) 

library(caret)

# Criando matriz com linhas dos dados de treino - 70 % 

set.seed(1)
filtro <- createDataPartition(y=df$Diagnosis, p=0.7, list = F)

# dados de treino e teste 

treino <- df[filtro,]
teste <- df[-filtro,]

# Criando o modelo 

set.seed(1)
modelo <- train(Diagnosis ~ ., 
                data = treino, 
                method = "glmnet",
                tuneLength = 4,
                trControl = trainControl(method = "cv",
                                         number = 5))

mean(modelo$resample$Accuracy)

Prev <- predict(modelo, teste)

View(data.frame(teste$Diagnosis,Prev))


# Confusion matrix 

#install.packages("gmodels")
library(gmodels)


CrossTable(Prev, 
           teste$Diagnosis,
           dnn = c('Previsto','Real'),
           prop.chisq = F,
           prop.t = F,
           prop.r = F,
           prop.c = F)

?CrossTable


#Confusion matrix no Caret
?confusionMatrix

confusionMatrix(Prev, 
                teste$Diagnosis,
                dnn = c ('Previsto','Real'))

# Acuracia = Soma dos acertos / 4 casos  
(106+58) / (106+58+5+1)


# Probabilidades 

PrevProb <- predict(modelo, teste, type = "prob")

View(round(PrevProb,2))

PrevProb <- PrevProb$B

install.packages("pROC")
library(pROC)

# Sensibilidade = 1 
# TPR = Sensitivity = TP / (TP + FN)

# Especificidade = 1 
# FPR = 1 - Specificity = FP / (FP + TN)

# Curva ROC

ROC <- roc(teste$Diagnosis ~ PrevProb, levels = c ("M","B"))

?roc

plot(ROC)

# Area sob a curva 
ROC$auc

View(round(data.frame(ROC$sensitivities,
                      ROC$specificities,
                      ROC$thresholds
                    ,  2)))


# Resumindo o modelo

confusionMatrix(Prev,
                teste$Diagnosis,
                dnn = c('Previsto','Real'))

ROC$thresholds[75]

PrevT <- PrevProb
PrevT[PrevT>ROC$thresholds[75]] <- "B"
PrevT[PrevT !="B"] <- "M"
PrevT <- as.factor(PrevT)




confusionMatrix(PrevT,
                teste$Diagnosis,
                dnn = c('Previsto','Real'))

























