library(XML)
xmlUrl = "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
 
download.file(xmlUrl, "data.xml", "auto", TRUE)
data <- xmlParse("data.xml")
sum(xpathSApply(data, "//zipcode", xmlValue) == 21231)