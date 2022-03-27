# Definir area de trabalho

setwd("C:/Users/jgo_awd/Documents/Ciencia_de_Dados/Didatica-Tech/2-Pre_Processamento")

library(glmnet)
library(dplyr)

# Importando dados

df <- read.csv("kc_house_data.csv")%>%
  select(- id, -date, -sqft_basement, -zipcode, -lat,-long)

df <- as.matrix(df)

# Separando dados de treino e teste - 70 % 

set.seed(1)

filtro <- sample(1 :nrow(df), nrow(df) *0.7)

x_treino <- df[filtro, -1]
y_treino <- df[filtro, 1]

x_teste <- df[-filtro, -1]
y_teste <- df[-filtro,1]

# Função que cria e compara os modelos 

modelos <- function(a,b,c,d,peso,elastic) {
  SQt = sum((mean(y_teste)-y_teste)**2)
  R2 <- data.frame (Linear = NA)
  
  #Linear 
  linear <- glmnet(a,b,lambda = 0)
  PrevLinear <- predict(linear,c)
  R2$Linear <- (SQt - sum((PrevLinear - d)**2)) / SQt
  
  #Ridge
  ridge <- glmnet(a,b,alpha = 0, lambda = peso)
  PrevRidge <- predict(ridge,c)
  R2$Ridge <- (SQt - sum((PrevRidge - d )**2)) / SQt 
  
  #Lasso
  lasso <- glmnet(a,b,alpha = 1, lambda = peso)
  PrevLasso <- predict(lasso,c)
  R2$Lasso <- (SQt - sum((PrevLasso - d )**2)) / SQt
  
  #Elastic Net 
  elastic <- glmnet(a,b,alpha = elastic, lambda = peso)
  PrevElastic <- predict(elastic,c)
  R2$Elastic <- (SQt - sum((PrevElastic - d )**2)) / SQt
  
  print(R2)
  
}


modelos (x_treino, y_treino, x_teste, y_teste, 1000, 0.5)
