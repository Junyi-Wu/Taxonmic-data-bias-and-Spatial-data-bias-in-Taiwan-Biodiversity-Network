library(tidyverse)
library(raster)
library(here)
library(sf)
library(ggplot2)
library(data.table)

county <- st_read(here("input", "polygon", "databias_spatial_county.shp"))%>%
  as(., "sf")%>%
  st_set_crs(4326)

for(j in 1:nrow(county)){
  county$data_gap_value[j] <-county$pnt_cnt[j]-(sum(county$pnt_cnt)/sum(county$Ar_sqkm))*county$Ar_sqkm[j]
} 



ggplot(data = county) +
  geom_sf() +
  geom_sf(data = county, aes(fill = data_gap_value)) +
  coord_sf(xlim = c(116, 125), ylim = c(20, 27), expand = FALSE)


