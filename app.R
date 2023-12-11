library(dplyr)
library(stringr)
library(ggplot2)
library(shiny)
library(plotly)

source("project.R")

inflation_df <- read.csv("income_inflation.csv")

#
# user interface pages
intro_view <- fluidPage(
# this is where I will add the overview, background info, context, sources, and "additional flare" (images and links)
  titlePanel("Introduction"),
  mainPanel(
    HTML("<p>This Shiny app provides an analysis of...</p>"),
    HTML("<p>The analysis is based on data collected from...</p>"),
    HTML("<p>In ths context of...</p>"),
    HTML("<p>Data sources include...</p>"),
    # After some reserach I learned in shiny the 'tags' function is used to create HTML tags in R.
    # Here tags$div creates a division tage to help group and style content. We also used 'tags$img to
    #embed images using src for specficing the path to image, we use tags$a for anchoring a hyperlink to the url and the learn more should be clickable.
    tags$div(
      tags$img(src = "path/to/your/imag.png", width = 400),
      tags$a(href = "https://example.com", "learn more")
)

analysis_view <- fluidPage(
#This is where the 3 interactive datasets should go
  titlePanel("Wealth Gap Analysis"),
  sidebarLayout(
    sidebarPanel = selectInput(
        inputId = "graph_choice",
        label = "Select Dataset",
        # choices = list("Median income VS. CPP", "Median Income Affected by CPP", "Racial disparity in income"),
          choices = c("Median income VS. CPP", "Median Income Affected by CPP", "Racial disparity in income"),
        # htmlOutput(outputId = "data_group"),
        h5(outputId = "data_intro"),
      ),
    mainPanel(
      plotlyOutput(outputId = "data")
    )
),
titlePanel("What can we assume from this data?"),
br(),
htmlOutput(outputId = "data_assump")
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
    
    title <- switch(input$graph_choice,
                    "Median income VS. CPP" = "US Median Income Growth and Consumer Purchasing Power Decline",
                    "Median Income Affected by CPP" = "How Consumer Purchasing Power affects our income",
                    "Racial disparity in income" = "The Growing Gap: Racial Systematic Oppression Observed Through Income Trends"
    )
    titlePanel(title)
  })
 
  
  output$data <- renderPlotly({
    
    # assign p with the value of the function that puts out one of the 3 graphs depending on what the user selects from the dropdown
    p<- generate_selected_graph(input$graph_choice)
    
    p <- ggplotly(p, tooltip = "text")
    return(p)
    plot(p)
    
  })
  
  output$data_intro <- renderUI({
    
    # Create a for loop that displays the introduction of the data that has been selected. 
      intro_text <- switch(input$graph_choice,
                         "Median income VS. CPP" = "Intro for median income vs CPP", "Median Income Affected by CPP" = "Introduction for Median Income Affected by CPP",
                         "Racial disparity in income" = "Introduction for Racial disparity in income"
                         )
    HTML(intro_text)
  
  })
  
  output$data_assump <- renderUI({
    
    # create a for loop that displays the conclusion of the data that has been selected.
      intro_text <- switch(input$graph_choice,
                         "Median income VS. CPP" = "Conclisoon for median income vs CPP", "Median Income Affected by CPP" = "Conclusion for Median Income Affected by CPP",
                         "Racial disparity in income" = "Conclusion for Racial disparity in income"
                         )
    HTML(intro_text)
  
  })
  
  
  
}

# Running application
shinyApp(ui = ui, server = server)
