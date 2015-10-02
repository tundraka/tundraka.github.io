# Q1
# Create a logical vector that identifies the households on greater than 10 acres
# who sold more than $10,000 worth of agriculture products. Assign that logical
# vector to the variable agricultureLogical. Apply the which() function like this
# to identify the rows of the data frame where the logical vector is TRUE.
# which(agricultureLogical) What are the first 3 values that result?

library(data.table)
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
data <- fread('data/ss06hid.csv')
data[ACR==3,agricultureLogical:=(AGS==6)]
which(data$agricultureLogical)

# Q2
# Use the parameter native=TRUE. What are the 30th and 80th quantiles of the
# resulting data? (some Linux systems may produce an answer 638 different for
# the 30th quantile)

#install.packages('jpeg')
library(jpeg)

fileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg'
destFile <- 'data/photo.jpg'
if(!file.exists(destFile)) {
    download.file(fileUrl, destfile=destFile, method='curl')
}
p <- readJPEG(destFile, native=TRUE)
quantile(p, probs=c(0.3, 0.8))

# Q3
# Match the data based on the country shortcode. How many of the IDs match? Sort
# the data frame in descending order by GDP rank (so United States is last).
# What is the 13th country in the resulting data frame? 

library(stringr)
downloadFile <- function(resources) {
    if (!file.exists(resources$dest)) {
        download.file(resources$url, destfile=resources$dest, method='curl')
    }
}
gdpResources <- list(
     url='https://d396qusza40orc.cloudfront.net/getdata/data/GDP.csv',
     dest='data/GDP.csv')
eduResources <- list(
     url='https://d396qusza40orc.cloudfront.net/getdata/data/EDSTATS_Country.csv',
     dest='data/EDU.csv')
downloadFile(gdpResources)
downloadFile(eduResources)

gdp <- fread(gdpResources$dest, skip=5, nrows=190, select=c(1, 2, 5))
edu <- fread(eduResources$dest)

setnames(gdp, names(gdp), c('countrycode', 'rank', 'gdpraw'))
setnames(edu, names(edu), tolower(gsub(' ', '', names(edu))))

m <- merge(gdp, edu, by='countrycode', all=F)
nrow(m) #189
m[order(-rank)][13] # St.Kitts...

# Q4
# What is the average GDP ranking for the "High income: OECD" and
# "High income: nonOECD" group? 

m[,gdpn:=as.numeric(gsub(',', '', str_trim(gdpraw)))]
m[grepl('High income:', incomegroup), .(meangdp=mean(rank)), .(incomegroup)]

#             incomegroup  meangdp
# 1: High income: nonOECD 91.91304
# 2:    High income: OECD 32.96667

# Q5
# Cut the GDP ranking into 5 separate quantile groups. Make a table versus
# Income.Group. How many countries are Lower middle income but among the 38
# nations with highest GDP?

m[,qrt:=cut(gdpn, breaks=quantile(gdpn, probs=seq(0, 1, length=6)))]
table(m$qrt, m$incomegroup)

#                       Lower middle income Upper middle income
#  (40,4.25e+03]                        15                   9
#  (4.25e+03,1.6e+04]                    9                   8
#  (1.6e+04,5.08e+04]                   11                   8
#  (5.08e+04,2.63e+05]                  13                   9
#  (2.63e+05,1.62e+07]                   5                  11
