# This script uses the data.table package: install.packages('data.table')
library('data.table')

# I have my data under the data directory. This reads data starting in the row
# that matches the pattern 1/2/2007 and reads 2880 rows (48hr).
# The columns that are read are Date, Time and Global_active_power
data <- fread('data/household_power_consumption.txt', sep=';', skip='1/2/2007',
              nrows=2880, na.strings='?', select=c(1, 2, 3))

# We contact date and time and create a new column with the correct type.
dateTime <- strptime(paste(data[[1]], data[[2]]), '%d/%m/%Y %H:%M:%S')

png(file='plot2.png')
plot(dateTime, data[[3]], type='l', xlab='',
     ylab='Global Active Power (kilowatts)')
dev.off()
