# Definir area de trabalho 
setwd("C:/Users/jgo_awd/Documents/Ciencia_de_Dados/Didatica-Tech")
df <- read.csv("DataFrame.csv", sep = ";")

df[1]
df[1,] # retorna a primeira linha 
df[,2]
#df [linha,coluna]

df[1:6]
df[-4] # excluindo a coluna da visualização 

df[1,1]
df[1,1:6] # primeira linha da coluna 1 até 6 
df[1,-4]

df[1:3,1:6]
df[-1,-4] 
df[c(-3,-4,-5,-6)]

# Modificando o DF 

df <- df[c(-3,-4,-5,-6)]
df

# filtrando as variaveis 
df [ 1,1 ]
df$REGIAO[1]
df$AUTO [2:4]
df$UPS == 1
df[df$UPS == 1,]

# modificando o DF 
df <- df[df$UPS == 1,]

# df1 x df 

df1 <- read.csv("DataFrame.csv", sep = ";")
View(df1)
view(df)
