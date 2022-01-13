library(tidyverse)
library(raster)
library(here)
library(sf)
library(ggplot2)
library(data.table)
library(tmap)
library(grid)
library(showtext)
font_add("openhuninn", regular=here("input", "text", "jf-openhuninn-1.1.ttf"))
showtext_auto()

town <- st_read(here("input", "polygon", "databias_spatial_town.shp"))%>%
  as(., "sf")%>%
  st_set_crs(4326)

for(j in 1:nrow(town)){
  town$data_gap_value[j] <-town$pnt_cnt[j]-(sum(town$pnt_cnt)/sum(town$Ar_sqkm))*town$Ar_sqkm[j]
} 

town$occ_type <- ifelse(town$data_gap_value < 0, "below", "above")




mainland=tm_shape(town, bbox = c(xmin = 119.2, ymin = 21.8, xmax = 122.3, ymax = 25.4),)+
  tm_fill("data_gap_value", title="資料偏差筆數",breaks=c(min(town$data_gap_value,na.rm=TRUE),-100000,-10000,-1000,0,1000,10000,100000, max(town$data_gap_value,na.rm=TRUE)),
          labels = c("少於100,000","少於10,000-100,000","少於1,000-10,000","少於0-1,000","大於0-1,000","大於1,000-10,000","大於10,000-100,000", "大於100,000"),
          palette = c("#D62F27", "#F08159","#FCD39A","#FFF8DC", "#AFEEEE","#00CED1","#5F9EA0","#4682B4"))+tm_borders("#000000", lwd = 0.5)+
  tm_layout(main.title = "TBN data bias for spatial of county, EPSG:4326",main.title.position = "left", main.title.size = 1, legend.outside = TRUE, frame = FALSE, 
            attr.outside=TRUE)+
  tm_shape(town %>% filter(data_gap_value < -100000)) + 
  tm_text("TOWNNAM", size = 0.8, shadow = TRUE)
mainland

matsu=tm_shape(town, bbox = c(xmin = 119.85, ymin = 25.9, xmax = 120.55, ymax = 26.45))+
  tm_fill("data_gap_value", title="資料偏差筆數",breaks=c(min(town$data_gap_value,na.rm=TRUE),-100000,-10000,-1000,0,1000,10000,100000, max(town$data_gap_value,na.rm=TRUE)),
          labels = c("少於100,000","少於10,000-100,000","少於1,000-10,000","少於0-1,000","大於0-1,000","大於1,000-10,000","大於10,000-100,000", "大於100,000"),
          palette = c("#D62F27", "#F08159","#FCD39A","#FFF8DC", "#AFEEEE","#00CED1","#5F9EA0","#4682B4"))+tm_borders("#000000", lwd = 0.5)+
  tm_layout(legend.show=FALSE)

kinmen=tm_shape(town, bbox = c(xmin = 118.12, ymin = 24.14, xmax = 118.52, ymax = 24.54))+
  tm_fill("data_gap_value", title="資料偏差筆數",breaks=c(min(town$data_gap_value,na.rm=TRUE),-100000,-10000,-1000,0,1000,10000,100000, max(town$data_gap_value,na.rm=TRUE)),
          labels = c("少於100,000","少於10,000-100,000","少於1,000-10,000","少於0-1,000","大於0-1,000","大於1,000-10,000","大於10,000-100,000", "大於100,000"),
          palette = c("#D62F27", "#F08159","#FCD39A","#FFF8DC", "#AFEEEE","#00CED1","#5F9EA0","#4682B4"))+tm_borders("#000000", lwd = 0.5)+
  tm_layout(legend.show=FALSE)



print(matsu, vp = viewport(0.315, 0.84, width = 0.125, height = 0.125))
print(kinmen, vp = viewport(0.22, 0.84, width = 0.125, height = 0.125))
