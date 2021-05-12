# Лабораторна робота 1. Завантаження та зчитування даних.

1. За допомогою download.file() завантажте любий excel файл з порталу http://data.gov.ua та зчитайте його (xls, xlsx – бінарні формати, тому встановить mode = “wb”. Виведіть перші 6 строк отриманого фрейму даних.
```r
# встановлюєм потрібну бібліотеку
install.packages("xlsx")

# завантажуємо файл
library(xlsx)

dataUrl <- "https://data.gov.ua/dataset/64579ef8-633c-4752-8f21-75231b3bdbc5/resource/2d4b578f-866e-4133-9fe2-213eb2aaa261/download/nuclear_production_03_2021.xlsx"

download.file(dataUrl, "data1.xlsx", "auto", TRUE, "wb")
data1 <- read.xlsx("data1.xlsx", 1)
head(data1, 6);
```
```
  year month     code   enterprise    activity product  amount     cost
1 2018     1 14309787 ДП "СхідГЗК"   видобуток      УР 60095.0       NA
2 2018     1 14309787 ДП "СхідГЗК" виробництво     УОК   139.2 429966.4
3 2018     2 14309787 ДП "СхідГЗК"   видобуток      УР 57140.0       NA
4 2018     2 14309787 ДП "СхідГЗК" виробництво     УОК   162.3 504702.3
5 2018     3 14309787 ДП "СхідГЗК"   видобуток      УР 61277.0       NA
6 2018     3 14309787 ДП "СхідГЗК" виробництво     УОК    93.2 285267.9
```
2. За допомогою download.file() завантажте файл getdata_data_ss06hid.csv за посиланням https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv та завантажте дані в R. Code book, що пояснює значення змінних знаходиться за посиланням https://www.dropbox.com/s/dijv0rlwo4mryv5/PUMSDataDict06.pdf?dl=0
Необхідно знайти, скільки property мають value $1000000+
```r
getdata_data_ss06hid_Url = "https://d396qusza40orc.cloudfront.net/getdata/data/ss06hid.csv"
download.file(getdata_data_ss06hid_Url, "data2.csv", "auto", TRUE)
data2 <- read.csv("data2.csv")

# Згідно з Cook book, значення "24" поля VAL відповідають значенням $1m+
sum(data2$VAL == 24, na.rm = TRUE)
```
```
[1] 53
```
3. Зчитайте xml файл за посиланням http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml
Скільки ресторанів мають zipcode 21231?
```r
# встановлюєм потрібну бібліотеку
install.packages("XML")

# завантажуємо файл
library(XML)
xmlUrl = "http://d396qusza40orc.cloudfront.net/getdata/data/restaurants.xml"

download.file(xmlUrl, "data3.xml", "auto", TRUE)
data3 <- xmlParse("data3.xml")
sum(xpathSApply(data3, "//zipcode", xmlValue) == 21231)
```
```
[1] 127	
```