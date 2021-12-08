## Connecting 
#install.packages('rsconnect')

##main code
library(rsconnect)
library(shiny)

#install.packages('rtweet')
#install.packages("twitteR")

library(tidyverse)
library(rvest)
library(tibble)
library(stringr)
library(jsonlite)
library(lubridate)
library(dplyr)

  ##look/find at sentators @'s
url <- "https://triagecancer.org/congressional-social-media"
thread <- read_html(url)
  
class(thread)
print(thread)
  
politicans.data <- thread %>% 
html_nodes(xpath = '//*[@id="footable_16836"]') %>% html_table()
  
  
politicans.data <- politicans.data[[1]] 
  ##maybe I'll do more with this !
  
##class(politicans.data[2])
  
colnames(politicans.data) <- c("state", "member", "name", "wesbite", "party", "twitterHandle", 
                                 "twitterLink", "instagram", "instagramLink", "facebook", "facebookLink")
  
  
senators.data <- politicans.data %>% subset(member == "U.S. Senator") %>% select(state, member, name, party,
                                                                                   twitterHandle)
senators.data$twitterHandle <- gsub("@", "", as.character(senators.data$twitterHandle))

write.csv(senators.data, file = "senators.csv")
  