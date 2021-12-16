
library(twitteR)
library(rtweet)
library(rvest)
library(tidyverse)
library(tibble)
library(stringr)
library(jsonlite)
library(lubridate)
library(dplyr)
library(tidytext)


##load tweets

creds <- read_json("twitterCreds.json")

bearer_token <- Sys.setenv(BEARER_TOKEN = creds$bearer)

create_token(
  app = "COVID-Beyond-Tweets", 
  consumer_key = creds$key, 
  consumer_secret = creds$secret,
  access_token = creds$accesstoken,
  access_secret = creds$accesstokensecret
  )


xsenators <- read.csv("senators.csv")

tweets <- vector()
for(i in 1:length(xsenators$twitterHandle)){
df <- get_timeline(xsenators$twitterHandle[i], n = 900)
tweets <- rbind(tweets,df)
}

tweets$year <- format(tweets$created_at, format = "%Y")
#range(tweets$year)

#write.csv(tweets, file = "tweets.csv")
tweets <- tweets %>%  mutate(text = gsub("#[A-Za-z0-9]+|@[A-Za-z0-9]", "", text)) %>%
  mutate(text = gsub("(http[^ ]*)|(www.[^ ]*)", "", text)) %>% mutate(text = gsub("[^\x01-\x7F]", "", text)) %>% #to remove emojis
  distinct(text, .keep_all =TRUE) 


#dataT <- tweets %>% group_by(screen_name) %>% summarize(count = sum(is_retweet == FALSE))
#median <- tweet %>% unite('monthyear', month, year, sep = '/') %>% group_by(screen_name, monthyear) %>%  summarize(m = mean(is_retweet== FALSE), .groups = 'drop')
tweets$month <- format(tweets$created_at, format = "%m") ## keeping track of month on my end
#class(tweets2020$month) -> it's character
tweets$month <- as.numeric(tweets$month)
#class(tweets$month)
tweets2020 <- subset(tweets, is_retweet == FALSE & year == 2020 & month >=3) ##keeping everything during and after march

#write.csv(tweets2020, file = "tweets2020.csv")

data(stop_words)

#wordcounts <- tweets2020 %>% unnest_tokens(word, text, strip_punct = TRUE) %>%
  #anti_join(stop_words) 

stop_words <- stop_words %>% filter(lexicon == "snowball")
new_stop <- data.frame(word = c("amp", "will", "bc", "ur", "etc", "rt", "btw", "covid-19", "19"), lexicon = "snowball") 
stop_words <- stop_words %>% bind_rows(new_stop)



person.year.count <- tweets2020 %>% unnest_tokens(word, text ) %>%
  anti_join(stop_words) %>%
  count(word, screen_name, year)


write.csv(person.year.count, file = "person.year.count.csv")


