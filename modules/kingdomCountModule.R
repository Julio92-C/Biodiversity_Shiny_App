library(plotly)

# Module kingdomCount UI
kingdomCountUI <- function(id, height) {
  ns <- NS(id)
  
  
  plotlyOutput(ns("plotly_kingdomCount"), height = height)
}

# Module kingdomCount Server
kingdomCountServer <- function(id, filter_data) {
  stopifnot(is.reactive(filter_data))
  
  moduleServer(id, function(input, output, session) {
    ns <- NS(id)
    
    output$plotly_kingdomCount <- renderPlotly({
      #input_data
      filter_data <- filter_data()
      
      # Kingdom Types Frequency
      q <- ggplot(filter_data, aes(x=factor(kingdom), fill=scientificName))
      q <- q + labs(x="Kingdom", y="Frequency")
      q <- q + geom_bar(stat="count", width=0.7, color="black")
      q <- q + scale_x_discrete(limits=c("Animalia", "Plantae", 
                                         "Fungi"))
      q <- q +  theme_classic()
      q <- q + theme(plot.title = element_text(hjust = 0.5))
      q <- q + theme(legend.position="none")
      q
      
      # Plot dataset with PLOTLY ####
      fig2 <- plotly::ggplotly(q)
      fig2
      
    })
  })
}
