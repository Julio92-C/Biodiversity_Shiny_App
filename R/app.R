
#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Load packages 
library(shiny)
library(semantic.dashboard)
library(DT)
library(dplyr)
library(readr)
library(leaflet)
library(shinyWidgets)
library(htmltools)
library(scales)

# Global variables
source("modules/leafletModule.R", local = T)
source("modules/timelineModule.R", local = T)
source("modules/kingdomCountModule.R", local = T)


app <- shinyApp(

# Define UI for application 
dashboardPage(
  dashboardHeader(title = "Biodiversity in Poland"),
  dashboardSidebar(sidebarMenu(
    menuItem(tabName = "home", text = "Home", icon = icon("home")),
    menuItem(tabName = "species_tables", text = "Species Tables", icon = icon("table")),
    menuItem(tabName = "charts", text = "Species Charts", icon = icon("tasks"))
  )),
  
  dashboardBody(
    tags$head(
      # load custom stylesheet
      tags$link(rel = "stylesheet", type="text/css", href="/css/style.css")
    ),
    tabItems(
      tabItem(tabName = "home",
              # tags$h2("Home"),
              tags$img(class="image1", style="margin: auto; padding-top: 25px; padding-bottom: 25px", src="poland_biodiversity.jpeg", alt="biodiversity in poland", width="80%", height="600"),
              includeHTML("./www/intro.html")
              
              
      ),
      
      tabItem(tabName = "species_tables",
              tags$h2("Species Biodiversity in Poland dataset"),
              DT::dataTableOutput(outputId = "mytable1")
      ),
      
      tabItem(tabName = "charts",
              #tags$h2("Species Charts"),
              tags$br(),
              tags$h2("In this section you can view the biodiversity of species in Poland."),
              fluidRow(
                box(
                  tags$h4("Select species to show"),
                  uiOutput("name_choices")
                  
                  
                  
                ),
                
                box(
                  tags$div(
                    textOutput("name"),
                    # Module Leaflet UI
                    leafletUI("main_map")
                  ),
                  
                ),
                
                
                box(
                  kingdomCountUI("plotly_kingdomCount", height = 500)
                  #     title = "Controls",
                  #     sliderInput("slider", "Number of observations:", value = 12, min = 1, max = 100),
                  #     #actionButton("updatePlot", "Update Bar Plot", style="margin-bottom:10px")
                ),
                
                #box(plotOutput("plot1", height = 250))
                box(timelineUI("plotly_timeline", height = 500))
                
              )
      )
    )
    
    
  )
  
),

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  #Input dataset
  raw_data <- reactive({
    raw_data <- df
  })
  
  
  output$mytable1 = DT::renderDataTable({
    DT::datatable(raw_data())
  })
  
  output$name_choices <- renderUI(
    selectizeInput(inputId = "speciesName", 
                   label = "Select Vernacular or Scientific Name",
                   selected = c("Grus grus", "Melampyrum nemorosum", "Amanita muscaria"),
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
  
  ?selectizeInput
  
  output$name <- ({
    names <- renderText(input$speciesName)
    names
  })
  
  # # Filter the dataset by scientificName or vernacularName
  filter_data <- eventReactive(input$speciesName, {
    validate(
      need(input$speciesName, "Please select a Scientific or Vernacular name")
    )
    
    filter_data <- dplyr::filter(raw_data(),raw_data()$scientificName %in% input$speciesName | 
                                   raw_data()$vernacularName %in% input$speciesName)
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

)

# shinyApp(ui, server)


