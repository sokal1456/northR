library(shiny)
library(ggplot2)
library(fivethirtyeight)

# Define UI for application that plots college graduate  -----------
ui <- fluidPage(
  
  # Sidebar layout with a input and output definitions --------------
  sidebarLayout(
    
    # Inputs: Select variables to plot ------------------------------
    sidebarPanel(
      
      # Select variable for y-axis ----------------------------------
      selectInput(inputId = "y", 
                  label = "Y-axis:",
                  choices = c("employed", "employed_fulltime", "unemployed"), 
                  selected = "employed_fulltime"),
      
      # Select variable for x-axis ----------------------------------
      selectInput(inputId = "x", 
                  label = "X-axis:",
                  choices = c("major_category", "major"), 
                  selected = "major_category"),
    # Select variable for line type -----------------------------------
    selectInput(inputId = "line", 
                label = "Line Type:",
                choices = c("dashed", "dotted"),
                selected = "dashed"),
 
  # Show data table ---------------------------------------------
  checkboxInput(inputId = "show_data",
                label = "Show data table",
                value = TRUE)
  ),
    # Output: Show scatterplot --------------------------------------
    mainPanel(
      plotOutput(outputId = "scatterplot"),
      DT::dataTableOutput(outputId = "college_data")
    )
  )
)

# Define server function required to create the scatterplot ---------
server <- function(input, output) {
  
  # Create scatterplot object the plotOutput function is expecting --
  output$scatterplot <- renderPlot({
    ggplot(data = college_recent_grads, aes_string(x = input$x, y = input$y)) +
      geom_line(linetype = input$line)+
      geom_point()+
      theme(axis.text.x = element_text(angle = 90, hjust = 1))
  })
  
  output$college_data <- DT::renderDataTable(
    if(input$show_data){
      DT::datatable(data = college_recent_grads, 
                    options = list(pageLength = 10), 
                    rownames = FALSE)
    }
  )
}


# Run the application -----------------------------------------------
shinyApp(ui = ui, server = server)