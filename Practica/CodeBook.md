# Практична робота.

## 1. Написати R scipt для завантаження даних в R.
Дані були скачені з веб-ресурсу https://www.kaggle.com/gpreda/covid-world-vaccination-progress?select=country_vaccinations.csv
```r
# install.packages("dplyr")
library(dplyr)

dataFileName <- "country_vaccinations.csv"
df <- read.csv(dataFileName)
```

## 2. Створити Code Book для даних
Даний датасет містить інформацію про:
* Country - це країна, для якої надається інформація про щеплення;
* Country ISO Code - ISO код країни;
* Date - дата введення даних; для деяких дат ми маємо лише щоденні щеплення, для інших - лише загальну (сукупну) вакцинацію;
* Total number of vaccin ations - це абсолютна кількість загальних щеплень в країні;
* Total number of people vaccinated - людина, залежно від схеми імунізації, отримає одну або кілька (зазвичай 2) вакцин; в певний момент кількість щеплень може бути більшою, ніж кількість людей;
* Total number of people fully vaccinated - це кількість людей, які отримали весь набір імунізації за схемою імунізації (як правило, 2); в певний момент часу може бути певна кількість людей, які отримали одну вакцину, і інша кількість (менша) людей, які отримали всі вакцини за схемою;
* Daily vaccinations (raw) - для певного введення даних, кількість щеплень для цієї дати / країни;
* Daily vaccinations - для певного введення даних, кількість щеплень для цієї дати / країни;
* Total vaccinations per hundred - співвідношення (у відсотках) між кількістю щеплень та загальною чисельністю населення на сьогоднішній день у країні;
* Total number of people vaccinated per hundred - співвідношення (у відсотках) між імунізованим населенням та загальним населенням на сьогоднішній день у країні;
* Total number of people fully vaccinated per hundred - співвідношення (у відсотках) між повністю імунізованим населенням та загальним населенням на сьогоднішній день в країні;
* Number of vaccinations per day - кількість щоденних щеплень за цей день і країну;
* Daily vaccinations per million - співвідношення (у проміле) між кількістю щеплень та загальною чисельністю населення на поточну дату в країні;
* Vaccines used in the country - загальна кількість вакцин, що використовуються в країні (на сьогоднішній день);
* Source name - джерело інформації (національний орган, міжнародна організація, місцева організація тощо);
* Source website - веб-сайт джерела інформації;

