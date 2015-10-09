## This first line will likely take a few seconds. Be patient!
library(data.table)
NEI <- as.data.table(readRDS("summarySCC_PM25.rds"))
SCC <- as.data.table(readRDS("Source_Classification_Code.rds"))

NEI$type <- as.factor(NEI$type)

baltimore <- NEI[fips=="24510"]
totsBaltimore <- baltimore[,.(totalEmissions=sum(Emissions)), .(year)]
with(totsBaltimore, plot(year, totalEmissions, type='l'))

dev.copy(png, 'plot2.png')
dev.off()
