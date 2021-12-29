library(data.table)
library(here)
library(tidyverse)
library(scales)
library(ggbreak)
library(ggplot2)
library(viridis)

#### calculate the ideal number, save vistable ####
vis_table <- fread(here("input", "data", "databias_taxon_withyear.csv"))

vis_table$n <- round((vis_table$number_of_occ-vis_table$ideal_number)/1000,4)
vis_table$occ_type <- ifelse(vis_table$n < 0, "below", "above")


#### bubble plot####


vis_table %>%
  arrange(desc(number_of_occ)) %>%
  ggplot(aes(x=year, y=類群名, size=abs(n), color=occ_type)) +
  geom_point(alpha=0.5, shape=21) +
  scale_color_manual(values=c("steelblue4","red"))+
  scale_size(range = c(3, 24), breaks=extended_breaks(5), name="Value") +  
  scale_fill_viridis(discrete=TRUE) +
  geom_point(alpha=0.5) +
  theme(axis.text.x = element_text(size = 15, angle = 20))+
  theme(axis.text.y = element_text(size = 18, angle = 00))


