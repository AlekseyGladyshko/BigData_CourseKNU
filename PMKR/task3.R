filePath <- "racers.csv"
formula1 <- read.csv(filePath)

# subtask 1
head(formula1, 10)

# subtask 2
sum(formula1$Country == 'USA')

# subtask3
sum(formula1$World.Championships != "N/A")