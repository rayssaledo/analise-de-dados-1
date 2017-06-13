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
library(plotly)


dados = read_csv("../../dados/series_from_imdb.csv")


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$distPlot <- renderPlotly({
    
    dados <- dados %>% filter(series_name == "Sense8")
    
    plot = dados %>%  
            ggplot(aes(x = series_ep, y = UserRating)) +
            geom_line() +
            geom_point(aes(text = paste("Episódio:", series_ep, "<br>", "Avaliação:", UserRating)),
                       color = "purple") +
            labs(title = "Avaliação dos usuários por episódio da série 'Sense8'", x = "Episódios", y = "Avaliações dos usuários")

          ggplotly(plot, tooltip = "text")
  })
  
  output$distPlot2 <- renderPlotly({
    dados <- dados %>% filter(series_name %in% input$series)
  
    if(input$series != '') {
      p = dados %>%
        ggplot(aes(x = series_ep, y = UserRating)) +
        geom_line() +
        geom_point(aes(text = paste("Episódio:", series_ep, "<br>", "Classificação:", UserRating)),
                   color = "orange",
                   size = 2) +
        scale_x_continuous(breaks=seq(1, 25, 5))+
        facet_wrap(~series_name, scales = "free_x") +
        labs(title = "Avaliação dos usuários por episódio da série: ", x = "Episódios", y = "Avaliações dos usuários") %>% return()
        
      ggplotly(p, tooltip = "text")
    } else if (input$series == '') {
      dados %>%
        ggplot(aes(x = UserRating)) + 
        geom_histogram(binwidth = .5, fill = "orange", color = "black") + 
        geom_rug() +
        labs(title = "Avaliação dos usuários por episódio da série: ", x = "Episódios", y = "Avaliações dos usuários") %>% return()
    }
  
  })
  
  output$distPlot3 <- renderPlotly({
  dados %>%   
    ggplot(aes(x = as.character(season), y = UserRating)) + 
    geom_boxplot(outlier.color = NA) +   
    geom_jitter(width = .1, size = .5, alpha = .5, color = "red")+
    labs(title = "Box-plot da classificacao do usuario por temporada da serie", x="Temporada", y="Classificacao do usuario")
  })
  
})


