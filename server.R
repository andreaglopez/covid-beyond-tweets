
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


sentators.data <- politicans.data %>% subset(member == "U.S. Senator") %>% select(state, member, name, party,
                                                                                  twitterHandle)

class(sentators.data)


##load tweets
creds <- read_json("twitterCreds.json")

Sys.setenv(BEARER_TOKEN = creds$bearer)
Sys.setenv( access_token= creds$id)
Sys.setenv(access_secret = creds$secret)


##tweets
tweets <- vector()
for(i in 1:sentators.data$twitterHandle){
  tweets <- searchTwitter('COVID', 'COVID19', 'COIVD-19', 'virus', 'vaccines', 'vaccine',
                since = '2020-01-01', until = '2021-01-01', include_rts = false,) 
  #collecting for only a year
   
}

}
