
# Prepare Library ---------------------------------------------------------

library(shiny)
library(shinydashboard)
library(tidyverse)
library(ggplot2)
library(plotly)
library(ggrepel)
library(lubridate)
library(leaflet)

# Prepare Data ------------------------------------------------------------

hostel <- read_csv("Hostel_data.csv")
hostel$rating.band <- as.factor(hostel$rating.band)
hostel$City <- as.factor(hostel$City)

# prepare label input -----------------------------------------------------

selectcity <- unique(hostel$City)

selectrating <- levels(hostel$rating.band)

selectscore <- colnames(hostel[,c(8:13)])
