# Desafio 1.
install.packages("ggplot2")
install.packages("dplyr")
install.packages("maps")
install.packages("mapproj")
library("ggplot2")
library("dplyr")
library("maps")
library("mapproj")

# Criar dataframe com estados e status de recall
states <- data.frame(
  state = c("California", "Nevada", "Idaho", "Illinois", "Michigan", "Oregon", 
            "Wisconsin", "Arizona", "New Jersey", "Colorado", "Louisiana", 
            "North Dakota", "Alaska", "Rhode Island", "Washington", "Montana", 
            "Georgia", "Kansas", "Minnesota", "South Dakota", "Alabama", "Wyoming", 
            "Utah", "Texas", "Mississippi", "New Mexico", "Oklahoma", "Maine", 
            "New Hampshire", "Vermont", "Massachusetts", "Connecticut", 
            "New York", "Pennsylvania", "Delaware", "Maryland", "Virginia", 
            "North Carolina", "South Carolina", "Florida", "Tennessee", 
            "Kentucky", "Indiana", "Missouri", "Arkansas", "Iowa", "West Virginia",
            "Hawaii", "Kentucky", "Nebraska", "Ohio", "Virginia"),
  
  status = c("No cause required for recall
and >5 months ciculation period", 
             "No cause required for recall", "No cause required for recall", 
             "No cause required for recall", "No cause required for recall", 
             "No cause required for recall", "No cause required for recall", 
             "No cause required for recall", "No cause required for recall", 
             "No cause required for recall", "No cause required for recall", 
             "No cause required for recall", 
             "Can recall a governor", "Can recall a governor", "Can recall a governor", 
             "Can recall a governor", "Can recall a governor", "Can recall a governor", 
             "Can recall a governor", "No recall", "No recall", "No recall", 
             "No recall", "No recall", "No recall", "No recall", "No recall", 
             "No recall", "No recall", "No recall", "No recall", "No recall", 
             "No recall", "No recall", "No recall", "No recall", "No recall", 
             "No recall", "No recall", "No recall", "No recall", 
             "No recall", "No recall", "No recall", "No recall", "No recall", 
             "No recall", "No recall", "No recall", "No recall", "No recall","No recall")
)

#Agora temos que combinar o vetor states com o df map
states <- states |> mutate(state = tolower(state), status = ifelse(status == "All states", "No recall",status))

map <- map_data("state")
map <- inner_join(map,states,by = c("region" = "state"))



map1 <- ggplot(map, aes(x = long, y = lat)) + 
  geom_polygon(aes(fill = status,  group = region), color = 'black') + coord_map() +
  labs(title = 'The recall process in California is easier than most',
       x = NULL,
       y = NULL,
       fill = 'Recall Status') +
  scale_fill_manual( values = c("No cause required for recall
and >5 months ciculation period" = 'orange',
                                'No cause required for recall' = 'gray10',
                                'Can recall a governor' = 'grey55',
                                'No recall' = 'grey95'))+
  theme_void()+
  theme( legend.position = 'right',
         legend.location = 'plot',
         legend.text = element_text(size=7.5),
         legend.key.size = unit(0.5, 'cm'),
         legend.key.height = unit(0.30, 'cm'), 
         legend.key.width = unit(0.30, 'cm'), 
         legend.spacing.y = unit(0.5,'cm')
         )
map1



