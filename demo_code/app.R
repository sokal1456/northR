library(fivethirtyeight)

ui <- fluidPage(
  selectInput("data", label = "experiment",
              choices = unique(airline_safety$airline)),
  verbatimTextOutput("summary"),
  tableOutput("table")
)

server <- function(input, output, session) {
  output$summary <- renderPrint({
    dataset <- get(input$data, "package:fivethirtyeight", inherits = FALSE)
    summary(dataset)
  })
  
  output$table <- renderTable({
    dataset <- get(input$data, "package:fivethirtyeight", inherits = FALSE)
    dataset
  })
}