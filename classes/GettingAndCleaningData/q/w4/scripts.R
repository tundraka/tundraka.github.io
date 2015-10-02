library(data.table)

# Q1
fileResource <- 'https://d396qusza40orc.cloudfront.net/getdata/data/ss06hid.csv'
destFile <- 'ss06hid.csv'
if (!file.exists(destFile)) {
    download.file(fileResource, destfile=destFile, method='curl')
}

data <- fread(destFile)
strsplit(names(data), 'wgtp')[123]# [1] ""   "15"

# Q2
library(stringr)
gdpResource <- 'https://d396qusza40orc.cloudfront.net/getdata/data/GDP.csv'
gdpDest <- 'gdp.csv'
if (!file.exists(gdpDest)) {
    download.file(gdpResource, destfile=gdpDest, method='curl')
}

colNames <- c('countrycode', 'countryname', 'gdpraw')
gdp <- fread(gdpDest, skip=5, select=c(1, 4, 5), nrows=190)
setnames(gdp, names(gdp), colNames)
gdp[,gdps:=str_trim(gsub(',', '', gdpraw))]
gdp[,gdpn:=as.numeric(gdps)]

# Q3
gdp[grepl('^United', countryname),.N] # [1] 3
# or
grep('^United', gdp$countryname) # [1]  1  6 32

# Q4
eduResource <- 'https://d396qusza40orc.cloudfront.net/getdata/data/EDSTATS_Country.csv'
eduDest <- 'edu_country.csv'

if (!file.exists(eduDest)) {
    download.file(eduResource, destfile=eduDest, method='curl')
}

edu <- fread(eduDest)
setnames(edu, names(edu), gsub(' ','', tolower(names(edu))))

m <- merge(gdp, edu, by='countrycode', all=F)
m[grepl('Fiscal year end: June', specialnotes), .N]

# Q5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

s2012 <- sampleTimes[year(sampleTimes) == 2012]
length(s2012)
length(s2012[weekdays(s2012) == 'Monday'])
