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
  br(),
  titlePanel("Séries"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      numericInput("obs", "Selecione a quantidade de séries que deseja visualizar na tabela ao lado: ", 10),
      # submitButton("Update View"),
      br(),
      br(),
      br(),
      br(),
    
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
                                 "Stranger Things"="Stranger Things",
                                 "Homeland"= "Homeland", 
                                 "Sherlock" = "Sherlock",
                                 "The 100" = "The 100",
                                 "Game of Thrones" = "Game of Thrones",
                                 "Daredevil" = "Daredevil",
                                 "Arrow" = "Arrow",
                                 "Flash" = "Flash",
                                 "Once Upon a Time" = "Once Upon a Time",
                                 "Prison Break" = "Prison Break",
                                 "Agents of S.H.I.E.L.D." = "Agents of S.H.I.E.L.D.",
                                 "Vikings" = "Vikings",
                                 "The Walking Dead" = "The Walking Dead",
                                 "Orphan Black" = "Orphan Black",
                                 "Grey’s Anatomy", "Grey’s Anatomy",
                                 "Scandal" = "Scandal",
                                 "Friends" = "Friends",
                                 "Gotham" = "Gotham",
                                 "Narcos" = "Narcos",
                                 "The Blacklist" = "The Blacklist",
                                 "How I Met Your Mother" = "How I Met Your Mother",
                                 "Modern Family" = "Modern Family"), 
                  selected = 1)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h2(
        strong("Será que..."),
        strong("a série que mais recebeu avaliações positivas é a série melhor avaliada no IMDB (Base de Dados de Filmes da Internet)??")
      ),
      br(),
      
      # p("Veja na tabela abaixo as séries do momento, com suas respectivas média e mediana (referentes a quantidade de avaliações positivas feitas pelos usuários). As séries que possuem os maiores valores tanto de média e mediana estão entre as primeiras, quanto maior esses valores quer dizer que a série recebeu mais avaliações positivas. Portanto você pode verificar que a série que recebeu mais avaliações positivas foi a chamada",
      #   em(strong('Sense8')),
      #   '!!'
      # ),
      p("Para responder essa pergunta é preciso saber da média e mediana referentes a quantidade de avaliações positivas feitas pelos usuários. Veja na tabela abaixo esses valores para cada série."),
      p("As séries que possuem os maiores valores tanto de média e mediana estão entre as primeiras, quanto maior esses valores quer dizer que a série recebeu mais avaliações positivas."),
      br(),
      
      h4(strong("Tabela de série com respectiva média e mediana")),
      tableOutput("view"),
      
      p("Caso queira verificar os valores das demais séries aumente o número de visualização de séries no primeiro campo ao lado."),
      
      
      hr(),
      strong(p("Mas será que a série que recebeu mais avaliações positivas é a série melhor avaliada?")),
      p("Isso pode ser respondido olhando as notas dadas pelos usuários para a série que recebeu mais avaliações positivas (Sense8). Se existir variação entre as notas, então essa variação pode influenciar na avaliação geral da série. O gráfico abaixo mostra as avaliações por episódio da série 'Sense8': "),
      fluidRow(
        column(12,plotlyOutput("distPlot"))
      ),
      
      p("Você pode comparar as avaliações dos usuários para a série Sense8 com as avaliações das demais séries, basta escolher no segundo campo ao lado qual deseja comparar."),
      
      fluidRow(
        column(12,plotlyOutput("distPlot2"))
      )
    )
  )
))