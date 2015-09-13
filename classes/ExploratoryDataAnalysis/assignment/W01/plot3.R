library('data.table')

data <- fread('data/household_power_consumption.txt', sep=';', skip='1/2/2007',
              nrows=2880, na.strings='?', select=c(1, 2, 7, 8, 9))

dateTime <- strptime(paste(data[[1]], data[[2]]), '%d/%m/%Y %H:%M:%S')

png(file='plot3.png')
plot(dateTime, data[[3]], type='n', xlab='', ylab='Energy sub metering')
lines(dateTime, data[[3]], col='black')
lines(dateTime, data[[4]], col='red')
lines(dateTime, data[[5]], col='blue')
legend('topright', legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       lty=c(1, 1), col=c('black', 'blue', 'red'))
dev.off()
