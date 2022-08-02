# Module timeLine UI
timelineUI <- function(id, height) {
  ns <- NS(id)
  
  #timelineOutput(ns("plotly_timeline"))
  plotlyOutput(ns("plotly_timeline"), height = height)
}

# Module timeLine Server
timelineServer <- function(id, filter_data) {
  stopifnot(is.reactive(filter_data))
  
  moduleServer(id, function(input, output, session) {
    ns <- NS(id)
    
    output$plotly_timeline <- renderPlotly({
      #input_data
      filter_data <- filter_data()
      
      # Set up the date variable
      date <- as.Date(filter_data$eventDate)
      
      # Display time line with plotly
      b <- ggplot(filter_data, aes(x=date, y=individualCount, 
                                        fill=locality, size=2, col=family, shape=kingdom, group=scientificName))
      b <- b + labs(x="Date", y="Number of Occurrences")
      #b <- b + facet_wrap( ~ kingdom)
      b <- b + geom_point(alpha = 0.5)
      b <- b + scale_x_date(breaks = date_breaks("1 year"),
                            labels = date_format("%Y"))
      b <- b + theme_bw()
      b <- b + theme(legend.position="none")
      b <- b + theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))
      b
      
      # Plot dataset with PLOTLY ####
      fig1 <- plotly::ggplotly(b)
      fig1
      
    })
  })
}
