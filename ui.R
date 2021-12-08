
## Connecting 
#install.packages('rsconnect')
#install.packages('evaluate')
#install.packages('markdown')

##the face

library(shiny)
library(shinydashboard)
library(dplyr)
library(rtweet)
library(rsconnect)
library(evaluate)
library(markdown)


ui <- dashboardPage(
  dashboardHeader(title = "Beyond The Tweets"),
  dashboardSidebar(sidebarMenu(
    menuItem("Main", tabName = "Main", icon = icon("r-project")),
    menuItem("ReadMe", tabName = "ReadMe", icon = icon("readme"))
    )
  ),
  
  dashboardBody(
  tabItems(
    tabItem(
      tabName = "Main",
  
      sidebarPanel(
        helpText("Using U.S Politicans' tweets"),
        uiOutput('senator'),
        
        sliderInput(
          "a",
          label = "Select value to view top common words",
          min = 1,
          max = 10,
          value = 5
          ),
        ),
      
      
    mainPanel(
      plotOutput("plot")
    )
     
     
    ),
    tabItem(tabName = "ReadMe", 
            includeMarkdown("README.md"))
    ),
  )
)
