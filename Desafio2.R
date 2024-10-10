install.packages("devtools")
devtools::install_github("statsbomb/StatsBombR")
library(StatsBombR)
library(ggplot2)
library(dplyr)
install.packages("ggsoccer")
library(ggsoccer)


# Funções disponíveis no respositório do statsbomb no github para pegar freedata.
comp <- FreeCompetitions()
matches <- FreeMatches(comp)

# Filtrando a final da copa do mundo para encontrar o ID da partida

final_copa_2022 <- matches|> filter(match_id == 3869685)

# Encontradndo todos os dados em 360 da final da copa.
events <- get.matchFree(final_copa_2022)

colnames(events)

# Identificando o id do Messi

messi_id <- events|>filter(player.name == 'Lionel Andrés Messi Cuccittini') |> select(player.id)
messi_id <- unique(messi_id)
messi_id

# Filtrando para encontrar somente as atividades de chute do Messi
messi_shots <- events|>filter(player.name == 'Lionel Andrés Messi Cuccittini' & type.name == 'Shot')

messi_shots

# Pegando a localização inicial dos chutes

messi_shots <- messi_shots %>% 
  mutate(x_loc_start = location[1], 
         y_loc_start = location[2])

#Localização final dos chutes 

messi_shots <- messi_shots %>% 
  mutate(x_loc_end = shot.end_location[1], 
         y_loc_end = shot.end_location[2])


# Probabilidade de gol (xG) para os chutes de Messi
messi_shots <- messi_shots %>% 
  mutate(xG = round(shot.statsbomb_xg, 2))

# Categorizar chutes como gol ou não gol
goal_shots <- messi_shots %>% filter(shot.outcome.name == 'Goal')
non_goal_shots <- messi_shots %>% filter(shot.outcome.name != 'Goal')





# Separando as coordenadas de localização de Messi para as colunas x e y
messi_shots <- messi_shots %>%
  mutate(x_loc_start = sapply(location, function(x) if (is.null(x)) NA else x[1]),
         y_loc_start = sapply(location, function(x) if (is.null(x)) NA else x[2]),
         x_loc_end = sapply(shot.end_location, function(x) if (is.null(x)) NA else x[1]),
         y_loc_end = sapply(shot.end_location, function(x) if (is.null(x)) NA else x[2]))

# Desenhar o campo e os chutes do Messi
ggplot() +
  annotate_pitch(dimensions = pitch_statsbomb) +  # Desenha o campo no estilo StatsBomb
  theme_pitch() +  # Estiliza o campo
  coord_flip(c(60,120),c(0,85)) +  # Ajusta a orientação correta do campo
  
  # Plotar os locais de início dos chutes
  geom_point(data = messi_shots, aes(x = x_loc_start, y = y_loc_start), color = "black", size = 2) +
  
  # Plotar as setas dos chutes que resultaram em gol (azul)
  geom_segment(data = filter(messi_shots, shot.outcome.name == "Goal"), 
               aes(x = x_loc_start, y = y_loc_start, 
                   xend = x_loc_end, yend = y_loc_end), size = 1,
               arrow = arrow(type = "open", length = unit(0.1, "inches")), color = "blue1") +
  
  # Plotar as setas dos chutes que não resultaram em gol (vermelho)
  geom_segment(data = filter(messi_shots, shot.outcome.name  != "Goal"), 
               aes(x = x_loc_start, y = y_loc_start, 
                   xend = x_loc_end, yend = y_loc_end), size = 1,
               arrow = arrow(type = "open", length = unit(0.1, "inches")), color = "red4") +
  
  # Adicionar texto com xG em cada local de chute
  geom_text(data = messi_shots, aes(x = x_loc_start, y = y_loc_start, label = paste0(round(xG, 2), " xG")),
            vjust = +2, color = "darkgreen", size = 3) +
  
  labs(title = "Messi's Shots in the World Cup Final 2022",
       subtitle = "Shots in blue (goals) and red (non-goals), with xG displayed",
       x = "Field X", y = "Field Y") +
  theme_minimal()

           
colnames(messi_shots)                                            
                                                            
