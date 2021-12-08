
## Connecting 
#install.packages('rsconnect')

##main code
library(rsconnect)
library(shiny)

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
              #inputID = "senator",
              label = "Choose a U.S Senator from the list",
              selected = senators$name,
              choices = senators$name)
  })

  senTweets <- read.csv("person.year.count.csv")
  
  person <- reactive({
    #req(variablex)
    df <- senTweets %>% #filter(input$variablex %in% input$variablex) %>%
      group_by(input$variablex, year) %>% 
      top_n(input$a, n) %>%
      ungroup() %>%
      arrange(word, -n)
  })

  output$plot <- renderPlot({
    person () %>%  mutate(word = reorder(word, n))
      ggplot(data = person(), aes(word, n, fill = factor(year))) +
      geom_col(show.legend = FALSE) +
      facet_wrap(~ year, scales = "free") + scale_fill_viridis_d() +
      coord_flip() + labs(y="Word frequency", x="Term", title = paste("Top words used in 2020"))
    
  })
  
}

