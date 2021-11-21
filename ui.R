
## Connecting 
#install.packages('rsconnect')

##the face

library(shiny)
library(dplyr)
library(rtweet)
library(rsconnect)
library

ui <- fluidPage(
  titlePanel("Beyond The Tweets"),
  
  
  sidebarPanel(
      helpText("Using U.S Politicans' tweets to survey vaccine rate"),
      selectInput("Choosing variables",
                  label = "Choose a U.S Sentator from the list",
                  choices = c("some name", "other name")
      ),
      
      sliderInput("a",
                  label = "Select value to view top common words",
                  min = 1, max = 10, value = 5)
      ),
  
  
  mainPanel( "main panel"
    
  )
  
  
  
  
)



