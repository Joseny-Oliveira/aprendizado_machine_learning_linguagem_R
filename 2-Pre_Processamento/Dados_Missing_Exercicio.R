# Definir area de trabalho
setwd("C:/Users/jgo_awd/Documents/Ciencia_de_Dados/Didatica-Tech/2-Pre_Processamento/Base")

# Importando base de dados 
df <- read.csv("2015-building-energy-benchmarking.csv")

View(df)

# Percentual de dados faltantes maior que 1 
any(is.na(df))
NAS <- round(colSums(is.na(df))*100 / nrow(df), 2)
NAS
NAS [NAS > 1]


#Alterar NAS na variavel ENERGYSTARScore para a sua mediana 
df$ENERGYSTARScore[is.na(df$ENERGYSTARScore)] <- median(df$ENERGYSTARScore, na.rm = TRUE)
any(is.na(df$ENERGYSTARScore))

NAS [NAS > 1]

# Desafio 

# Os percentuais encontrados estarão errados 

str(df)

summary(df$Outlier)

# Transformando os dados da coluna outlier
df$Outlier[df$Outlier == ""] <- NA

#Aplicando conceito no dataset todo 
df[df == ""] <- NA
summary(df)


# DICA 
# Carregando os dados substituindo os dados faltantes por NA

df <- read.csv("2015-building-energy-benchmarking.csv", na.strings = "")

# Percentual de dados faltantes 

NAs <- round(colSums(is.na(df))*100 / nrow(df), 2)
NAs
NAs [NAs >1] 
NAS