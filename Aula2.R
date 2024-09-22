# Aula 2 
# Estamos na primeira aula no laboratório de computadores. De código somente utilizamos um código para criar um gráfico 3D. 

### PACOTES --------------------------------------------------------------------

install.packages("rgl")
require(rgl)

### DATASET --------------------------------------------------------------------
iris

### PLOT2D ---------------------------------------------------------------------
plot(iris$Sepal.Length,
     iris$Sepal.Width,col=iris$Species)


### PLOT3D ---------------------------------------------------------------------
plot3d(iris$Sepal.Length,
       iris$Sepal.Width, 
       iris$Petal.Length,col=as.numeric(iris$Species),
       size=5)
