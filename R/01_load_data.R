#Load the data in 
library(nflreadr)
library(tidyverse)

pbp <- load_pbp(2024)

filtered_off_epa_pbp <- pbp %>%
  rename(team = posteam) %>%
  filter(play_type %in% c("run", "pass")) %>%
  group_by(team) %>% 
  summarize(off_epa = mean(epa, na.rm = TRUE))

filtered_def_epa_pbp <- pbp %>%
  rename(team = defteam) %>%
  filter(play_type %in% c("run", "pass")) %>%
  group_by(team) %>%
  summarize(def_epa = mean(epa, na.rm = TRUE))

combined_epa <- full_join(filtered_off_epa_pbp, filtered_def_epa_pbp, by = join_by(team))

ggplot(combined_epa, aes(x = off_epa, y = def_epa)) +
  geom_point() +
  scale_y_reverse()+
  labs(title = "2024 NFL Team Efficiency: Offense vs Defense EPA per Play", y="Defensive EPA", x="Offensive EPA")
ggsave("output/epa_quadrant_2024.png", width = 10, height = 8, dpi = 300)
