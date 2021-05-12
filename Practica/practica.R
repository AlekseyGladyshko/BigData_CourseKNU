# Дані були скачені з веб-ресурсу https://www.kaggle.com/gpreda/covid-world-vaccination-progress?select=country_vaccinations.csv
# install.packages("dplyr")
library(dplyr)

dataFileName <- "country_vaccinations.csv"
df <- read.csv(dataFileName)

# Огляд оригінальних даних
head(df, 3)
tail(df, 3)
names(df)
ncol(df)
nrow(df)

# Передостанній та останній стовпці містять інформацію щодо оригінального ресурсу, 
# яка нам не потрібен - видалемо їх
df <- df[-c(ncol(df)-1, ncol(df))]

# Порахуємо ількість null значень для кожного стовпця
as.data.frame(colSums(is.na(df)))

# Перевіремо типи даних у стовпцях
sapply(df, class)
# Змінемо тип стовпця date на потрібний
transform(df, date= as.Date(date, format= "%Y-%m-%d"))

# Переконаємося що дублікати відсутні
sum(duplicated(df), FALSE)

# Приклад: Перші 10 країн за кількістю вакцинованих людей
df %>% group_by(country) %>% summarise(total_vaccinations = max(total_vaccinations, na.rm = TRUE)) %>% arrange(desc(total_vaccinations)) %>% head(10)
