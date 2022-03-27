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