## 3/4. Провести огляд даних / якщо необхідно, підготувати дані для аналізу.
Огляд оригінальних даних
Перші 3 рядки
```r
head(df, 3)
```
```
      country iso_code       date total_vaccinations people_vaccinated
1 Afghanistan      AFG 2021-02-22                  0                 0
2 Afghanistan      AFG 2021-02-23                 NA                NA
3 Afghanistan      AFG 2021-02-24                 NA                NA
  people_fully_vaccinated daily_vaccinations_raw daily_vaccinations
1                      NA                     NA                 NA
2                      NA                     NA               1367
3                      NA                     NA               1367
  total_vaccinations_per_hundred people_vaccinated_per_hundred
1                              0                             0
2                             NA                            NA
3                             NA                            NA
  people_fully_vaccinated_per_hundred daily_vaccinations_per_million
1                                  NA                             NA
2                                  NA                             35
3                                  NA                             35
            vaccines               source_name
1 Oxford/AstraZeneca Government of Afghanistan
2 Oxford/AstraZeneca Government of Afghanistan
3 Oxford/AstraZeneca Government of Afghanistan
                                                                                                source_website
1 https://reliefweb.int/report/afghanistan/afghanistan-strategic-situation-report-covid-19-no-95-22-april-2021
2 https://reliefweb.int/report/afghanistan/afghanistan-strategic-situation-report-covid-19-no-95-22-april-2021
3 https://reliefweb.int/report/afghanistan/afghanistan-strategic-situation-report-covid-19-no-95-22-april-2021
```
Останні 3 рядки
```r
tail(df, 3)
```
```
       country iso_code       date total_vaccinations people_vaccinated
15664 Zimbabwe      ZWE 2021-05-04             559777            452191
15665 Zimbabwe      ZWE 2021-05-05             576233            461023
15666 Zimbabwe      ZWE 2021-05-06             607355            478174
      people_fully_vaccinated daily_vaccinations_raw daily_vaccinations
15664                  107586                  22261              17977
15665                  115210                  16456              16889
15666                  129181                  31122              18537
      total_vaccinations_per_hundred people_vaccinated_per_hundred
15664                           3.77                          3.04
15665                           3.88                          3.10
15666                           4.09                          3.22
      people_fully_vaccinated_per_hundred daily_vaccinations_per_million
15664                                0.72                           1210
15665                                0.78                           1136
15666                                0.87                           1247
               vaccines        source_name
15664 Sinopharm/Beijing Ministry of Health
15665 Sinopharm/Beijing Ministry of Health
15666 Sinopharm/Beijing Ministry of Health
                                               source_website
15664 https://twitter.com/MoHCCZim/status/1390390738345730052
15665 https://twitter.com/MoHCCZim/status/1390390738345730052
15666 https://twitter.com/MoHCCZim/status/1390390738345730052
```
Назви стовпців
```r
names(df)
```
```
 [1] "country"                             "iso_code"                           
 [3] "date"                                "total_vaccinations"                 
 [5] "people_vaccinated"                   "people_fully_vaccinated"            
 [7] "daily_vaccinations_raw"              "daily_vaccinations"                 
 [9] "total_vaccinations_per_hundred"      "people_vaccinated_per_hundred"      
[11] "people_fully_vaccinated_per_hundred" "daily_vaccinations_per_million"     
[13] "vaccines"                            "source_name"                        
[15] "source_website" 
```
Кількість стовпців
```r
ncol(df)
```
```
[1] 15
```
Кількість рядків
```r
nrow(df)
```
```
[1] 15666
```
Передостанній та останній стовпці містять інформацію щодо оригінального ресурсу, яка нам не потрібен - видалемо їх
```r
df <- df[-c(ncol(df)-1, ncol(df))]
```
Порахуємо кількість null значень для кожного стовпця
```r
as.data.frame(colSums(is.na(df)))
```
```
country                                              0
iso_code                                             0
date                                                 0
total_vaccinations                                6229
people_vaccinated                                 6912
people_fully_vaccinated                           9164
daily_vaccinations_raw                            7738
daily_vaccinations                                 201
total_vaccinations_per_hundred                    6229
people_vaccinated_per_hundred                     6912
people_fully_vaccinated_per_hundred               9164
daily_vaccinations_per_million                     201
vaccines                                             0
```
Перевіремо типи даних у стовпцях
```r
sapply(df, class)
```
```
                            country                            iso_code 
                        "character"                         "character" 
                               date                  total_vaccinations 
                        "character"                           "numeric" 
                  people_vaccinated             people_fully_vaccinated 
                          "numeric"                           "numeric" 
             daily_vaccinations_raw                  daily_vaccinations 
                          "numeric"                           "numeric" 
     total_vaccinations_per_hundred       people_vaccinated_per_hundred 
                          "numeric"                           "numeric" 
people_fully_vaccinated_per_hundred      daily_vaccinations_per_million 
                          "numeric"                           "numeric" 
                           vaccines 
                        "character" 
```
Змінемо тип стовпця date на потрібний
```r
transform(df, date= as.Date(date, format= "%Y-%m-%d"))
```
Переконаємося що дублікати відсутні
```r
sum(duplicated(df), FALSE)
```
```
[1] 0
```
Приклад: перші 10 країн за кількістю вакцинованих людей
```r
df %>% group_by(country) %>% summarise(total_vaccinations = max(total_vaccinations, na.rm = TRUE)) %>% arrange(desc(total_vaccinations)) %>% head(10)
```
```
   country        total_vaccinations
   <chr>                       <dbl>
 1 China                   297734000
 2 United States           251973752
 3 India                   162603603
 4 United Kingdom           51225890
 5 Brazil                   46542392
 6 England                  42864836
 7 Germany                  33565445
 8 Turkey                   24467719
 9 France                   23949989
10 Italy                    22644364
```