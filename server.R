
## Connecting 
#install.packages('rsconnect')

##main code
library(rsconnect)
library(shiny)

#install.packages('rtweet')
#install.packages("twitteR")
library(twitteR)
library(rtweet)
library(rvest)
library(tidyverse)
library(tibble)
library(stringr)
library(jsonlite)
library(lubridate)
library(dplyr)

server <- function(input, output, session){
##look/find at sentators @'s
url <- "https://triagecancer.org/congressional-social-media"
thread <- read_html(url)

class(thread)
print(thread)

politicans.data <- thread %>% 
  html_nodes(xpath = '//*[@id="footable_16836"]') %>% html_table()


politicans.data <- politicans.data[[1]] 
##maybe I'll do more with this !

class(politicans.data[2])

colnames(politicans.data) <- c("state", "member", "name", "wesbite", "party", "twitterHandle", 
                               "twitterLink", "instagram", "instagramLink", "facebook", "facebookLink")


senators.data <- politicans.data %>% subset(member == "U.S. Senator") %>% select(state, member, name, party,
                                                                                  twitterHandle)
senators.data$twitterHandle <- gsub("@", "", as.character(senators.data$twitterHandle))

output$senators <- renderUI({
  selectInput("Choosing variables",
              label = "Choose a U.S Senator from the list",
              selected = senators.data$name,
              choices = senators.data$name)
  })
#class(sentators.data)


##load tweets
creds <- read_json("twitterCreds.json")

Sys.setenv(BEARER_TOKEN = creds$bearer)
Sys.setenv( access_token= creds$id)
Sys.setenv(access_secret = creds$secret)


##tweets
# this is looking through a specific amount of tweets not through year, and
# lets assume this user is active, most tweets i'm looking for are not within the amount
# i set

# if Iuse the searchTwitter function, I run into the issue that it looking in general
# and not at a certain user


#tweets <- vector()
#for(i in 1:length(senators.data$twitterHandle)){
 #df <- get_timeline(i, n = 1000)
 #tweets <- rbind(tweets,df)
#}
#if I include the code above (72-76) the input list won't appear
  
  # <- searchTwitter('COVID', 'COVID19', 'COIVD-19', 'virus', 'vaccines', 'vaccine',
  #              since = '2020-01-01', until = '2021-01-01', include_rts = false,) 
  #collecting for only a year
   
#}

}
