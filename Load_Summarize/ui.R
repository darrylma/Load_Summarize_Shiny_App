#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Load and Summarize Data"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       fileInput("file", "Upload file"),
       h5("Max file size (5MB)"),
       h4("-----------------------------------------"),
       h5("Parameters for reading file"),
       radioButtons("sep", "Separator", 
                    choices = c(Comma=",", Semicolon=";", Tilde="~",Pipeline="|",Tab="\t")),
       checkboxInput("header", "Is there a header?", value = TRUE),
       h4("-----------------------------------------"),
       h5("Parameters for plotting histogram"),
       selectInput("column", "Select variable from dataset", ""),
       sliderInput("bin", "Select number of bins", min = 10, max = 40, step = 5, value = 10)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(type="tabs",
        tabPanel("Instructions", 
                 h3("How to Use the Load and Summarize Data Shiny App"),
                 br(),
                 h4("Objective"),
                 h5("The purpose of this shiny app is to facilitate the process of loading and summarizing a dataset"),
                 br(),
                 h4("Instructions"),
                 h5("1. Click 'Browse' button to load in a dataset"),
                 h5("2. Select a file and click 'Open'"),
                 h5("3. Navigate to 'Table' tab and check that data is loaded in properly. If not, tweak 'Separator' and 'header'Header' parameters until data is loaded properly."),
                 h5("4. Nagivate to 'Histogram' tab to view the frequency count for each variable"),
                 h5("5. 'Select a variable from dataset' you would like to view in the histogram and 'Select number of bins' to control granularity of each bin"),
                 br(),
                 h5("Note: Example csv files have been provided to test the shiny app")),
        
        tabPanel("Table", tableOutput("table")),
        tabPanel("Summary", verbatimTextOutput("summary")),
        tabPanel("Plots", plotOutput("histogram"), plotOutput("pairs"))
      )
    )
  )
))
