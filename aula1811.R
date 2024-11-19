# Aula 18/11

# Shiny 

install.packages("shiny")
require(shiny)

#DEFININDO INTERFACE DE USUÁRIO
ui<- fluidPage(
  #PAINEL DE TÍTULO DA PÁGINA
  titlePanel("TÍTULO DA PÁGINA"),
  #TIPO DE LAYOUT
  sidebarLayout(
    #PAINEL LATERAL
    sidebarPanel(h4("MENU LATERAL"),h2("TEXTO 2"), h3("TEXTO 3")),
    #PAINEL PRINCIPAL
    mainPanel(h1("PAGINA PRINCIPAL"),h2("PRINCIPAL 2"), h3("PRINCIPAL 3"))
  )
)





  

# Caĺculo do IMC
  
ui <- fluidPage(
  titlePanel("Estamos calculando IMC, você deverá fornecer algumas informações"),
    
  sidebarLayout(
      sidebarPanel(
            "Digite as informações pedidas: ",
            textInput(inputId = 'name',label = "Nome", value ="" ),
            numericInput(inputId = 'peso', label = 'Peso',value =""),
            numericInput(inputId = 'altura', label = 'Altura', value ='')
        
      )
      ,
      mainPanel(
        textOutput("texto"),
        textOutput("imc_loco"),
        plotOutput("grafico")
        
        
      )))


server <- function(input,output) {
  
  output$texto <-renderText(paste("Olá", input$name))
  output$imc_loco <- renderText(paste("Seu IMC é: ",as.character(input$peso/(input$altura^2)), "Parabéns"))
  output$grafico <- renderPlot({
  x <- seq(24.9 - 3*4.5, 24.5 + 3*4.5, length.out = 500)
  plot(x, dnorm(x,24.9,4.5), type ='l', ylab = "Distribuição", xlab = "IMC")
  abline( v = input$peso/(input$altura^2), col = 'tomato')
    
  })
  
  
}     


    

shinyApp(ui = ui, server = server)  





