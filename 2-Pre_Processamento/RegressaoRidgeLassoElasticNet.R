install.packages("glmnet")
library(glmnet)

?glmnet

# Definir area de trabalho. 

setwd("C:/Users/jgo_awd/Documents/Ciencia_de_Dados/Didatica-Tech/2-Pre_Processamento")

library(dplyr)

#Importando base de dados 

df <- read.csv("kc_house_data.csv") %>%
  select(-id, -date, -sqft_basement, -zipcode, -lat, -long)

View(df)

df <- as.matrix(df)

# separando dados de treino e teste - 70 % 

set.seed(1)
filtro <- sample(1:nrow(df), nrow(df)*0.7)

x_treino <- df[filtro, -1 ]
y_treino <- df[filtro, 1]

x_teste <- df[-filtro, -1]
y_teste <- df[-filtro, 1]

View(x_teste)

# Criando o modelo de regressão - Ridge
# alpha = 0 -> Ridge 

modelo <- glmnet(x_treino, y_treino, alpha = 0, lambda = 1)

# Prevendo os preços no dataset de teste 
Prev <- predict(modelo,x_teste)

# calculo do coeficiente de determinacao R2. 
# R2 = (SQT - SQres /SQT )

SQt = sum((mean(y_teste) - y_teste ) **2)
SQres = sum ((Prev - y_teste)**2)
R2ridge = (SQt - SQres) / SQt
R2ridge

# Criando o modelo de regressão Lasso 
# alpha = 1 -> Lasso


modelo <- glmnet(x_treino, y_treino, alpha = 1, lambda = 1)


# Prevendo os preços no dataset de teste 
Prev <- predict(modelo,x_teste)

# calculo do coeficiente de determinacao R2. 
# R2 = (SQT - SQres /SQT )

SQt = sum((mean(y_teste) - y_teste ) **2)
SQres = sum ((Prev - y_teste)**2)
R2lasso = (SQt - SQres) / SQt
R2lasso

# Criando a regressão - Elastic net 
# 0 < alplha <1 -> Elastic net

modelo <- glmnet(x_treino, y_treino, alpha = 0.5, lambda = 1)

# Prevendo os preços no dataset de teste 
Prev <- predict(modelo,x_teste)

# calculo do coeficiente de determinacao R2. 
# R2 = (SQT - SQres /SQT )

SQt = sum((mean(y_teste) - y_teste ) **2)
SQres = sum ((Prev - y_teste)**2)
R2elasticnet = (SQt - SQres) / SQt
R2elasticnet






















