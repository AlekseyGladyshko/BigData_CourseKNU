# Лабораторна робота No 4. Зчитування даних з реляційних баз даних.

0. Створюємо зд'єднання з базою даних
```r
# install.packages("RSQLite")
# install.packages("DBI")

library(RSQLite)
dbPath <- "./database.sqlite"
conn <- dbConnect(RSQLite::SQLite(), dbPath)
n <- 10

fetchQuery <- function(query) {
  res <- dbSendQuery(conn, query)
  dataFetched <- dbFetch(res, n=n)
  dbClearResult(res)
  return(dataFetched)
}
```
1. Назва статті (Title), тип виступу (EventType). Необхідно вибрати тільки статті с типом виступу Spotlight. Сортування по назві статті.
```r
sqlQuery1 <- "SELECT Title, EventType FROM Papers WHERE EventType='Spotlight' ORDER BY Title"
dataFrame1 <- fetchQuery(sqlQuery1)
dataFrame1
```
```
1 A Tractable Approximation to Optimal Point Process Filtering: Application to Neural Encoding
2 Accelerated Mirror Descent in Continuous and Discrete Time
3 Action-Conditional Video Prediction using Deep Networks in Atari Games
4 Adaptive Online Learning
5 Asynchronous Parallel Stochastic Gradient for Nonconvex Optimization
6 Attention-Based Models for Speech Recognition
7 Automatic Variational Inference in Stan
8 Backpropagation for Energy-Efficient Neuromorphic Computing
9 Bandit Smooth Convex Optimization: Improving the Bias-Variance Tradeoff
10 Biologically Inspired Dynamic Textures for Probing Motion Perception
```
2. Ім’я автора (Name), Назва статті (Title). Необхідно вивести всі назви статей для автора «Josh Tenenbaum». Сортування по назві статті.
```r
sqlQuery2 <- "SELECT Papers.Title FROM Papers
JOIN PaperAuthors ON Papers.Id=PaperAuthors.PaperId
JOIN Authors ON Authors.Id=PaperAuthors.AuthorId
WHERE Name='Josh Tenenbaum' ORDER BY Papers.Title"
dataFrame2 <- fetchQuery(sqlQuery2)
dataFrame2
```
```
       Title
1 Deep Convolutional Inverse Graphics Network
2 Galileo: Perceiving Physical Object Properties by Integrating a Physics Engine with Deep Learning
3 Softstar: Heuristic-Guided Probabilistic Inference
4 Unsupervised Learning by Program Synthesis
```
3. Вибрати всі назви статей (Title), в яких є слово «statistical». Сортування по назві статті.
```r
sqlQuery3 <- "SELECT Title FROM Papers WHERE Title LIKE '%statistical%' ORDER BY Title"
dataFrame3 <- fetchQuery(sqlQuery3)
dataFrame3
```
```
 Title
1 Adaptive Primal-Dual Splitting Methods for Statistical Learning and Image Processing
2 Evaluating the statistical significance of biclusters
3 Fast Randomized Kernel Ridge Regression with Statistical Guarantees
4 High Dimensional EM Algorithm: Statistical Optimization and Asymptotic Normality
5 Non-convex Statistical Optimization for Sparse Tensor Graphical Model
6 Regularized EM Algorithms: A Unified Framework and Statistical Guarantees
7 Statistical Model Criticism using Kernel Two Sample Tests
8 Statistical Topological Data Analysis - A Kernel Perspective
```
4. Ім’я автору (Name), кількість статей по кожному автору (NumPapers). Сортування по кількості статей від більшої кількості до меньшої.
```r
sqlQuery4 <- "SELECT Authors.Name, count(Authors.Id) as NumPapers FROM Papers
JOIN PaperAuthors ON Papers.Id=PaperAuthors.PaperId
JOIN Authors ON Authors.Id=PaperAuthors.AuthorId
GROUP BY Authors.Id ORDER BY count(Authors.Id) DESC"
dataFrame4 <- fetchQuery(sqlQuery4)
dataFrame4
```
```
                   Name NumPapers
1  Pradeep K. Ravikumar         7
2               Han Liu         6
3        Lawrence Carin         6
4   Inderjit S. Dhillon         5
5               Le Song         5
6     Zoubin Ghahramani         5
7        Christopher Re         4
8  Simon Lacoste-Julien         4
9          Zhaoran Wang         4
10     Csaba Szepesvari         4
```
```r
dbDisconnect(conn)
```