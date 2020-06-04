setwd("C:/Users/75LPYOTT/Desktop")

data <- read.csv("scott_nover_data.csv", header=TRUE)
head(data)


#https://github.com/wmurphyrd/fiftystater
#http://eriqande.github.io/rep-res-web/lectures/making-maps-with-R.html
#file:///C:/Users/75LPYOTT/Downloads/data-visualization-2.1%20(1).pdf
#https://eriqande.github.io/rep-res-eeb-2017/map-making-in-R.html
#https://stackoverflow.com/questions/34301835/how-to-color-states-in-us-map-in-r

install.packages("mapdata")
install.packages("devtools")
install.packages("stringr")
install.packages("maps")
devtools::install_github("wmurphyrd/fiftystater")

library(ggplot2)
library(dplyr)
library(maps)
library(mapdata)
library(ggmap)
library(tidyverse)
library(fiftystater)
library(dplyr)
library(maps)
library(mapdata)
library(rgeos)
library(maptools)
library(rgdal)

#This data set is found in the fiftystater library
#I used this one to get alaska and hawaii

#Create test.states, change all lowercase ID t upper state
test.states <- fifty_states %>%
  mutate(state=toupper(id)) 

#read in data set with voting rights by state
#I created this from data from the Brennancenter.org
#Brennan Center for Justice

test.incidents <- read.csv("incidents_by_state.csv", header=TRUE)

#Create test.voting to capitalize state
test.incidents <- test.incidents  %>%
  mutate(state=toupper(state)) 

#full join data sets by state
joined_data <- full_join(test.states, test.incidents, by="state")

##test <- joined_data %>%
##mutate(col=ifelse(automatic.voter.registration=="yes", "blue", "red"))

##plot US state map, color states red=no and blue=yes 
##map 1: automatic voter registration
mapCOP <- ggplot(data=joined_data)+
  geom_polygon(aes(x=long, y=lat, fill=police_attack, group=group), 
               color="white")+
  coord_fixed(1.3)+
  guides(color=TRUE) + #turns off the color legend
  theme(axis.line=element_blank(),
        axis.text.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        legend.position="bottom",
        panel.background=element_blank(),
        panel.border=element_blank(),
        panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),
        plot.background=element_blank(), 
        plot.title = element_text(hjust = 0.5)) +
  ggtitle("Police Attacks on Press: Data collected by Scott Nover") +
  scale_fill_manual(values=alpha(c("gray","red"), 1), name="Police Attacks on Press") 

mapCOP


 
