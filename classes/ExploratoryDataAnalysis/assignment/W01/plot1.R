library('data.table')

data <- fread('data/household_power_consumption.txt', sep=';', skip='1/2/2007',
              nrows=2880, na.strings='?', select=3)

png(file='plot1.png')
hist(data[[1]], col="red",
     xlab='Global Active Power (kilowatts)', main='Global Active Power')
dev.off()
