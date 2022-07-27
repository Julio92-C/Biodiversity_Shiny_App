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
library(leaflet)
library(semantic.dashboard)

# Global variables
# source("data/multimedia.csv", local = T)

# load custom stylesheet
# tags$link(rel = "stylesheet", type="text/css", href="www/style.css")

# Define UI for application 
dashboardPage(
    dashboardHeader(title = "Biodiversity in Poland"),
    dashboardSidebar(sidebarMenu(
        menuItem(tabName = "home", text = "Home", icon = icon("home")),
        menuItem(tabName = "species_tables", text = "Species Tables", icon = icon("table")),
        menuItem(tabName = "charts", text = "Species Charts", icon = icon("tasks"))
    )),
    
    dashboardBody(
        tabItems(
                tabItem(tabName = "home",
                        # tags$h2("Home"),
                        tags$img(class="image1", style="margin: auto; padding-top: 25px; padding-bottom: 25px", src="poland_biodiversity.jpeg", alt="biodiversity in poland", width="80%", height="600"),
                        includeHTML("./www/intro.html")
                        
                        
                    ),
            
                tabItem(tabName = "species_tables",
                        tags$h2("Species Tables"),
                        DT::dataTableOutput(outputId = "mytable1")
                ),
                
                tabItem(tabName = "charts",
                        tags$h2("Species Charts"),
                        tags$br(),
                        tags$h2("In this section you can view a couple of barcharts with the the total number of species per category for every park."),
                            fluidRow(
                            box(plotOutput("plot1", height = 250)),
                            box(
                                title = "Controls",
                                sliderInput("slider", "Number of observations:", 1, 100, 50)
                            )
                        )
                        )
            ),
        
            
        )
        
)
