# Carrega bibliotecas
install.packages("deldir")
install.packages("sf")
install.packages("rnaturalearth")
install.packages("rnaturalearthdata")
library(deldir)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)


# Lê o arquivo CSV (substitua o caminho correto)
df <- read.csv("C:/Users/anton/Downloads/Cidades do Paraná com Estações Metereológicas - Estações (1).csv", header = TRUE, sep = ",")

# substitui vírgulas por pontos nas coordenadas
df$Latitude <- as.numeric(gsub(",", ".", df$Latitude))
df$Longitude <- as.numeric(gsub(",", ".", df$Longitude))

sum(is.na(df$Latitude))  
sum(is.na(df$Longitude))
df[is.na(df$Latitude), ] 
df[is.na(df$Longitude), ]  


df <- df[!is.na(df$Latitude) & !is.na(df$Longitude), ]
df$Latitude <- as.numeric(gsub(",", ".", df$Latitude))
df$Longitude <- as.numeric(gsub(",", ".", df$Longitude))

# Verifica se há 33 cidades
print(nrow(df))  # Deve retornar 33

# Gera o diagrama de Voronoi
voronoi <- deldir(df$Longitude, df$Latitude)

# Obtém a silhueta sexy do Paraná
brazil_map <- ne_states(country = "Brazil", returnclass = "sf")
parana_map <- brazil_map[brazil_map$name == "Paraná", ]

# Plota o mapa e o diagrama de Voronoi
plot(st_geometry(parana_map), col = "lightgray", main = "Diagrama de Voronoi - Paraná")
plot(voronoi, add = TRUE)
points(df$Longitude, df$Latitude, col = "blue", pch = 19, cex = 1.5)
text(df$Longitude, df$Latitude, labels = df$Cidade, pos = 3, cex = 0.8)
