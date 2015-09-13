library('data.table')

data <- fread('data/household_power_consumption.txt', sep=';', skip='1/2/2007',
              nrows=2880, na.strings='?', select=c(1, 2, 3))

dateTime <- strptime(paste(data[[1]], data[[2]]), '%d/%m/%Y %H:%M:%S')

png(file='plot2.png')
plot(dateTime, data[[3]], type='l', xlab='',
     ylab='Global Active Power (kilowatts)')
dev.off()
