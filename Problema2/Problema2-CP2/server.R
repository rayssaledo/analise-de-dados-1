#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library("dplyr")
library("tidyr")
library("ggplot2")
library("readr")


dados = read_csv("../../dados/series_from_imdb.csv")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  # choose columns to display
  series_name2 = dados %>% select(series_name) %>%  distinct()
  series_name2[sample(nrow(dados %>% select(series_name)), 31), ]
  output$mytable1 <- DT::renderDataTable({
    DT::datatable(series_name2[, input$show_vars, drop = FALSE])
  })
  
  # # sorted columns are colored now because CSS are attached to them
  # output$mytable2 <- DT::renderDataTable({
  #   DT::datatable(mtcars, options = list(orderClasses = TRUE))
  # })
  # 
  # # customize the length drop-down menu; display 5 rows per page by default
  # output$mytable3 <- DT::renderDataTable({
  #   DT::datatable(iris, options = list(lengthMenu = c(5, 30, 50), pageLength = 5))
  # })
  
})


