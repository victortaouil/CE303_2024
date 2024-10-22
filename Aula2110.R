# Aula 21/10/2024

## GGPLOT2

#Data + #AES + #Geom 


require(dplyr)
require(tidyverse)

data(mtcars)

head(mtcars)
str(mtcars)

# Gráfico de dispersão

ggplot(data = mtcars , aes(x = mpg,y = hp )) + geom_point(size = 3, color = 'orange3', alpha = 0.5)+
  xlab("Potencia (W)") +  #Nomeando o eixo x
  ylab("Milhas por galão")+  #Nomeando o eixo y 
  ggtitle("Relação entre Consumo e potência")+ 
  scale_x_continuous( limits =c(0,50))+  #Mudando os limites do eixo x
  #scale_x_log10()+ # Colocando uma escala diferente no eixo X
  theme_bw()+
  theme(text = element_text(size = 20, color = 'blue4'), 
        plot.title = element_text(hjust =0.5))   # Mudando a cor da legenda dos eixos e ajustando o título para o meio. 


# Fazendo um gráfico de bolhas
  

ggplot(data = mtcars , aes(x = mpg,y = hp, size =qsec )) + geom_point(color = 'orange3', alpha = 0.5)+
  xlab("Potencia (W)") +  #Nomeando o eixo x
  ylab("Milhas por galão")+  #Nomeando o eixo y 
  ggtitle("Relação entre Consumo e potência")+ 
  scale_x_continuous( limits =c(0,50))+  #Mudando os limites do eixo x
  scale_size_continuous("Teste")+ # Mudando o titulo da legenda
  #scale_x_log10()+ # Colocando uma escala diferente no eixo X
  theme_bw()+
  theme(text = element_text(size = 20, color = 'blue4'), 
        plot.title = element_text(hjust =0.5),
        legend.position = "bottom",
        legend.text = element_text(size = 10))   # Mudando a cor da legenda dos eixos e ajustando o título para o meio. 


# Realçando variáveis qualitativas

ggplot(data = mtcars , aes(x = mpg,y = hp, size =qsec, color = factor(am))) + geom_point( alpha = 0.75)+
  geom_smooth(method = 'lm', se = FALSE)+  # Colocando uma estatística dentro do 
  xlab("Potencia (W)") +  #Nomeando o eixo x
  ylab("Milhas por galão")+  #Nomeando o eixo y 
  ggtitle("Relação entre Consumo e potência")+  # Título do gráfico
  scale_x_continuous( limits =c(0,50))+  #Mudando os limites do eixo x
  scale_size_continuous(c("QSec"))+# Mudando o titulo da legenda de tamanho
  scale_color_discrete("Am")+ #Mudaria o titulo da legenda de cor
  scale_color_manual("Câmbio",labels = c("manual","automatico"), values= c("red4","green4"))+ #Mudando as cores das bolinhas
  #scale_x_log10()+ # Colocando uma escala diferente no eixo X
  theme_classic()+
  theme(text = element_text(size = 20, color = 'blue4'), 
        plot.title = element_text(hjust =0.5),
        legend.position = "right",
        legend.text = element_text(size = 10))   # Mudando a cor da legenda dos eixos e ajustando o título para o meio. 

colnames(mtcars)
]

# Fazendo FACETS

ggplot(data = mtcars , aes(x = mpg,y = hp, size =qsec, color = factor(am))) + geom_point( alpha = 0.75)+
  xlab("Potencia (W)") +  #Nomeando o eixo x
  ylab("Milhas por galão")+  #Nomeando o eixo y 
  ggtitle("Relação entre Consumo e potência")+  # Título do gráfico
  scale_x_continuous( limits =c(0,50))+  #Mudando os limites do eixo x
  scale_size_continuous(c("QSec"))+# Mudando o titulo da legenda de tamanho
  scale_color_discrete("Am")+ #Mudaria o titulo da legenda de cor
  scale_color_manual("Câmbio",labels = c("manual","automatico"), values= c("red4","green4"))+ #Mudando as cores das bolinhas
  #scale_x_log10()+ # Colocando uma escala diferente no eixo X
  facet_grid(facets = .~am)
  theme_classic()+
  theme(text = element_text(size = 20, color = 'blue4'), 
        plot.title = element_text(hjust =0.5),
        legend.position = "right",
        legend.text = element_text(size = 10))   # Mudando a cor da legenda dos eixos e ajustando o título para o meio. 

  
  
  
  ####
  count(mtcars,mpg)
  
  
  max(mtcars$mpg)
summary(mtcars$mpg)  
str(mtcars)
mtcars %>% select(where(is.logical))

mtcars %>% select(contains("am"))


require(dplyr)
require(tidyr)

car_crash = fread("data/Brazil Total highway crashes 2010 - 2023.csv.gz")
# Dados extraídos de https://www.kaggle.com/datasets/liamarguedas/brazil-total-highway-crashes-2010-2023

glimpse(car_crash)
