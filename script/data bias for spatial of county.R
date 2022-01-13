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


county <- st_read(here("input", "polygon", "databias_spatial_county.shp"))%>%
  as(., "sf")%>%
  st_set_crs(4326)

for(j in 1:nrow(county)){
  county$data_gap_value[j] <-county$pnt_cnt[j]-(sum(county$pnt_cnt)/sum(county$Ar_sqkm))*county$Ar_sqkm[j]
} 





mainland=tm_shape(county, bbox = c(xmin = 119.2, ymin = 21.8, xmax = 122.3, ymax = 25.4),)+
  tm_fill("data_gap_value", title="資料偏差筆數",breaks=c(min(county$data_gap_value,na.rm=TRUE),-600000,-300000,-100000,0,100000,300000,600000, max(county$data_gap_value,na.rm=TRUE)),
          labels = c("少於600,000","少於300,000-600,000","少於100,000-300,000","少於0-100,000","大於0-100,000","大於100,000-300,000","大於300,000-600,000", "大於600,000"),
          palette = c("#D62F27", "#F08159","#FCD39A","#FFF8DC", "#AFEEEE","#00CED1","#5F9EA0","#4682B4"))+tm_borders("#000000", lwd = 0.5)+
  tm_layout(main.title = "TBN data bias for spatial of county, EPSG:4326",main.title.position = "left", main.title.size = 1, legend.outside = TRUE, frame = FALSE, 
            attr.outside=TRUE)+
  tm_shape(county %>% filter(data_gap_value < -200000)) + 
  tm_text("COUNTYN", size = 0.8)
mainland

matsu=tm_shape(county, bbox = c(xmin = 119.85, ymin = 25.9, xmax = 120.55, ymax = 26.45))+
               tm_fill("data_gap_value",breaks=c(min(county$data_gap_value,na.rm=TRUE),-600000,-300000,-100000,0,100000,300000,600000, max(county$data_gap_value,na.rm=TRUE)),
                       labels = c("少於600,000","少於300,000-600,000","少於100,000-300,000","少於0-100,000","大於0-100,000","大於100,000-300,000","大於300,000-600,000", "大於600,000"), 
                       palette = c("#D62F27", "#F08159","#FCD39A","#FFF8DC", "#AFEEEE","#00CED1","#5F9EA0","#4682B4"))+
  tm_borders("#000000", lwd = 0.5)+
  tm_layout(legend.show=FALSE)

kinmen=tm_shape(county, bbox = c(xmin = 118.12, ymin = 24.14, xmax = 118.52, ymax = 24.54))+
  tm_fill("data_gap_value",breaks=c(min(county$data_gap_value,na.rm=TRUE),-600000,-300000,-100000,0,100000,300000,600000, max(county$data_gap_value,na.rm=TRUE)),
          labels = c("少於600,000","少於300,000-600,000","少於100,000-300,000","少於0-100,000","大於0-100,000","大於100,000-300,000","大於300,000-600,000", "大於600,000"), 
          palette = c("#D62F27", "#F08159","#FCD39A","#FFF8DC", "#AFEEEE","#00CED1","#5F9EA0","#4682B4"))+
  tm_borders("#000000", lwd = 0.5)+
  tm_layout(legend.show=FALSE)



print(matsu, vp = viewport(0.315, 0.84, width = 0.125, height = 0.125))
print(kinmen, vp = viewport(0.22, 0.84, width = 0.125, height = 0.125))
