library(dplyr)
library(stringr)
library(ggplot2)
library(shiny)
library(plotly)

source("project.R")

inflation_df <- read.csv("income_inflation.csv")


# user interface pages
intro_view <- fluidPage(
# this is where I will add the overview, background info, context, sources, and "additional flare" (images and links)
  
  
)

analysis_view <- fluidPage(
#This is where the 3 interactive datasets should go
  
  
)

ui <- navbarPage( #this creates the tabs at top and the title in corner
  
  "The Growing Wealth Gap",
  tabPanel("Introduction", intro_view),
  tabPanel("Analysis", analysis_view)
  
  
)


# server interface
server <- function(input, output) {
  
  
  
  
  
  
}

# Running application
shinyApp(ui = ui, server = server)