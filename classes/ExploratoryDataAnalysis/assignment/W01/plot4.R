library('data.table')

data <- fread('data/household_power_consumption.txt', sep=';', skip='1/2/2007',
              nrows=2880, na.strings='?', select=c(1, 2, 3, 4, 5, 7, 8, 9))

dateTime <- strptime(paste(data[[1]], data[[2]]), '%d/%m/%Y %H:%M:%S')

png(file='plot4.png')
par(mfrow=c(2, 2))
plot(dateTime, data[[3]], type='l', xlab='', ylab='Global Active Power (kilowatts)')
plot(dateTime, data[[5]], type='l', xlab='datetime', ylab='Voltage')

plot(dateTime, data[[6]], type='n', xlab='', ylab='Energy sub metering')
lines(dateTime, data[[6]], col='black')
lines(dateTime, data[[7]], col='red')
lines(dateTime, data[[8]], col='blue')
legend('topright', bty='n',
       legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       lty=c(1, 1), col=c('black', 'blue', 'red'))

plot(dateTime, data[[4]], type='l', xlab='datetime', ylab='Global_reactive_power')
dev.off()
