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

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Séries"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput('show_vars', 'Colunas:',
                         names(dados %>% select(series_name)), selected = names(dados %>% select(series_name)))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        id = 'dataset',
        tabPanel('series_name', DT::dataTableOutput('mytable1'))
        # tabPanel('mtcars', DT::dataTableOutput('mytable2')),
        # tabPanel('iris', DT::dataTableOutput('mytable3'))
      )
    )
  )
))