# Sample code to process WHO ebola data

library(lubridate)
library(tidyverse)
ebola <- read_csv("data/ebola.csv") %>%
  mutate(date = mdy(`WHO report date`), `WHO report date` = NULL) %>%
  select(-c(1,3,5)) %>%
  gather(key=nation, value=deaths,
         1:3) %>%
  mutate(monitor_days = as.numeric(date) - min(as.numeric(date)) + 1)


  
  
  
  SL_logistic <- nls(deaths ~
                       (K*N0) / (N0 + (K - N0)*exp(-r*monitor_days)),
                     start = list(N0 = 10, r = 0.02, K = 14000),
                     data = filter(ebola, nation=="Deaths Sierra Leone"),
                     trace=TRUE)
summary(SL_logistic)


SL_saturating <- nls(deaths ~
                     K-(K - N0)*exp(-r*monitor_days),
                   start = list(N0 = 10, r = 0.02, K = 14000),
                   data = filter(ebola, nation=="Deaths Sierra Leone"),
                   trace=TRUE)
summary(SL_saturating)


L_logistic <- nls(deaths ~
                     (K*N0) / (N0 + (K - N0)*exp(-r*monitor_days)),
                   start = list(N0 = 10, r = 0.02, K = 14000),
                   data = filter(ebola, nation=="Deaths Liberia"),
                   trace=TRUE)
summary(L_logistic)
