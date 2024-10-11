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
df <- read.csv("https://raw.githubusercontent.com/victortaouil/CE303_2024/refs/heads/main/Cidades%20do%20Paran%C3%A1%20com%20Esta%C3%A7%C3%B5es%20Metereol%C3%B3gicas%20-%20Esta%C3%A7%C3%B5es.csv", header = TRUE, sep = ",")


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
df$ID <- 1:nrow(df)

# Plota o mapa e o diagrama de Voronoi
par(mar = c(3.5, 3.5, 3.5, 3.5))
plot(st_geometry(parana_map), col = "lightgray", main = "Diagrama de Voronoi - Paraná")
plot(voronoi, wlines = "tess", main = "Diagrama de Voronoi - Paraná", add = TRUE)
points(df$Longitude, df$Latitude, col = "violet", pch = 19, cex = 1.5)
text(df$Longitude, df$Latitude, labels = df$N.de.referência, pos = 3, cex = 0.8)

legend("bottomright", legend=c(df$Cidade), cex=0.8)