library(tidyverse)
library(raster)
library(here)
library(sf)
library(ggplot2)
library(data.table)
town <- st_read(here("input", "polygon", "databias_spatial_town.shp"))%>%
  as(., "sf")%>%
  st_set_crs(4326)

for(j in 1:nrow(town)){
  town$data_gap_value[j] <-town$point_count[j]-(sum(town$point_count)/sum(town$Area_sqkm))*town$Area_sqkm[j]
} 

town$occ_type <- ifelse(town$data_gap_value < 0, "below", "above")




ggplot(data = town) +
  geom_sf() +
  geom_sf(data = town, aes(fill = data_gap_value)) +
  coord_sf(xlim = c(116, 123), ylim = c(20, 27), expand = FALSE)

town_data <- fread(here("data gap of Town", "data_gap_table_outline.csv"), 
                   sep = ",",fill=TRUE, colClasses="character")

ggplot(town_data, aes(reorder(TOWNNAM, dt_gp_v), y=dt_gp_v))+ 
  geom_bar(stat='identity', aes(fill=occ_typ), width=0.5)+
  scale_fill_manual(values = c("above"="steelblue4", "below"="red"))+
  labs(subtitle="occurrence bias", title= "town data gap", 
       caption="Produced by Juny-Wu", x="town", y="Number of occurrences")+
  coord_flip()