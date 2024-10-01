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
coordenadas <- data.frame(
  estado = c("CA", "NV", "ID", "IL", "MI", "OR", "WI", "AZ", "NJ", "CO", "LA", 
             "ND", "AK", "RI", "WA", "MT", "GA", "KS", "MN", "SD", "AL", "WY", 
             "UT", "TX", "MS", "NM", "OK", "ME", "NH", "VT", "MA", "CT", "NY", 
             "PA", "DE", "MD", "VA", "NC", "SC", "FL", "TN", "KY", "IN", "MO", 
             "AR", "IA", "WV", "HI", "KY", "NE", "OH", "VA"),
  latitude = c(36.7783, 38.8026, 44.0682, 40.6331, 44.3148, 43.8041, 43.7844, 34.0489, 40.0583, 
               39.5501, 30.9843, 47.5515, 61.3707, 41.5801, 47.7511, 46.8797, 32.1656, 39.0119, 
               46.7296, 43.9695, 32.3182, 43.0759, 39.3210, 31.9686, 32.3547, 34.5199, 35.0078, 
               45.2538, 43.1939, 44.5588, 42.4072, 41.6032, 40.7128, 41.2033, 38.9108, 39.0458, 
               37.4316, 35.7596, 33.8361, 27.9944, 35.5175, 37.8393, 40.2672, 37.9643, 34.7465, 
               41.8780, 38.5976, 19.8968, 37.8393, 41.4925, 40.4173, 37.4316),
  longitude = c(-119.4179, -116.4194, -114.7420, -89.3985, -85.6024, -120.5542, -88.7879, -111.0937, -74.4057, 
                -105.7821, -91.9623, -101.0020, -152.4044, -71.4774, -120.7401, -110.3626, -82.9001, -98.4842, 
                -94.6859, -99.9018, -86.9023, -107.2903, -111.0937, -99.9018, -89.3985, -105.8701, -97.0929, 
                -69.4455, -71.5724, -72.5778, -71.3824, -73.0877, -74.0060, -77.1945, -75.5277, -76.6413, 
                -78.6569, -79.0193, -81.7603, -81.7603, -86.5804, -84.2700, -86.1349, -91.8318, -93.3695, 
                -93.0977, -80.4549, -155.5828, -84.2700, -99.9018, -82.9071, -78.6569)
)

print(coordenadas)



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
and >5 months ciculation period" = 'orangered',
                                'No cause required for recall' = 'orange',
                                'Can recall a governor' = 'salmon',
                                'No recall' = 'grey95'))+
  theme_void()+
  theme( legend.position = 'right',
         legend.location = 'plot',
         legend.text = element_text(size=7.5),
         legend.key.size = unit(0.5, 'cm'),
         legend.key.height = unit(0.30, 'cm'), 
         legend.key.width = unit(0.30, 'cm'), 
         legend.spacing.y = unit(0.5,'cm')
  )+ geom_text(data = coordenadas, aes(x = longitude, y = latitude, label = estado), 
          size = 1.5, color = 'black')


map1
