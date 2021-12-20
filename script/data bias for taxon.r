library(data.table)
library(here)
library(tidyverse)
library(scales)
library(ggbreak)
library(ggplot2)

#### calculate the ideal sampling ####

class_list <- fread(here("input", "data", "databias_taxon.csv.csv"))
for(i in 1:nrow(class_list)){
  class_list $ ideal_number[i] <- (sum(class_list$occurrence_count)/sum(class_list$number_of_species))*class_list$number_of_species[i]
}

class_list$n <- (class_list$occurrence_count-class_list$ideal_number)/1000
class_list$occ_type <- ifelse(class_list$n < 0, "below", "above")



#### barplot ####
library(showtext)
font_add("openhuninn", regular=here("input", "text", "jf-openhuninn-1.1.ttf"))
showtext_auto()

result <- ggplot(class_list, aes(reorder(類群名, n), y=n))+ 
  geom_bar(stat='identity', aes(fill=occ_type), width=0.5)+
  scale_fill_manual(values = c("above"="steelblue4", "below"="red"))+
  labs(subtitle="Taxon Group of TBN", title= "Taxonmic Data Bias", fill="Bias type",
       caption="Produced by Junyi-Wu", x="class", y="Number of occurrences")+
  coord_flip()+ 
  scale_y_break(c(200, 5000), scales=0.1)+xlab("class") + ylab("Data Bias(Number of occurrences)") + 
  theme(axis.text.x = element_text(size = 10, angle = 00, family="openhuninn"))+
  theme(axis.text.y = element_text(size = 12, angle = 00, family="openhuninn"))+
  scale_y_continuous(breaks = c(-2000, -1500,-1000,-500, 0, 100, 4000, 6000, 8000), 
                     label = c("-2,000,000","-1,500,000", "-1,000,000", "-500,000", "0", "100,000", "4,000,000", "6,000,000", "8,000,000"))
result
