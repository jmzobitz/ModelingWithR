# Sample code to process WHO ebola data
# https://github.com/jhmatthes/BISC204_BioModeling/tree/main/Lab3_EbolaOutbreak

library(lubridate)
library(tidyverse)
ebola <- read_csv("data/ebola.csv") %>%
  mutate(date = mdy(`WHO report date`), `WHO report date` = NULL) %>%
  select(-c(2,4,6)) %>%
  gather(key=nation, value=cases,
         1:3) %>%
  mutate(monitor_days = as.numeric(date) - min(as.numeric(date)) + 1) %>% na.omit()


  
  
  
  SL_logistic <- nls(cases ~
                       (K*N0) / (N0 + (K - N0)*exp(-r*monitor_days)),
                     start = list(N0 = 10, r = 0.02, K = 14000),
                     data = filter(ebola, nation=="Cases Sierra Leone"),
                     trace=TRUE)
summary(SL_logistic)


SL_saturating <- nls(cases ~
                     K-(K - N0)*exp(-r*monitor_days),
                   start = list(N0 = 2000, r = 0.02, K = 140),
                   data = filter(ebola, nation=="Cases Sierra Leone"),
                   trace=TRUE)
summary(SL_saturating)



L_logistic <- nls(cases ~
                     (K*N0) / (N0 + (K - N0)*exp(-r*monitor_days)),
                   start = list(N0 = 10, r = 0.02, K = 14000),
                   data = filter(ebola, nation=="Cases Liberia"),
                   trace=TRUE)
summary(L_logistic)
