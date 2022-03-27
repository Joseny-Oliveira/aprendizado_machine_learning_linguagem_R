# Definir area de trabalho 

setwd("C:/Users/jgo_awd/Documents/Ciencia_de_Dados/Didatica-Tech")

# Importando base de dados 

df <- read.csv("DataFrame.csv", sep = ";")

# Analisando um data frame 

View(df1)

# Tipos de dados

str(df)
summary(df)

# selecionando variaveis 
df
df[1]
df$DIA_SEM

Col1 <- df[1] 
Col2 <- df$DIA_SEM

class(df$DIA_SEM)
class(Col2)
class(Col1)

# Modificando o DF 

# Excluindo variavel 

df$ONIBUS <- NULL 
df

# Alterando o tipo de variavel dentro do DF 

df$UPS
summary(df$UPS)
df$UPS <- as.factor(df$UPS)
df$UPS
summary(df$UPS)


# Criando uma nova variavel dentro do df

df$Nova <- "a"
class(df$Nova)
df$Nova <- c(2,5,10)
df$Nova <- c(2,5,10,NA,NA,NA,NA,NA,NA)
df$Nova <- NULL

df$Nova <- NA
df$Nova[1:3] <-  c(2,5,10)
class(df$Nova)








