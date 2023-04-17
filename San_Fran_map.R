library(osmdata)
library(tidyverse)
library(ggplot2)
library(sf)

streets <- getbb('San Francisco, California') %>%
  opq() %>%
  add_osm_feature(key = 'highway',
                  value = c('motorway', 'primary',
                            'secondary', 'tertiary')) %>%
  osmdata_sf()

small_streets <- getbb('San Francisco, California') %>%
  opq() %>%
  add_osm_feature(key = 'highway',
                  value = c('residential', 'living_street',
                            'service', 'footway')) %>%
  osmdata_sf()

rivers <- getbb('San Francisco, California') %>%
  opq() %>%
  add_osm_feature(key = 'natural',
                  value = c('water')) %>%
  osmdata_sf()

ggplot() +
  geom_sf(data = streets$osm_lines,
          inherit.aes = FALSE,
          color = '#58b9c7',
          size = .5,
          alpha = .6) +
  geom_sf(data = small_streets$osm_lines,
          inherit.aes = FALSE,
          color = '#239dc1',
          size = .2,
          alpha = .6) +
  geom_sf(data = rivers$osm_polygons,
          inherit.aes = FALSE,
          fill = '#f8cc0a',
          size = .2) +
  coord_sf(ylim = c(37.71, 37.81),
           xlim = c(-122.53, -122.35),
           expand = FALSE) +
  theme(
    plot.background = element_blank(),
    panel.background = element_rect(color = '#08435f', 
                                    fill = '#08435f',
                                    size = 20),
    panel.grid = element_blank(),
    axis.ticks = element_blank(),
    axis.text  = element_blank(),
  )
ggplot() +
  geom_sf(data = streets$osm_lines,
          inherit.aes = FALSE,
          color = '#58b9c7',
          size = .5,
          alpha = .6) +
  geom_sf(data = small_streets$osm_lines,
          inherit.aes = FALSE,
          color = '#239dc1',
          size = .2,
          alpha = .6) +
  geom_sf(data = rivers$osm_polygons,
          inherit.aes = FALSE,
          fill = '#f8cc0a',
          size = .2) +
  # ADD THIS CODE
  coord_sf(ylim = c(52.35, 52.40),
           xlim = c(4.83, 4.97),
           expand = FALSE)

ggplot() +
  geom_sf(data = streets$osm_lines,
          inherit.aes = FALSE,
          color = '#58b9c7',
          size = .5,
          alpha = .6) +
  geom_sf(data = small_streets$osm_lines,
          inherit.aes = FALSE,
          color = '#239dc1',
          size = .2,
          alpha = .6) +
  geom_sf(data = rivers$osm_polygons,
          inherit.aes = FALSE,
          fill = '#f8cc0a',
          size = .2) +
  coord_sf(ylim = c(52.35, 52.40),
           xlim = c(4.83, 4.97),
           expand = FALSE)
# ADD THIS CODE
theme(
  plot.background = element_blank(),
  panel.background = element_rect(color = '#08435f', 
                                  fill = '#08435f',
                                  size = 20),
  panel.grid = element_blank(),
  axis.ticks = element_blank(),
  axis.text  = element_blank(),
)
