# Criando uma reta 

peso <- c (45,50,60,55,58,56,48)
altura <- c(1.54,1.55,1.65,1.60,1.65,1.63,1.60)

plot(peso,altura)
lm(altura ~ peso)
abline(lm(altura ~ peso))


# Gerando uma massa de dados

x <- 1:250
x

rnorm(5)

y <- rnorm(250) 
y

plot (x,y)



y <- rnorm(250) + x 
y

plot (x,y)

rnorm(5, sd =30)

y <- rnorm(250 , sd =25) + x 
plot (x,y)
?rnorm


hist(rnorm(250, sd = 25))

hist(rnorm(250, mean = 1000, sd = 25))

# Definindo o numero randomico 
set.seed(1)

# criando o modelo 
?lm

lm(y ~ x)

# y = m*x + b 
# Resultado - b - coeficiente linear = -2.389 -> x = 0 
#             m - coeficiente angular = 1.028 -> inclinação da reta 

# inserindo a reta no gráfico 
abline(-2.389, 1.028)

# inserindo a reta no grafico 
abline(lm(y ~ x))

# grafico melhorado 
plot (x, y, pch = 19, col = "blue")
abline(lm(y ~ x), col = "red", lwd = 2)

?plot

install.packages("caret")
library(caret)

?createDataPartition

# criando matriz com linhas dos dados de treino - 70 % 
filtro <- createDataPartition(x, p=0.7, list = F)

# Dados de treino e teste 
teste <- data.frame(x,y)
treino <- teste[filtro,] # 70 % para treino 
teste <- teste[-filtro,] # 30 % do dataframe para teste

# Exibindo a relação dos dados

plot(treino$x, treino$y, pch =1, col= "blue")
points(teste$x, teste$y, pch = 19, col = "black")


# Criando o modelo 
modelo <- lm(y ~ x, treino)
modelo

# criando o mesmo modelo com um código diferente
modelo <- lm(y ~ ., treino) # O "." indica todas as variavies presentes no Data set. 
modelo

View(modelo)
summary(modelo)

modelo$residuals
treino$r <- abs(modelo$residuals) # Criamos uma nova variavel dentro do modelo, que trata o absoluto dos residuos

plot(treino$x, treino$y, pch =1, col= "blue")
abline(modelo, col = "black", lwd = 2)

# Passando parametro para identificar a maior margem de erro. 
points(treino$x[treino$r>50], treino$y[treino$r>50],pch =19, col = "red")

# prevendo os valores de Y 

# previsoes dados de treino com a reta. 


plot (teste$x, teste$y, pch = 19, col = "black")
abline (modelo, col = "black", lwd= 2)

?predict

teste$Previsao <- predict(modelo,teste)

# previsoes dados de treino com valores
points (teste$x, teste$Previsao, pch = 19, col = "red" )

# calculo do coeficiente de determinacao R2. 
# R2 = (SQT - SQres /SQT )

SQt = sum((mean(teste$y) - teste$y ) **2)
SQres = sum ((teste$Previsao - teste$y)**2)
R2 = (SQt - SQres) / SQt
R2

# Reta com valor medio de y 

abline(mean(teste$y), 0 , col = "blue", lwd = 2)
points(teste$x, rep(mean(teste$y), length(teste$x)), pch = 19, col = "blue")


  














