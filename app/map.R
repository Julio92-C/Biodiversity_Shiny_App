
library(dplyr)
library(ggplot2)
library(plotly)
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


# m <- leaflet()
# m <- addTiles(m)
# m <- addMarkers(m, lng=alcesAlces_reduced$longitudeDecimal, lat=alcesAlces_reduced$latitudeDecimal, popup=poland$scientificName)
# m

# Filter the dataset by individualCount > 100
dataset_filtered <- dplyr::filter(poland, poland$individualCount > 100)

# Sep up variables
kingdom <- as.factor(poland$kingdom)
date <- as.Date(dataset_filtered$eventDate)
class(date)

# plot dataset with ggplot
b <- ggplot(dataset_filtered, aes(x=as.Date(eventDate), y=individualCount, 
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

?scale_x_date

# Plot dataset with PLOTLY ####
fig1 <- plotly::ggplotly(b)
fig1

df <- dplyr::group_by(poland, kingdom) %>% summarise(count = n())

# ARM Model Types Frequency
q <- ggplot(poland, aes(x=factor(kingdom), fill=kingdom))
q <- q + labs(x="Kingdom", y="Frequency")
q <- q + geom_bar(stat="count", width=0.7, color="black")
q <- q + scale_x_discrete(limits=c("Animalia", "Plantae", 
                                   "Fungi"))
q <- q +  theme_classic()
#q <- q + ggtitle("AMR: Model Types Frequency")
q <- q + theme(plot.title = element_text(hjust = 0.5))
q <- q + theme(legend.position="none")
q

# Plot dataset with PLOTLY ####
fig2 <- plotly::ggplotly(q)
fig2


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
