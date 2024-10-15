# Aula dia 14/10/2024 

#Sankey graphic
install.packages("networksD3")
install.packages('networkD3')
library("dplyr")
library(dplyr)
library(networkD3)


nos <- tibble(names = c("EUA e Canada","Europa, OM, Áfica","LaAm","Asia e Pacifico","Receita Total","CMV","Lucro Bruto","Lucro Operacional"
                        , "Custo Operacional","Lucro Líquido","IR","Juros","Marketing","Tech e Dev","Adm Geral"))

links <- tibble(source = c(0,1,2,3,
                           4,4,
                           6,6,
                           7,7,7,
                           8,8,8
                           ),
                target = c(4,4,4,4,
                           5,6,
                           7,8,
                           9,10,11,
                           12,13,14
                           ),
                value = c(4.3, 3.0,1.2,1.1
                          ,4.4,5.2
                          ,2.6,1.8,
                          2.1,0.4,0.089,
                          0.6,0.7,0.4)) # não coloca o valor dos 100% poruqe não inserimos o ponto de nó dele

links


plot <- sankeyNetwork(Links = links, Nodes = nos, Source = 'source',Target = 'target', Value = 'value',
                      NodeID = "names", units = 'Bi', fontSize = 12, nodeWidth = 10)
plot

