#!/usr/bin/env Rscript

library(tidyverse)

#Lectura de datos
prcp_data <- read_tsv("data/ghcnd_tidy.tsv.gz")

#Lectura de metadatos
stations_data <- read_tsv("data/ghcnd_regions_years.tsv")

#Unión datos y metadatos

      #anti_join(prcp_data, stations_data, by = "id")
      #anti_join(stations_data, prcp_data, by = "id")

lat_long_prcp <- inner_join(prcp_data, stations_data, by = "id") %>%
  filter(year != first_year & year != last_year | year==2025) %>%
  group_by(latitude, longitude, year) %>%
  summarize(mean_prcp = mean(prcp)) %>%
  summarize(n = n())

lat_long_prcp %>% ggplot(aes(x=n)) + geom_histogram()
