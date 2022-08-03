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
library(plotly)
library(leaflet)
library(shinyWidgets)
library(semantic.dashboard)


# Global variables
source("modules/leafletModule.R", local = T)
source("modules/timelineModule.R", local = T)
source("modules/kingdomCountModule.R", local = T)




# Define UI for application 
dashboardPage(
    dashboardHeader(title = tags$b("Biodiversity in Poland")),
    dashboardSidebar(
        color = "teal",
        sidebarMenu(
        menuItem(tabName = "home", text = "Home", icon = icon("home")),
        menuItem(tabName = "species_tables", text = "Species Tables", icon = icon("table")),
        menuItem(tabName = "charts", text = "Species Charts", icon = icon("map")),
        menuItem(tabName = "tutorial", text = "App Tutorial", icon = icon("youtube"))
    )),
    
    dashboardBody(
        tags$head(
            # load custom stylesheet
            # tags$link(rel = "stylesheet", type="text/css", href="/css/style.css")
        ),
        tabItems(
                tabItem(tabName = "home",
                        # tags$h2("Home"),
                        tags$img(class="image1", style="margin: auto; padding-top: 25px; padding-bottom: 25px", src="poland_biodiversity.jpeg", alt="biodiversity in poland", width="60%", height="500"),
                        includeHTML("./www/intro.html")
                        
                        
                    ),
            
                tabItem(tabName = "species_tables",
                        tags$h2("Species Biodiversity in Poland dataset"),
                        DT::dataTableOutput(outputId = "mytable1")
                ),
                
                tabItem(tabName = "charts",
                        #tags$h2("Species Charts"),
                        tags$br(),
                        tags$h2("In this section you can view the species biodiversity in Poland"),
                            fluidRow(
                                box(
                                    tags$h4("Select species to show"),
                                    uiOutput("name_choices")
                                    
                                   
                            
                            ),
                            
                            box(
                                tags$div(
                                        # textOutput("name"),
                                        # Module Leaflet UI
                                        leafletUI("main_map")
                                ),
                                
                            ),
                            
                            
                             box(
                                 kingdomCountUI("plotly_kingdomCount", height = 500)
                             ),
                            
                            box(timelineUI("plotly_timeline", height = 500))
                            
                        )
                    ),
                
                tabItem(tabName = "tutorial",
                        fluidRow(
                            box(
                                tags$h2("Biodiversity Shiny App Tutorial"),
                                includeHTML("./www/tutorial.html")
                                
                            ),
                            
                            box(
                                #tags$h2("YouTube Tutorial"),
                                tags$iframe(width="100%", height="415", src="https://www.youtube.com/embed/GpBizO9FOu4", title="YouTube video player", frameborder="0", allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture, allowfullscreen")
                                
                                
                            )
                        )
                        
                    )
            )
        
            
        )
        
)
