# Taxonmic data bias and Spatial data bias in Taiwan Biodiversity Network
## 簡介
資料偏差（Data Bias）計算，參考[Troudet et al. 2017](https://doi.org/10.1038/s41598-017-09084-6)，將預期資料筆數（ideal sampling）與實際資料筆數相減。Data Bias可區分成Taxonomic Data Bias 以及 Spatial Data Bias。Taxonomic Data Bias是以物種比例為基準所算出的資料偏差。Spatial Data Bias是指以面積大小為基準所算出的資料偏差。

## Data
下載"input\data"資料夾
* 20210630 TTsplist.csv
* databias_taxon.csv
* databias_taxon_withyear.csv

## Source code
下載"script"資料夾
* data bias for taxon.r
* data bias for taxon with year.r

## Taxonomic Data Bias
>生物類群資料偏差計算公式：類群實際資料筆數-(總資料筆數*物種比例)

### 生物類群的資料偏差
根據TBN生物類群區分，計算各類群的資料偏差
* data prepare
    1. rbind TBN occurrence data & eBird data
    2. calculate the number of occurrence by taxonGroup
    3. filter `taxonRank` at `Species` and calculate the number of species in TTsplist
 
* files：databias_taxon.csv
* script：data bias for taxon.r

#### Result
    
![](https://i.imgur.com/LUYiE2A.png)


### 生物類群在年間的資料偏差
根據TBN生物類群區分，計算自有資料以來至今(1901-2020)，每20年間的資料偏差
* data prepare
    1. rbind TBN occurrence data & eBird data
    2. calculate the number of occurrence by taxonGroup
    3. filter `taxonRank` at `Species` and calculate the number of species in TTsplist
    4. prepare time table
    5. Split data with time table by column`year` 
 
* files：databias_taxon_withyear.csv
* script：data bias for taxon with year.r

#### Result
![](https://i.imgur.com/mMZV5n0.png)

## Spatial Data Bias
>空間資料偏差計算公式：行政區資料筆數-(總資料筆數*行政區面積比例)

### 縣市的資料偏差
以縣市作空間區分，計算個縣市的資料偏差

### 鄉鎮區的資料偏差
以鄉鎮區作空間區分，計算個縣市的資料偏差

## Raw data
* TBN data：
    * versoin：2021/04/27以前
    * 概述：排除「EOD - eBird Oberservation Data set」以及「Chinese Wild Bird Federation Bird Records Database」兩份資料集，詳情請見[TBN資料集頁面](https://www.tbn.org.tw/data/datasets)
    * 下載方式：[TBN_API](https://www.tbn.org.tw/data/api)
* eBird data：
    * versoin：2020/12/31以前
    * 概述：下載臺灣範圍資料
    * 下載方式：[GBIF](https://www.gbif.org/occurrence/search?advanced=1&dataset_key=4fa7b334-ce0d-4e88-aaae-2e0c138d049e&publishing_country=TW)
