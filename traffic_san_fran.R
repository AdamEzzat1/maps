# Required packages
library(tidyverse)
library(osmdata)
library(sf)

# Get the map of the desired location
bbox_sf <- getbb("San Francisco, California")

# Get road data
query_roads <- opq(bbox_sf) %>%
  add_osm_feature(key = "highway", value = c("motorway", "primary", "secondary", "tertiary"))

roads_data <- osmdata_sf(query_roads)

# Get land data
query_land <- opq(bbox_sf) %>%
  add_osm_feature(key = "natural", value = "coastline")

land_data <- osmdata_sf(query_land)

# Get parking data
query_parking <- opq(bbox_sf) %>%
  add_osm_feature(key = "amenity", value = "parking")

parking_data <- osmdata_sf(query_parking)

# Create a congestion factor based on the road type:
roads_data$osm_lines$congestion_factor <- case_when(
  roads_data$osm_lines$highway == "motorway" ~ 0.8,
  roads_data$osm_lines$highway == "primary" ~ 0.6,
  roads_data$osm_lines$highway == "secondary" ~ 0.4,
  roads_data$osm_lines$highway == "tertiary" ~ 0.2,
  TRUE ~ 0
)

# Plot the map with traffic congestion visualized using different colors and parking spaces:

ggplot() +
  geom_sf(data = land_data$osm_lines, color = "black", size = 0.5, alpha = 0.6) +
  geom_sf(data = roads_data$osm_lines,
          aes(color = congestion_factor, size = congestion_factor),
          alpha = 0.8) +
  geom_sf(data = parking_data$osm_polygons,
          inherit.aes = FALSE,
          fill = "#7b00e0",
          size = .2,
          alpha = .6) +
  scale_color_gradientn(colors = c("green", "yellow", "red")) +
  guides(color = guide_legend(title = "Congestion Factor"), size = guide_legend(title = "Congestion Factor")) +
  theme_minimal()

ggplot() +
  geom_sf(data = land_data$osm_lines,
          inherit.aes = FALSE,
          color = '#58b9c7',
          size = .5,
          alpha = .6) +
  geom_sf(data = roads_data$osm_lines,
          inherit.aes = FALSE,
          aes(color = congestion_factor, size = congestion_factor),
          alpha = .6) +
  geom_sf(data = parking_data$osm_polygons,
          inherit.aes = FALSE,
          fill = "#7b00e0",
          size = .2,
          alpha = .6) +
  scale_color_gradientn(colors = c("green", "yellow", "red")) +
  coord_sf(ylim = c(37.71, 37.81),
           xlim = c(-122.53, -122.35),
           expand = FALSE) +
  theme(
    plot.background = element_blank(),
    panel.background = element_rect(color = '#08435f', 
                                    fill = '#08435f',
                                    linewidth = 20),
    panel.grid = element_blank(),
    axis.ticks = element_blank(),
    axis.text  = element_blank(),
  ) +
  guides(color = guide_legend(title = "Congestion Factor"), size = guide_legend(title = "Congestion Factor"))
