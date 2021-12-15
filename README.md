# Taxonmic data bias and Spatial data bias in Taiwan Biodiversity Network
## 簡介
資料偏差（Data Bias）計算，參考[Troudet et al. 2017](https://doi.org/10.1038/s41598-017-09084-6)，將預期資料筆數（ideal sampling）與實際資料筆數相減。Data Bias可區分成Taxonomic Data Bias 以及 Spatial Data Bias。Taxonomic Data Bias是以物種比例為基準所算出的資料偏差。Spatial Data Bias是指以面積大小為基準所算出的資料偏差。
    
## Data input
* TBN data：
    * versoin：2021/04/27以前
    * 概述：排除「EOD - eBird Oberservation Data set」以及「Chinese Wild Bird Federation Bird Records Database」兩份資料集，詳情請見[TBN資料集頁面](https://www.tbn.org.tw/data/datasets)
    * 下載方式：[TBN_API](https://www.tbn.org.tw/data/api)
* eBird data：
    * versoin：2020/12/31以前
    * 概述：下載臺灣範圍資料
    * 下載方式：[GBIF](https://www.gbif.org/occurrence/search?advanced=1&dataset_key=4fa7b334-ce0d-4e88-aaae-2e0c138d049e&publishing_country=TW)

## Taxonomic Data Bias
>生物類群資料偏差計算公式：類群實際資料筆數-(總資料筆數*物種比例)
### 生物類群的資料偏差
根據TBN生物類群區分，計算各類群的資料偏差
![](https://i.imgur.com/LUYiE2A.png)
### 生物類群在年間的資料偏差
當我們知道各類群都有資料偏差時，這些資料偏差發生在甚麼時候？從有資料以來，資料偏差就存在嗎？在哪些年份之間的資料偏差又特別明顯呢？


## Spatial Data Bias
### 縣市的資料偏差
臺灣生物多樣性是否為會聚集在台北、台中、台南或是高雄等直轄縣市。東半部的資料是否又會明顯較少呢？

### 鄉鎮區的資料偏差
資料明顯較多的縣市，生物多樣性資料是否又會聚集在特定的鄉鎮區，亦或是平均分散在各個行政區呢？
