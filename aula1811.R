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
        textOutput("texto")
        
      )))


server <- function(input,output) {
  
  texto <-input$name
  output$texto <- renderText(texto)
  
  
  
}     


    

shinyApp(ui = ui, server = server)  

