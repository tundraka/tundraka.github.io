# This script uses the data.table package: install.packages('data.table')
library('data.table')

# I have my data under the data directory. This reads data starting in the row
# that matches the pattern 1/2/2007 and reads 2880 rows (48hr).
# The columns that are read are Date, Time, Global_active_power,
# Global_reactive_power, Voltage and Sub_metering_{1, 2, 3}
data <- fread('data/household_power_consumption.txt', sep=';', skip='1/2/2007',
              nrows=2880, na.strings='?', select=c(1, 2, 3, 4, 5, 7, 8, 9))

# We contact date and time and create a new column with the correct type.
dateTime <- strptime(paste(data[[1]], data[[2]]), '%d/%m/%Y %H:%M:%S')

png(file='plot4.png')
# 2x2 grid
par(mfrow=c(2, 2))

# first 2 plots
plot(dateTime, data[[3]], type='l', xlab='', ylab='Global Active Power (kilowatts)')
plot(dateTime, data[[5]], type='l', xlab='datetime', ylab='Voltage')

# 3rd plot
plot(dateTime, data[[6]], type='n', xlab='', ylab='Energy sub metering')
lines(dateTime, data[[6]], col='black')
lines(dateTime, data[[7]], col='red')
lines(dateTime, data[[8]], col='blue')
legend('topright', bty='n',
       legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       lty=c(1, 1), col=c('black', 'blue', 'red'))

# 4th plot.
plot(dateTime, data[[4]], type='l', xlab='datetime', ylab='Global_reactive_power')

dev.off()
