# Лабораторна робота No 3. Зчитування даних з WEB.

0. Зчитування та підготовка даних
```r
# install.packages("rvest")

library(rvest)

htmlPageUrl <- "http://www.imdb.com/search/title?count=100&release_date=2017,2017&title_type=feature"

htmlPage = read_html(htmlPageUrl)

rank_data_selector <- ".text-primary"
title_data_selector <- ".lister-item-header a"
runtime_data_selector <- ".text-muted .runtime"

getDataBySelector <- function(selector) {
  selectedData <- html_text(html_nodes(htmlPage, selector))
  return(selectedData)
}

rank_data <- as.numeric(getDataBySelector(rank_data_selector))
title_data <- getDataBySelector(title_data_selector)
runtime_data <- as.numeric(gsub(" min", "", getDataBySelector(runtime_data_selector)))

movies <- data.frame(rank = rank_data, title = title_data, runtime = runtime_data, stringsAsFactors = FALSE)
movies
```
```
    rank                                    title runtime
1      1                            Тор: Раґнарок     130
2      2                      Ліга справедливості     120
3      3             Той, хто біжить по лезу 2049     164
4      4                     Тюльпанова лихоманка     105
5      5                      Вартові Галактики 2     136
6      6                                  Дюнкерк     106
7      7       Три білборди під Еббінґом, Міссурі     115
8      8          Людина-павук: Повернення додому     133
9      9                               Диво-жінка     141
10    10                                     Воно     135
11    11                     Найвеличніший шоумен     105
12    12                                   Пастка     104
13    13                                На драйві     113
14    14  Зоряні війни: Епізод 8 - Останні Джедаї     152
15    15                   Назви мене своїм ім'ям     132
16    16               Джуманджі: Поклик джунглів     119
17    17                               Форма води     123
18    18                                     Коко     105
19    19                                  Я, Тоня     119
20    20                           Чужий: Заповіт     122
21    21                          Логан: Росомаха     137
22    22                  Kingsman: Золоте кільце     141
23    23               Король Артур: Легенда меча     126
24    24                      Рятувальники Малібу     116
25    25                     Красуня і Чудовисько     129
26    26               Дружина доглядача зоопарку     127
27    27                      Конг: Острів черепа     118
28    28                     Американський убивця     111
29    29                             Вітряна ріка     107
30    30 Пірати Карибського моря: Помста Салазара     129
31    31                                 Форсаж 8     136
32    32                                  Метелик     133
33    33                                  Наїзник     104
34    34                               Темні часи     125
35    35                                    Мумія     111
36    36                            Таємний агент      98
37    37                                     Диво     113
38    38                               Джон Вік 2     122
39    39             Вбивство у Східному експресі     114
40    40                    Пригоди Паддінгтона 2     103
41    41                          The Current War     108
42    42             Трансформери: Останній лицар     154
43    43                               Обдарована     101
44    44           Валеріан і місто тисячі планет     136
45    45                               Леді Бьорд      94
46    46                     Тілоохоронець кілера     118
47    47                                    Мати!     121
48    48                           Смерть Сталіна     107
49    49                               Гарні часи     102
50    50                                    Життя     104
51    51                                Гра Моллі     140
52    52                            Гра Джеральда     103
53    53                Вбивство священного оленя     121
54    54                                   Нянька      85
55    55                             Удача Лоґана     118
56    56                                 Геошторм     109
57    57                           Примарна нитка     130
58    58                                    Сфера     110
59    59                        Постріл в безодню     121
60    60                                   Пила 8      92
61    61                                     Kuso      94
62    62                Saban's Могутні рейнджери     124
63    63              П'ятдесят відтінків темряви     118
64    64                         Атомна Блондинка     115
65    65                               Сім сестер     123
66    66                    Війна за планету мавп     140
67    67            Баррі Сіл: Король контрабанди     115
68    68                                     Окча     120
69    69                                   Вороги     134
70    70                           Дух в оболонці     107
71    71                                   Ритуал      94
72    72                                  Яскраві     117
73    73                        1+1: Нова історія     126
74    74                           Секретне досьє     116
75    75                  Тебе ніколи тут не було      89
76    76                       Анабель: Створення     109
77    77                             Disobedience     114
78    78                         Проект 'Флорида'     111
79    79                                Столик 19      87
80    80                             Горе-творець     104
81    81         Каліфорнійський дорожній патруль     100
82    82                                     HHhH     120
83    83                              Коматозники     109
84    84                          Усі гроші світу     132
85    85                                Іноземець     113
86    86                         Кривий будиночок     115
87    87                             Зошит смерті     101
88    88                        Кохання - хвороба     120
89    89                                Фердинанд     108
90    90                                  Новизна     117
91    91                       24 години на життя      93
92    92                                   Помста     108
93    93                                  Забутий     108
94    94                                  Тачки 3     102
95    95                                     Amar     105
96    96                               Темна вежа      95
97    97                                  Джунглі     115
98    98                        Ідеальний голос 3      93
99    99                                     1922     102
100  100                      Інгрід їде на Захід      98
```

1. Виведіть перші 6 назв фільмів дата фрейму.
```r
head(movies$title, 6)
```
```
[1] "Тор: Раґнарок"                "Ліга справедливості"         
[3] "Той, хто біжить по лезу 2049" "Тюльпанова лихоманка"        
[5] "Вартові Галактики 2"          "Дюнкерк"
```
2. Виведіть всі назви фільмів з тривалістю більше 120хв.
```r
movies[movies$runtime > 120, ]$title
```
```
 [1] "Тор: Раґнарок"                           
 [2] "Той, хто біжить по лезу 2049"            
 [3] "Вартові Галактики 2"                     
 [4] "Людина-павук: Повернення додому"         
 [5] "Диво-жінка"                              
 [6] "Воно"                                    
 [7] "Зоряні війни: Епізод 8 - Останні Джедаї" 
 [8] "Назви мене своїм ім'ям"                  
 [9] "Форма води"                              
[10] "Чужий: Заповіт"                          
[11] "Логан: Росомаха"                         
[12] "Kingsman: Золоте кільце"                 
[13] "Король Артур: Легенда меча"              
[14] "Красуня і Чудовисько"                    
[15] "Дружина доглядача зоопарку"              
[16] "Пірати Карибського моря: Помста Салазара"
[17] "Форсаж 8"                                
[18] "Метелик"                                 
[19] "Темні часи"                              
[20] "Джон Вік 2"                              
[21] "Трансформери: Останній лицар"            
[22] "Валеріан і місто тисячі планет"          
[23] "Мати!"                                   
[24] "Гра Моллі"                               
[25] "Вбивство священного оленя"               
[26] "Примарна нитка"                          
[27] "Постріл в безодню"                       
[28] "Saban's Могутні рейнджери"               
[29] "Сім сестер"                              
[30] "Війна за планету мавп"                   
[31] "Вороги"                                  
[32] "1+1: Нова історія"                       
[33] "Усі гроші світу"   
```
3. Скільки фільмів мають тривалість менше 100хв.
```r
nrow(movies[which(movies$runtime < 100),])
```
```
[1] 12
```
