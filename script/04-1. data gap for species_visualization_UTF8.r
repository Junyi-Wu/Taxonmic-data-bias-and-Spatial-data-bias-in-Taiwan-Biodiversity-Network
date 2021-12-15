library(data.table)
library(here)
library(tidyverse)
library(scales)
library(ggbreak)
library(ggplot2)


TBN_APIocc_all <- fread(here("input", "data", "TBN_APIocc20210427.csv"),
      sep = ",",fill=TRUE, encoding = "UTF-8", colClasses="character")


ebird <- fread(here("input", "data", "ebird_202012.csv"),
               sep = "\t", fill=TRUE, encoding = "UTF-8", colClasses="character", quote ="")

class_list <- fread(here("input", "data", "data gap of splist", "TBN_classlist.csv"), sep = ",",fill=TRUE) %>%
  unique()

#### subset TBN_API column ####

TBN_APIocc_sp <- as.data.table(cbind(TBN_APIocc_all$occurrenceUUID, 
                                     TBN_APIocc_all$scientificName, 
                                     TBN_APIocc_all$taxonUUID, 
                                     TBN_APIocc_all$taxonGroup)) %>% 
  `colnames<-`(c("occurrenceUUID", "scientificName", "taxonUUID", "taxonGroup"))



#### calculate the number of occurrence by taxonGroup ####

for(i in 1:nrow(class_list)){
  class_list $ occurrence_count[i] <- 
    TBN_APIocc_sp[taxonGroup %like% class_list[i,1]] %>%
    nrow()
  print(i)
}

class_list[11,1] <- "蝸牛與貝類"

TT_sp <- fread(here("input", "data", "20210630 TTsplist.csv"),
               sep = ",",fill=TRUE, encoding = "UTF-8")

TT_sp <- subset(TT_sp, taxonRank=="species")

TT_sp<- as.data.table(cbind(TT_sp[,1:2], 
                            TT_sp[,5], 
                            TT_sp[,55]))

for(i in 1:nrow(class_list)){
  class_list $ number_of_species[i] <- 
    TT_sp[taxonGroup %like% class_list[i,1]] %>%
    nrow()
}

class_list[1,3] <- class_list[1,3]+nrow(ebird) #加入ebird資料



#### calculate the ideal number ####


for(i in 1:nrow(class_list)){
  class_list $ ideal_number[i] <- (sum(class_list$occurrence_count)/sum(class_list$number_of_species))*class_list$number_of_species[i]
}

class_list$n <- (class_list$occurrence_count-class_list$ideal_number)/1000
class_list$occ_type <- ifelse(class_list$n < 0, "below", "above")

fwrite(class_list, here("process", "data gap of splist", "vis_table_datagap_class.csv"))


#### barplot ####
library(showtext)
font_add("openhuninn", regular=here("input", "plot", "jf-openhuninn-1.1.ttf"))
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
ggsave(here("output", "taxonomic data bias", "taxon", "Taxon_group_of_TBN.png"), 
       plot = result, width = 1500, height = 700, dpi = 300, scale = 1, limitsize = FALSE)
