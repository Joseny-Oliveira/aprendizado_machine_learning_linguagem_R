# Objetivo: repetir instruções 

# Como ? 
# Criando funcções 

# qual a soma dos valores de a? 

a <- c (423,464,69,519,123,258)
View(a)

# solução 

x <- 0
for (i in a) {
  x <- x + i
}
print(x)

# e a soma dos valores em b  ? 

b <- c(51,36,123,98,23,37,63,3)

x <- 0
for (i in b){
  x <- x +i
}
print (x)

# Precisamos realizar 50 somas no codigo ? 

soma <- function(y){
  x <- 0 
  for (i in y) {
    x <- x + i
  }
print(x)
}

soma(a)
soma(b)

x

soma2 <- function(y,z) {
  x <- 0
  c <- 0
  for (i in y ){
    c <- c + 1
    x <- z[c] + i
    print(x)
  }
}

soma2(a,b)
soma2(b,a)

# Precisavamos criar essas funções ? 

a+b

sum(a)
sum(b)























