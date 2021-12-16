library(dplyr)
library(tidytext)
library(lubridate)
library(date)

states <- read.csv("COVID19_CDC_Vaccination.csv")

stateV<- states %>% select(DATE,GEOGRAPHY_NAME, PARTIALLY_OF_FULLY_VACCINATED_PERCENT, FULLY_VACCINATED_PERCENT, POPULATION)

stateV <- stateV %>% subset(DATE == '2021-12-02' & GEOGRAPHY_NAME != "United States"
                            & GEOGRAPHY_NAME != "American Samoa" & GEOGRAPHY_NAME != "Guam" 
                            & GEOGRAPHY_NAME != "Puerto Rico" & GEOGRAPHY_NAME != "Northern Mariana Islands" 
                            & GEOGRAPHY_NAME != "Virgin Islands" & GEOGRAPHY_NAME != "Indian Health Svc" 
                            & GEOGRAPHY_NAME != "Federated States of Micronesia" & GEOGRAPHY_NAME != "Marshall Islands" 
                            & GEOGRAPHY_NAME != "Dept of Defense" & GEOGRAPHY_NAME != "Bureau of Prisons"
                            & GEOGRAPHY_NAME != "Veterans Health" & GEOGRAPHY_NAME != "Republic of Palau" 
                            & GEOGRAPHY_NAME != "Veterans Health" & GEOGRAPHY_NAME != "District of Columbia")
          
          
write.csv(stateV, file = "statesVaccination.csv")

                            