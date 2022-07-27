#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Load packages 
library(shiny)
library(DT)
library(readr)
library(leaflet)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    # Input dataset
    raw_data <- reactive({
        multimedia <- read.csv(file = "../data/poland.csv", sep = ",")
    })
    
    
    output$mytable1 = DT::renderDataTable({
        DT::datatable(raw_data())
    })
    
    set.seed(122)
    histdata <- rnorm(500)
    output$plot1 <- renderPlot({
        data <- histdata[seq_len(input$slider)]
        hist(data)
    })

})
