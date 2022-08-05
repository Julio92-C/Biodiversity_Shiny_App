
# Base image https://hub.docker.com/u/rocker/
FROM rocker/shiny:latest

# system libraries of general use
## install debian packages
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    libxml2-dev \
    libcairo2-dev \
    libpq-dev \
    libssh2-1-dev \
    unixodbc-dev \
    libcurl4-openssl-dev \
    libssl-dev

## update system libraries
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean

## Install packages and dependecies
RUN R -e "install.packages(pkgs=c('shiny','plotly','leaflet', 'shinyWidgets', 'DT', 'semantic.dashboard', 'dplyr', 'readr', 'ggplot2', 'htmltools', 'scales', 'shinytest2', 'testthat', 'renv'), repos='https://cran.rstudio.com/')"

RUN mkdir /root/app

COPY Biodiversity_Shiny_App /root/shiny_save

EXPOSE 3838

# RUN dos2unix /usr/bin/shiny-server.sh && apt-get --purge remove -y dos2unix && rm -rf /var/lib/apt/lists/*
CMD ["R", "-e", "shiny::runApp('/root/shiny_save', host='0.0.0.0', port=3838)"]
