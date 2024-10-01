## Aula 6 - CE303
install.packages("circlize")
install.packages("vcd")

library("circlize")
library("vcd")

dados <- c( "v1"= c(rep('F',4),rep('M',5),'F','M'),
            "v2" = c('I',"I","B","I","B","R","B","R","B","R","I"))
df <- data.frame(table(dados))

chordDiagram(df, col = seq(1,10))
