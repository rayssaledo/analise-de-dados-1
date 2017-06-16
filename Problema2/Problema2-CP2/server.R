#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(tidyr)
library(ggplot2)
library(readr)
library(plotly)


dados = read_csv("series_from_imdb.csv")


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # dados <- dados %>% select(series_name) %>%  distinct()
  series_r10 <- dados %>% 
    group_by(nome_serie = series_name) %>% 
    summarise(mediana = median(r10), media = mean(r10))
  
  maior_mediana_r10 <- max(series_r10[,2])
  maior_media_r10 <- max(series_r10[,3])
  
  dados_table <- series_r10 %>% 
    arrange(-mediana)
  
  # Show the first "n" observations
  output$view <- renderTable({
    head(dados_table, n = input$obs)
  })
  
  
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
  
  output$table <- renderTable({
    series_media_alta <- dados %>% 
      group_by(nome_serie = series_name) %>% 
      summarise(mediana = median(UserRating), media = mean(UserRating)) %>% 
      filter(media > 9 | mediana >= 9)
    
    dados_table <- series_media_alta %>% 
      arrange(media)
    
    head(dados_table)
  })
  
})


