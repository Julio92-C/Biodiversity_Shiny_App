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
library(dplyr)
library(readr)
library(leaflet)
library(shinyWidgets)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    # Input dataset
    # raw_data <- reactive({
    #     raw_data <- read.csv(file = "../data/poland.csv", sep = ",")
    # })
    
    raw_data <- read.csv(file = "../data/poland.csv", sep = ",")
    
    
    output$mytable1 = DT::renderDataTable({
        DT::datatable(raw_data)
    })
    
    
    
    # Picker for selecting/searching species.
    output$species_choices <- renderUI(
        
            shinyWidgets::pickerInput(
            inputId = "species_name",
            label = "Vernacular or Scientific Name",
            multiple = T,
            choices = c(raw_data["scientificName"], raw_data["vernacularName"]),
            selected = c("Orthilia secunda", "Lentinus tigrinus", "Corvus frugilegus"),
            options = list(
                `actions-box` = TRUE,
                `live-search` = TRUE,
                `live-search-placeholder` = "Search",
                `none-selected-text` = "Select Fields",
                `tick-icon` = "",
                `virtual-scroll` = 10,
                `size` = 6
            )
        )
    )
    
    state <- reactiveValues()
    
    leafletServer("main_map", state)
    # set.seed(122)
    # histdata <- rnorm(500)
    # output$plot1 <- renderPlot({
    #     data <- histdata[seq_len(input$slider)]
    #     hist(data)
    #})

})
