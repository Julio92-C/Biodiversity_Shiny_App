# # Module Leaflet UI
leafletUI <- function(id) {
  ns <- NS(id)
  
  leafletOutput(ns("main_map"))
}

# Module Leaflet Server
leafletServer <- function(id, filter_data) {
  stopifnot(is.reactive(filter_data))
  
  moduleServer(id, function(input, output, session) {
    ns <- NS(id)
    
    output$main_map <- renderLeaflet({
      #input_data
      filter_data <- filter_data()
      
      # Leaflet popup features
      filter_data$popup_features <- with(filter_data, paste(
        "<p> <b>Scientific name:</b>", scientificName, " </br>",
        "<b>Vernacular name:</b>", vernacularName, "</br>",
        "<b>Kingdom:</b>", kingdom, "</br>",
        "<b>Family:</b>", family, "</br>",
        "<b>Sex:</b>", sex, "</br>",
        "<b>Locality:</b>", locality, "</br>",
        "<b>Date:</b>", eventDate, "</br>",
        "<b>Time:</b>", eventTime, "</br>",
        "<b>Count:</b>", individualCount,
        "</p>"))
      
      # Display may
      m <- leaflet()
      m <- addTiles(m)
      m <- addMarkers(m, lng=filter_data$longitudeDecimal, 
                      lat=filter_data$latitudeDecimal,
                      popup = filter_data$popup_features)
      
      m
    
    })
  })
 }