library(shiny)
ui <- fluidPage(
  
  titlePanel("Hello Shiny!")
)
server <- function(input, output) {}

shinyApp(ui = ui, server = server) 