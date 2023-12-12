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
    HTML("<p>In this context of...</p>"),
    HTML("<p>Data sources include...</p>"),
    # After some reserach I learned in shiny the 'tags' function is used to create HTML tags in R.
    # Here tags$div creates a division tage to help group and style content. We also used 'tags$img to
    #embed images using src for specficing the path to image, we use tags$a for anchoring a hyperlink to the url and the learn more should be clickable.
#    tags$div(
#      tags$img(src = "path/to/your/imag.png", width = 400),
 #     tags$a(href = "https://example.com", "learn more")
) )

analysis_view <- fluidPage(
#This is where the 3 interactive datasets should go
  titlePanel("Wealth Gap Analysis"),
  sidebarLayout(
    sidebarPanel( 
      selectInput(
        inputId = "graph_choice",
        label = "Select Dataset",
        # choices = list("Median income VS. CPP", "Median Income Affected by CPP", "Racial disparity in income"),
          choices = c("Median income VS. CPP", "Median Income Affected by CPP", "Racial disparity in income"),
        # htmlOutput(outputId = "data_group"),
      ),
      checkboxInput("checkbox", label = "Apply Consumer Purchasing Power", value = FALSE),

      hr(),
      fluidRow(column(3, verbatimTextOutput("value"))),
      
      htmlOutput(outputId = "data_intro"),
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
 
  
  cpp_enabled <- reactive({
    input$checkbox
  })
  
  selected_graph <- reactive({
    generate_selected_graph(input$graph_choice, input$checkbox)
  })
  
   
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
    # p<- generate_selected_graph(input$graph_choice)
    
    p <- ggplotly(selected_graph(), tooltip = "text")
    return(p)
    plot(p)
    
  })
  
  output$data_intro <- renderUI({
    
    # Create a for loop that displays the introduction of the data that has been selected. 
      intro_text <- switch(input$graph_choice,
                           "Median income VS. CPP" = 
                             "In this graph, we can see how the median income for Americans has changed since the 1960's compared to
                         the purchasing power (CPP) that their money had. We used the Median income since the Mean income is much higher,
                         more reflective of the wealth gap than the generation of income over time. The Median income is in 
                         U.S. dollars while the Consumer Purchasing Power is a percentage of the value, scaled to show how it has
                         changed over time between 300% and 34%.", 
                           "Median Income Affected by CPP" = 
                             "In this graph, we can see the the median income of Americans again. This time, watch how the income
                         is changed when you apply Consumer Purchasing Power with the checkbox above. This will show the purchasing
                         power the money Americans are earning really has.",
                           "Racial disparity in income" = 
                             "This final graph shows the continued disparity between white workers and workers of color. 
                        We can use the same Consumer Purchase Power effect on this graph with the checkbox. This will apply the
                         purchasing power effect to the median income of both white people and people of color."
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
  
  # # checkbox for applying cpp
  # output$value <- renderPrint({ input$checkbox })
  
}

# Running application
shinyApp(ui = ui, server = server)
