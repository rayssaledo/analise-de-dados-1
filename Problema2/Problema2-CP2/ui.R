#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Comparando a série que possui mais avaliações positivas com as demais"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput('series', "Escolha uma série para comparar com 'Sense8': ", 
                  choices = list(Choose='', 
                                 "13 Reasons Why" = "13 Reasons Why",
                                 "Black Mirror" = "Black Mirror",
                                 "How to Get Away with Murder" = "How to Get Away with Murder",
                                 "Mr Robot" = "Mr Robot",
                                 "Sherlock" = "Sherlock",
                                 "Breaking Bad"="Breaking Bad",
                                 "Dexter"="Dexter",
                                 "House of Cards"="House of Cards",
                                 "Stranger Things"="Stranger Things"), 
                  selected = 1)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      # plotlyOutput("distPlot")
      fluidRow(
        column(12,plotlyOutput("distPlot"))
      ),
      fluidRow(
        column(12,plotlyOutput("distPlot2"))
      )
    )
  )
))