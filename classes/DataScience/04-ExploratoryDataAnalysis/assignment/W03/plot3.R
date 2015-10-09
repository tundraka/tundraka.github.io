## This first line will likely take a few seconds. Be patient!
library(data.table)
NEI <- as.data.table(readRDS("summarySCC_PM25.rds"))
SCC <- as.data.table(readRDS("Source_Classification_Code.rds"))

NEI$type <- as.factor(NEI$type)

# plot3.R
totsBaltimore <- baltimore[,.(totalEmissions=sum(Emissions)), .(year, type)]
totsBaltimore[,totRoundEmi:=round(totalEmissions, digits=2)]

library(ggplot2)
ggplot(totsBaltimore, aes(year, totRoundEmi)) + geom_line() + facet_grid(type ~ .)

dev.copy(png, 'plot3.png')
dev.off()
