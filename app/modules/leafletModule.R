
leafletUI <- function(id) {
  ns <- NS(id)
  # column(leafletOutput(ns("map"), ...), width = width)
  leafletOutput(ns("main_map"))
}


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
    
    
#     observe({
#       state$data
#       
#       if (is.null(state$data)) return ()
#       
#       leafletProxy(ns("map")) %>%
#         clearShapes() %>%
#         clearMarkers() %>%
#         clearMarkerClusters() %>%
#         addAwesomeMarkers(
#           lat = state$data$latitudeDecimal,
#           lng = state$data$longitudeDecimal,
#           label = state$data$scientificName,
#           #popup = NULL,
#           icon = awesomeIcons(
#             library = "fa",
#             icon = ifelse(state$data$kingdom == "Animalia", "paw", ifelse(state$data$kingdom == "Fungi", "globe", "pagelines")),
#             markerColor = ifelse(state$data$kingdom == "Animalia", "lightred", ifelse(state$data$kingdom == "Fungi", "lightblue", "lightgreen"))
#           ),
#           layerId = c(1:nrow(state$data))
#         )
#     })
  })
 }