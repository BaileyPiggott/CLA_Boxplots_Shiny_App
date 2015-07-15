
# user interface definition
# CLA data boxplots

library(shiny)

shinyUI(fluidPage(
  
  
  headerPanel("CLA Scores"), 
  
  sidebarPanel(
    selectInput("discipline", "Discipline:",
                c("Totals" = 1,
                  "Psychology" = 2,
                  "Drama" = 3,
                  "Engineering" = 4,
                  "Physics" = 5,
                  selected = 1 # default to total
                )#end options
    )#end selectInput
        
  ),#end sidebar panel
  
  mainPanel(
    plotOutput("claPlot")
  )
  
))
