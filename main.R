
## Connecting 
#install.packages('rsconnect')

##main code
library(rsconnect)
library(shiny)

#install.packages('rtweet')
library(rtweet)
library(rvest)
library(tidyverse)
library(stringr)




##look/find at sentators @'s
url <- "https://triagecancer.org/congressional-social-media"
thread <- read_html(url)

class(thread)
print(thread)

politicans.data <- thread %>% html_nodes(".wpb_wrapper")
print(politicans.data[1])

handles <- thread %>% html_nodes(".wpb_wrapper") %>% 
  html_text() %>% str_trim() 
handles[1]

print(length(handles))
print(substr(handles[1], 1, 250))

senators <- handles <- thread %>% html_nodes(".wpb_wrapper") %>%
  html_text() %>% str_trim()

##load tweets


##tweets
