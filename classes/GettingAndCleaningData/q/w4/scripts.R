library(data.table)
library(stringr)

baseDataDir <- 'data'
if (!dir.exists(baseDataDir)) {
    dir.create(baseDataDir)
}

destPath <- function(fileName) {
    paste0(baseDataDir, '/', fileName)
}

downloadFile <- function(resource, destination = '') {
    if (is.null(resource) | nchar(str_trim(resource)) == 0) {
        stop('resource not specified, nothing to download')
    }

    if (is.null(destination) | nchar(str_trim(destination)) == 0) {
        destination <- basename(resource)
    }

    destination <- destPath(destination)
    if (!file.exists(destination)) {
        download.file(resource, destfile=destination, method='curl')
    }

    destination
}

# Q1
fileResource <- 'https://d396qusza40orc.cloudfront.net/getdata/data/ss06hid.csv'
destFile <- downloadFile(fileResource)

data <- fread(destFile)
strsplit(names(data), 'wgtp')[123]# [1] ""   "15"

# Q2
gdpResource <- 'https://d396qusza40orc.cloudfront.net/getdata/data/GDP.csv'
gdpDest <- downloadFile(gdpResource, 'gdp.csv')

gdp <- fread(gdpDest, skip=5, select=c(1, 4, 5), nrows=190)

colNames <- c('countrycode', 'countryname', 'gdpraw')
setnames(gdp, names(gdp), colNames)

gdp[,gdps:=str_trim(gsub(',', '', gdpraw))]
gdp[,gdpn:=as.numeric(gdps)]

# Q3
gdp[grepl('^United', countryname),.N] # [1] 3
# or
grep('^United', gdp$countryname) # [1]  1  6 32

# Q4
eduResource <- 'https://d396qusza40orc.cloudfront.net/getdata/data/EDSTATS_Country.csv'
eduDest <- downloadFile(eduResource, 'edu_country.csv')

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
