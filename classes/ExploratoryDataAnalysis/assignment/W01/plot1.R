# This script uses the data.table package: install.packages('data.table')
library('data.table')

# I have my data under the data directory. This reads data starting in the row
# that matches the pattern 1/2/2007 and reads 2880 rows (48hr).
# The only column that is loaded is the Global_active_power (position 3)
data <- fread('data/household_power_consumption.txt', sep=';', skip='1/2/2007',
              nrows=2880, na.strings='?', select=3)

png(file='plot1.png')
hist(data[[1]], col="red",
     xlab='Global Active Power (kilowatts)', main='Global Active Power')
dev.off()
