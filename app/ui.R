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
library(shinyWidgets)
library(semantic.dashboard)

# Global variables
# source("data/multimedia.csv", local = T)
# source("modules/leafletModule.R", local = T)
source("utils.R", local = T)



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
                        tags$h2("Species Tables"),
                        DT::dataTableOutput(outputId = "mytable1")
                ),
                
                tabItem(tabName = "charts",
                        #tags$h2("Species Charts"),
                        tags$br(),
                        tags$h2("In this section you can view the total number of species in Poland."),
                            fluidRow(
                                box(
                                    class="buttons",
                                    uiOutput("name_choices")
                                    
                                   
                            # box(plotOutput("plot1", height = 250)),
                            # box(
                            #     title = "Controls",
                            #     sliderInput("slider", "Number of observations:", 1, 100, 50)
                            ),
                            
                            box(
                                tags$div(
                                        textOutput("name"),
                                        leafletOutput("main_map")
                                         #leafletUI("main_map", width = 6), "Location of Species", 
                                )
                            ),
                            
                            fluidRow(
                                class = "map-pies",
                                
                                
                                #column(width = 6, plotContainer(plotlyOutput("subplots"), "Top 5 Kingdoms, Families, and Cities"))
                            ),
                        )
                        )
            ),
        
            
        )
        
)
