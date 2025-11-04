#!/usr/bin/env Rscript


library(tidyverse)
library(lubridate)
library(glue)

#Lectura de datos
prcp_data <- read_tsv("data/ghcnd_tidy.tsv.gz")

#Lectura de metadatos
stations_data <- read_tsv("data/ghcnd_regions_years.tsv")

#Unión datos y metadatos

      #anti_join(prcp_data, stations_data, by = "id")
      #anti_join(stations_data, prcp_data, by = "id")

lat_long_prcp <- inner_join(prcp_data, stations_data, by = "id") %>%
  filter(year != first_year & year != last_year | year == 2025) %>%
  group_by(latitude, longitude, year) %>%
  summarize(mean_prcp = mean(prcp), .groups = "drop")

end <- format(today(), "%d %B %Y")

start <- format(today() - 30, "%d %B")

lat_long_prcp %>%
  group_by(latitude, longitude) %>%
  mutate(z_score = (mean_prcp - mean(mean_prcp))/sd(mean_prcp),
            n=n()) %>%
  ungroup() %>%
  filter(n >= 50 & year == 2025) %>%
  select(-n, -mean_prcp, -year) %>%
  mutate(z_score = if_else(z_score > 2, 2, z_score),
         z_score = if_else(z_score < -2, -2, z_score))%>%
  ggplot(aes(x = longitude, y= latitude, fill= z_score)) +
  geom_tile() +
  coord_fixed() +
  scale_fill_gradient2(name = NULL,
                       low = "red", mid = "#f5f5f5", high = "darkblue",
                       midpoint = 0,
                       breaks = c(-2, -1, 0, 1, 2),
                       labels = c("<-2", "-1", "0", "1", ">2")) +
  labs(title = glue("Amount of precipitation for {start} to {end}"),
       subtitle = "Standardized Z-score for at least the past 50 years",
       caption = "Precipitation data collected from GHCND daily data at NOAA") +
  theme(panel.background = element_rect(fill = "black"),
        plot.background = element_rect(fill = "black", color = "black"),
        panel.grid = element_blank(),
        legend.background = element_blank(),
        legend.text = element_text(color="white"),
        legend.position = c(0.2, 0.05),
        legend.direction = "horizontal", 
        legend.key.height = unit(0.25, "cm"),
        axis.text = element_blank(),
        plot.title = element_text(color = "white", hjust = 0.5, size = 16),
        plot.subtitle = element_text(color = "white"),
        plot.caption = element_text(color = "white"))
  
ggsave("visual/world_drought.png", width = 8, height = 4)

