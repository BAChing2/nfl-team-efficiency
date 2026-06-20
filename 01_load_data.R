#Load the data in 
library(nflreadr)
library(tidyverse)

pbp <- load_pbp(2024)

filtered_off_epa_pbp <- pbp %>%
  filter(play_type %in% c("run", "pass")) %>%
  group_by(posteam) %>% 
  summarize(off_epa = mean(epa, na.rm = TRUE))

filtered_def_epa_pbp <- pbp %>%
  filter(play_type %in% c("run", "pass")) %>%
  group_by(defteam) %>%
  summarize(def_epa = mean(epa, na.rm = TRUE))
