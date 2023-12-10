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
  titlePanel("Wealth Gap Analysis"),
  sidebarLayout(
    sidebarPanel = 
      selectInput(
        inputId = "graph_choice",
        label = "Select Dataset",
        choices = list("Median income VS. CPP", "Median Income Affected by CPP", "Racial disparity in income"),
        htmlOutput(outputId = "data_group"),
        htmlOutput(outputId = "data_intro")
      ),
    mainPanel(
      plotlyOutput(outputId = "data")
    )
  ),
  
  titlePanel("What can we assume from this data?"),
  br(),
  htmlOutput(outputId = "data_assump"),
)
  


ui <- navbarPage( #this creates the tabs at top and the title in corner
  
  "The Growing Wealth Gap",
  tabPanel("Introduction", intro_view),
  tabPanel("Analysis", analysis_view)
)



# server interface
server <- function(input, output) {
  
  # need to write function in project.R to pull one of 3 graphs: med income line, CPP affected income, or racial income based on input 
  # from choices above. Need to make the three graphs in project.R as well.  
  
  output$data_group <- renderUI({
    
    # create a for loop that displays a more professional title depending on what is selected from the dropdown.
    
    # "US Median Income Growth and Consumer Purchasing Power Decline", "How Consumer Purchasing Power affects our income", 
    # "The Growing Gap: Racial Systematic Oppression Observed Through Income Trends"
  })
  
  output$data <- renderPlotly({
    
    # assign p with the value of the function that puts out one of the 3 graphs depending on what the user selects from the dropdown
    
    # p <- ggplotly(p, tooltip = "text")
    # return(p)
    # plot(p)
    
  })
  
  output$data_intro <- renderUI({
    
    # Create a for loop that displays the introduction of the data that has been selected. 
    
  })
  
  output$data_assump <- renderUI({
    
    # create a for loop that displays the conclusion of the data that has been selected.
    
  })
  
  
  
}

# Running application
shinyApp(ui = ui, server = server)