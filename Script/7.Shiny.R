library(shiny)

# funciones para la interfaz de la aplicacion
ui <- fluidPage(
  
  #titulo de la aplicacion
  titlePanel("Hello Shiny!"),
  
  #barra lateral 
  sidebarLayout(
    
    #barrla lateral del input
    sidebarPanel(
      
      # Input: para para modificar el valor del input
      sliderInput(inputId = "bins",
                  label = "Number of bins:",
                  min = 1,#rango minimo del input
                  max = 50,#rango maximo del input
                  value = 30) #valor de inicio cuando sea lanzada la app
      
    ),
    
    # panel principal
    mainPanel(
      
      # histogram como output
      plotOutput(outputId = "distPlot") #este es el id que se usara en el server
      
    )
  )
)

#aca se define un servidor, el cual consiste en funcioens con instrucciones sobre como se van a construir los objetos en el ui
server <- function(input, output) {
  output$distPlot <- renderPlot({#render plot debido a que definimos nuestro output como tipo plot, llama al output de nuestro ui
    x    <- faithful$waiting #data para nuestro histograma
    bins <- seq(min(x), max(x), length.out = input$bins + 1)#este debe estar activo para que se modifique el histograma
    #    bins <- seq(min(x), max(x), length.out =  6)
    
    hist(x, breaks = bins, col = "#75AADB", border = "white",#histograma con nuestro set de datos
         xlab = "Waiting time to next eruption (in mins)",
         main = "Histogram of waiting times")
    
  })
  
}
shinyApp(ui = ui, server = server) #funcion para lanzar nuestra app localmente desde nuestra sesion de R
