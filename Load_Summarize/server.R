#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(plotly)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  
  # Load file and create data frame
  dataset <- reactive({
    data = input$file
    if(is.null(data)){
      return()
    }
    
    read.table(data$datapath, sep = input$sep, header = input$header)
  })
  
  # Output full dataset to 'Table' tab
  output$table <- renderTable({
    dataset()
  })
  
  # Update variable selection menu with column names from dataset
  observe ({
    updateSelectInput(session, "column", choices = names(dataset()[-1]))
  })
  
  # Output summary statistics to 'Summary' tab
  output$summary <- renderPrint({
    summary(dataset()[-1])
  })
  
  # Output plots to 'Plots' tab
  output$histogram <- renderPlot({
    hist(dataset()[,input$column], 
         breaks = as.numeric(input$bin),
         main = paste("Histogram of ", input$column), 
         xlab = as.character(input$column))
  })
  
  output$pairs <- renderPlot({
    pairs(~., data=dataset()[-1], main="Pairs Matrix")
  }, height = 800)
})
