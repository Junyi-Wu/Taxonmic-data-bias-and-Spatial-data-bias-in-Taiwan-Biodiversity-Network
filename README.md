# Taxonomic data bias and Spatial data bias in Taiwan Biodiversity Network
## 簡介
資料偏差（Data Bias）計算，參考[Troudet et al. 2017](https://doi.org/10.1038/s41598-017-09084-6)，將預期資料筆數（ideal sampling）與實際資料筆數相減。Data Bias可區分成Taxonomic Data Bias 以及 Spatial Data Bias。Taxonomic Data Bias是以物種比例為基準所算出的資料偏差。Spatial Data Bias是指以面積大小為基準所算出的資料偏差。

## Data
下載"input\data"資料夾
* databias_taxon.csv
* databias_taxon_withyear.csv

## polygon
下載"input\polygon"資料夾
* databias_spatial_county.shp
* databias_spatial_town.shp

## Source code
下載"script"資料夾
* data bias for taxon.r
* data bias for taxon with year.r
* data bias for spatial of county.r
* data bias for spatial of town.r

## Taxonomic Data Bias
![](https://i.imgur.com/LLz66Tt.png)


### 生物類群資料偏差計算公式
類群實際資料筆數-(總資料筆數*物種比例)

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
![](https://i.imgur.com/6VrLda6.png)


### 空間資料偏差計算公式：
行政區資料筆數-(總資料筆數*行政區面積比例)

### 縣市的資料偏差
以縣市作空間區分，計算個縣市的資料偏差
* data prepare
    1. rbind TBN occurrence data & eBird data
    2. filter occurrence data by `decimalLongitude` & `decimalLatitude`
    3. transform occurrence to geodata and set crs to TWD97
    4. prepare county polygon and caluate area in km^2
    5. selet occurrence polygon to county polygon by location
 
* files：databias_spatial_county.shp
* script：data bias for spatial of county.r

#### Result
![](https://i.imgur.com/JypYC9t.png)


### 鄉鎮區的資料偏差
以鄉鎮區作空間區分，計算個縣市的資料偏差
* data prepare
    1. rbind TBN occurrence data & eBird data
    2. filter occurrence data by `decimalLongitude` & `decimalLatitude`
    3. transform occurrence to geodata and set crs to TWD97
    4. prepare town polygon and caluate area in km^2
    5. selet occurrence polygon to town polygon by location
 
* files：databias_spatial_town.shp
* script：data bias for spatial of town.r

#### Result
![](https://i.imgur.com/0KYAITy.png)


## Raw data
* TBN data：
    * versoin：2021/04/27以前
    * 概述：排除「EOD - eBird Oberservation Data set」以及「Chinese Wild Bird Federation Bird Records Database」兩份資料集，詳情請見[TBN資料集頁面](https://www.tbn.org.tw/data/datasets)
    * 下載方式：[TBN_API](https://www.tbn.org.tw/data/api)
* eBird data：
    * versoin：2020/12/31以前
    * 概述：下載臺灣範圍資料
    * 下載方式：[GBIF](https://www.gbif.org/occurrence/search?advanced=1&dataset_key=4fa7b334-ce0d-4e88-aaae-2e0c138d049e&publishing_country=TW)
* TBN Taxa Tree：
    * version：2021/06/30以前
    * 概述：TBN taxonbased 物種名錄系統
    * 下載方式：[TaxaTree（需來信申請帳號）](https://taxatree.tbn.org.tw/)
* Taiwan county polygon：
    * versoin：1
    * 概述：政府資料開放授權條款-第1版
    * 下載方式：[政府資料開放平臺-直轄市、縣市界線(TWD97經緯度)](https://data.gov.tw/dataset/7442)
* Taiwan town polygon：
    * versoin：1
    * 概述：政府資料開放授權條款-第1版
    * 下載方式：[政府資料開放平臺-鄉鎮市區界線(TWD97經緯度)](https://data.gov.tw/dataset/7441)

## References
Troudet, J., Grandcolas, P., Blin, A. et al. Taxonomic bias in biodiversity data and societal preferences. Sci Rep 7, 9132 (2017). https://doi.org/10.1038/s41598-017-09084-6
