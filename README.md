# Wildfire Analysis Project

## Project Overview
This project analyzes wildfire occurrences in the United States using a sample dataset (`wildfires_sample_200.csv`). The analysis focuses on trends in wildfire size, causes, and spatial distribution, particularly in California.

## Dataset
The dataset includes the following columns:

- `FIRE_NAME`: Name of the wildfire.
- `STATE`: State where the wildfire occurred.
- `FIRE_YEAR`: Year of the wildfire.
- `LATITUDE` / `LONGITUDE`: Geographic coordinates of the fire.
- `FIRE_SIZE`: Size of the fire in acres.
- `STAT_CAUSE_DESCR`: Description of the fire cause.

> **Note:** This dataset is a sample of 200 wildfire records for demonstration purposes.

## Libraries Used
- `tidyverse`: Data manipulation and visualization
- `lubridate`: Date handling
- `ggplot2`: Plotting
- `viridis`: Color scales for plots
- `sf`: Handling spatial data
- `maps`: Map data for US states

## Analysis Steps
1. **Load CSV Dataset:** Read the CSV file into R.
2. **Data Cleaning & Preparation:** Filter missing values and select relevant columns.
3. **Filter Large Fires:** Focus on fires with `FIRE_SIZE >= 1000` acres.
4. **Trend Analysis:** Summarize total burned acres per year and plot trends.
5. **Cause Distribution:** Count wildfires by cause and plot a bar chart.
6. **Spatial Mapping:** Visualize large wildfires in California on a map using `sf`.
7. **Save Results:** Export yearly trends and cause counts as CSV files.

## How to Run
1. Ensure the following files are in your working directory:
   - `wildfires_sample_200.csv`
   - `wildfire_analysis.R`
2. Install required R packages if not already installed:

#R
`install.packages(c("tidyverse", "lubridate", "ggplot2", "viridis", "sf", "maps"))`

##Author

MADESHWARAN M
