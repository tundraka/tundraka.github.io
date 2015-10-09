library('data.table')

colClasses <- c('character', 'character', rep('numeric', 7))
data <- fread('data/household_power_consumption.txt', sep=';', skip='1/2/2007',
              nrows=2880, na.strings='?', colClasses=colClasses)

colnames(data) <- c('Date', 'Time', 'Global_active_power', 'Global_reactive_power',
                    'Voltage', 'Global_intensity', 'Sub_metering_1',
                    'Sub_metering_2', 'Sub_metering_3')

dataTime <- strptime(paste(data[[1]], data[[2]]),  '%d/%m/%Y %H:%M:%S')

hist(data$Global_active_power, col="red",
     xlab='Global Active Power (kilowatts)', main='Global Active Power')

png(file='output.pdf')
# To close the device, in this case the file
dev.off()
