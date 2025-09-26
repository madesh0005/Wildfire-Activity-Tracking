# ===============================
# Wildfire Analysis: Sample CSV
# ===============================

# Load required libraries
library(tidyverse)
library(lubridate)
library(ggplot2)
library(viridis)
library(sf)
library(maps)

# -------------------------------
# 1. Load CSV dataset
# -------------------------------
fires <- read_csv("wildfires_sample_200.csv")

# Preview
glimpse(fires)

# -------------------------------
# 2. Basic cleaning & preparation
# -------------------------------
fires <- fires %>%
  mutate(
    year = FIRE_YEAR
  ) %>%
  filter(!is.na(LATITUDE), !is.na(LONGITUDE), !is.na(FIRE_SIZE))

# -------------------------------
# 3. Filter large fires (≥1000 acres)
# -------------------------------
fires_large <- fires %>%
  filter(FIRE_SIZE >= 1000)

# -------------------------------
# 4. Trend of acres burned per year
# -------------------------------
year_trend <- fires_large %>%
  group_by(year) %>%
  summarise(
    total_burned = sum(FIRE_SIZE, na.rm = TRUE),
    count = n()
  ) %>%
  arrange(year)

# Plot trend
ggplot(year_trend, aes(x = year, y = total_burned)) +
  geom_line(color = "red") +
  geom_point() +
  labs(title = "Total Acres Burned per Year (≥ 1000 acres)",
       x = "Year", y = "Total Burned Acres") +
  theme_minimal()

# -------------------------------
# 5. Wildfire causes distribution
# -------------------------------
cause_counts <- fires_large %>%
  count(STAT_CAUSE_DESCR, sort = TRUE) %>%
  filter(!is.na(STAT_CAUSE_DESCR))

ggplot(cause_counts, aes(x = reorder(STAT_CAUSE_DESCR, n), y = n, fill = STAT_CAUSE_DESCR)) +
  geom_col() +
  coord_flip() +
  labs(title = "Number of Wildfires by Cause",
       x = "Cause", y = "Count") +
  theme_minimal() +
  theme(legend.position = "none")

# -------------------------------
# 6. Spatial map of wildfires in California
# -------------------------------
# Get CA state boundaries using maps + sf
ca_map <- st_as_sf(map("state", plot = FALSE, fill = TRUE))
ca_map <- ca_map %>% filter(ID == "california")

fires_ca <- fires_large %>%
  filter(STATE == "CA")  # filter California fires

# Convert fires to sf points
fires_ca_sf <- st_as_sf(fires_ca, coords = c("LONGITUDE", "LATITUDE"), crs = 4326)

# Plot
ggplot() +
  geom_sf(data = ca_map, fill = "gray95", color = "black") +
  geom_sf(data = fires_ca_sf, aes(size = FIRE_SIZE, color = STAT_CAUSE_DESCR), alpha = 0.6) +
  scale_size_continuous(range = c(1, 6), name = "Acres") +
  scale_color_viridis(discrete = TRUE, name = "Cause") +
  labs(title = "California Wildfire Locations (Large Fires)") +
  theme_minimal()

# -------------------------------
# 7. Save summaries
# -------------------------------
write_csv(year_trend, "year_trend_summary.csv")
write_csv(cause_counts, "cause_counts.csv")
