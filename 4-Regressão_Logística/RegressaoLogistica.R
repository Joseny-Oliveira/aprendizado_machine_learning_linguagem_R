setwd("C:/Users/jgo_awd/Documents/Ciencia_de_Dados/Didatica-Tech/4-Regressão_Logística")

library(dplyr)
library(caret)

# Importando dados
 
df <- read.csv("Data_train_reduced.csv") 

View(df)

str(df)

# Verificar produtos 

unique(df$Product.ID)
levels(df$Product)

df$Product <- NULL

# Percentual de dados faltantes 

NAs <- round(colSums(is.na(df))*100 / nrow(df),2)
NAs [NAs > 0]

names(NAs[NAs > 39])

del <- names(NAs[NAs > 39])

# Deletar variaveis com mais de 39 % de dados faltantes

df <- select(df, -del)

NAs <- round(colSums(is.na(df))*100 / nrow(df),2)
names(NAs[NAs>0])

summary(df$q8.7)
summary(df$q8.12)

summary(as.factor(df$q8.7))
summary(as.factor(df$q8.12))

# Alterar NAs para 2 - não informado
df$q8.7[is.na(df$q8.7)] <-2
df$q8.12[is.na(df$q8.12)] <-2

anyNA(df)

# Correlação  

library(corrplot)
corrplot(cor(df), method = "color", tl.pos = 'n')

View(cor(df))
summary(df$s7.involved.in.the.selection.of.the.cosmetic.products)

corrplot(cor(df[1:4]), method = "color")

# Excluindo 

df$s7.involved.in.the.selection.of.the.cosmetic.products <- NULL
df$Respondent.ID <- NULL
df$q1_1.personal.opinion.of.this.Deodorant <- NULL

# Criando o modelo 

set.seed(1)
modelo <- train(Instant.Liking ~ ., 
                data = df,
                method = "glmnet",
                trControl = trainControl(method = "cv",
                                         number = 5))
# Acuracia 

modelo

df$Instant.Liking <- as.factor(df$Instant.Liking)


# Ajuste fino 

View(modelo$results[1:3])
modelo$bestTune$lambda
seq(0.1,1, length.out = 19)
alpha <-seq(0.1,1, length.out = 19)
lambda <- modelo$bestTune$lambda

ajuste <- expand.grid(alpha = alpha,
                      lambda = lambda)

# Modelo 1 

set.seed(1)
modelo1 <- train(Instant.Liking ~ .,
                data = df,
                method = "glmnet",
                tuneGrid = ajuste, 
                trControl = trainControl(method = "cv", 
                                         number = 5))
modelo1$bestTune
mean(modelo1$resample$Accuracy)
View(modelo1$results[1:3])

# Modelo 2 

alpha <- c(0.25,0.4)
seq(0.001 , 1, length.out =10)
lambda <- seq(0.001 , 1, length.out =10)

ajuste <- expand.grid(alpha = alpha,
                      lambda = lambda)

set.seed(1)
modelo2 <- train(Instant.Liking ~ .,
                 data = df,
                 method = "glmnet",
                 tuneGrid = ajuste, 
                 trControl = trainControl(method = "cv", 
                                          number = 5))
modelo2$bestTune
mean(modelo2$resample$Accuracy)
View(modelo2$results[1:3])


mean(modelo$resample$Accuracy)
mean(modelo1$resample$Accuracy)
mean(modelo2$resample$Accuracy)





