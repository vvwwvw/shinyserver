# get shiny serves plus tidyverse packages image
FROM rocker/shiny-verse:latest
# system libraries of general use
RUN apt-get update && apt-get install -y \
    sudo \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libssl-dev \
    libssh2-1-dev 
# copy the app to the image

RUN mkdir /srv/shiny-server/app
RUN mkdir /srv/shiny-server/data
#RUN mkdir /srv/shiny-server/gltcapp

#COPY app/gltcapp /srv/shiny-server/gltcapp
COPY app/shiny-server.conf /etc/shiny-server/shiny-server.conf
# select port
EXPOSE 3838

