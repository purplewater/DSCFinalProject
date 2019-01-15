#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(NLP)
library(tm)
library(RWeka)
source("function.R")

# Define UI for application that draws a histogram
ui <- fluidPage(
  mainPanel(
    h2("Predict Next Word"),
    h5("by Miao Wang, 1/15/2019"),
    
    textInput("Tcir",label=h3("Type your sentence here:")),
    submitButton('Submit'),
    h4('string you entered : '),
    verbatimTextOutput("inputValue"),
    h4('next word :'),
    verbatimTextOutput("prediction")
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
  output$inputValue <- renderPrint({input$Tcir})
  output$prediction <- renderPrint({wordproc(input$Tcir)})
}

# Run the application 
shinyApp(ui = ui, server = server)

