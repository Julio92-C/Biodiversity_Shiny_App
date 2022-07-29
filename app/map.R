
library(dplyr)
library(readr)
library(leaflet)

# Load the dataset
poland <- read_csv("data/poland_dataset2.csv")
head(poland)
colnames(poland)

# Set up some variable
scientificName <- unique(poland$scientificName)
locality <- as.factor(poland$locality)

# Filter the dataset by scientificName == Alces alces and locality == Warszawa
alcesAlces <- dplyr::filter(poland, poland$scientificName == "Alces alces" & poland$locality == "Poland - Podlaskie")

# Unique value
alcesAlces_reduced <- head(alcesAlces)

m <- leaflet()
m <- addTiles(m)
m <- addMarkers(m, lng=alcesAlces_reduced$longitudeDecimal, lat=alcesAlces_reduced$latitudeDecimal, popup=poland$scientificName)
m

# CLEAN UP #################################################

# Clear environment
rm(list = ls()) 

# Clear packages
detach("package:datasets", unload = TRUE)

# Clear plots
dev.off()  # But only if there IS a plot

# Clear console
cat("\014")  # ctrl+L

# Clear mind :)
