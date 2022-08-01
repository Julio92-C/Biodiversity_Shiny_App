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
library(htmltools)
library(scales)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    #Input dataset
    raw_data <- reactive({
        raw_data <- df
    })
    
    
    output$mytable1 = DT::renderDataTable({
        DT::datatable(raw_data())
    })
    
    output$name_choices <- renderUI(
        selectizeInput(inputId = "scientificName", 
                       label = "Select Vernacular or Scientific Name",
                       selected = c("Grus grus", "Alces alces", "Pieris napi"),
                       choices = c(raw_data()["scientificName"], raw_data()["vernacularName"]),
                       multiple = T,
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
    
    output$name <- ({
        names <- renderText(input$scientificName)
        names
    })
    
    # # Filter the dataset by scientificName or vernacularName
    filter_data <- eventReactive(input$scientificName, {
        validate(
            need(input$scientificName, "Please select a Scientific or Vernacular name")
        )
      
        filter_data <- dplyr::filter(raw_data(),raw_data()$scientificName %in% input$scientificName)
        
        # Filter the dataset by individualCount > 100
        # input$updatePlot
        # filter_data <- dplyr::filter(filter_data, filter_data$individualCount > input$slider)
      
    }, ignoreNULL = FALSE)
    
    
    # Module Leaflet Server
    leafletServer("main_map", filter_data)
    
    kingdomCountServer("plotly_kingdomCount", filter_data)
    
    # Module timeLine Server
    timelineServer("plotly_timeline", filter_data)
    
    # set.seed(122)
    # histdata <- rnorm(500)
    # output$plot1 <- renderPlot({
    #     data <- histdata[seq_len(input$slider)]
    #     hist(data)
    # })

})
