## Aula 6 - CE303
# Fazendo um gráfico de cordas
install.packages("circlize")
install.packages("vcd")

library("circlize")
library("vcd")

dados <- data.frame( "v1"= c(rep('F',4),rep('M',5),'F','M'),
            "v2" = c('I',"I","B","I","B","R","B","R","B","R","I"))
df <- data.frame(table(dados))
set.seed(10)
chordDiagram(df, col = seq(1,10),grid.border = 'black', diffHeight = convert_height(1, "cm"))


## Gráfico HEXBIN

install.packages("hexbin")
library("hexbin")

#Utilizando o pacote iris 
data(iris)
hh <- hexbin(iris$Sepal.Length,iris$Sepal.Width)
plot(hh)


# Gráfico de bolhas 

x <- c(10,20,15,20,40)
y <- c(1,4,5,1,5)
z <- c(41,22,20,11,50)
R <- c(2,3)

symbols(x=x, y =y, circles = z, inches = 1, bg = R)

text(x,y,c(rep("inserindo texto",5)), col= 'black')
legend(30,2, c('cat1','cat2'),pch = 19, cex =1.5, col= c(2,3))
title("Bubble Chart, here we go!")

# GRáfico de barras empilhadas

ano <- c(rep(2022,12), rep(2023,12))
mes <- seq(1,12)
ven <- rpois(24,10)

barra <- rbind(ven[1:12],ven[13:24])
barra
barplot(barra)

#Colocando as barras separadas
barplot(barra, beside =T)

# Gráfico empilhado 100%

v <- rbind(ven[1:12],ven[13:24])

#Aplicar, por coluna a função soma.

soma <- apply(v,2,sum)
soma
# pegamos cada um dos elementos e dividimos pela soma da coluna, dessa forma temos a porcentagem

p <- v%*%diag(1/soma)
p
barplot(p, beside = F)
