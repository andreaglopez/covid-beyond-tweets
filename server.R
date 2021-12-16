
## Connecting 
#install.packages('rsconnect')

##main code
library(rsconnect)
library(shiny)
library(DT)

#install.packages('rtweet')
#install.packages("twitteR")

library(tidyverse)
library(ggplot2)
library(tibble)
library(stringr)
library(jsonlite)
library(lubridate)
library(dplyr)

server <- function(input, output, session){
##look/find at sentators @'s

senators <- read.csv("senators.csv")
output$senator <- renderUI({
  selectInput("variablex",
              label = "Choose a U.S Senator handle from the list",
              selected = senators$twitterHandle,
              choices = senators$twitterHandle)
  })

senTweets <- read.csv("person.year.count.csv")
  
  person <- reactive({
    req(input$variablex)
    df <- senTweets %>% 
      group_by(input$variablex, year) %>% 
      top_n(input$a, n) %>%
      ungroup() %>%
      arrange(word, -n) 
   
  return(df)
  })
  
  observe({
    df = input$df
  })

  output$plot <- renderPlot({
    person() %>%  mutate(word = reorder(word, n)) %>%
      ggplot(aes(word, n, fill = factor(year))) +
      geom_col(show.legend = FALSE) +
      facet_wrap(~ year, scales = "free") + scale_fill_viridis_d() +
      coord_flip() + labs(y="Word frequency", x="Terms", title = paste("Top words used in 2020 (March - December)"))
    
  })
  
  states <- read.csv("statesVaccination.csv")
  output$rates <- renderDataTable({
    states
  })


  
}

