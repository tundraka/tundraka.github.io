## This first line will likely take a few seconds. Be patient!
library(data.table)
NEI <- as.data.table(readRDS("summarySCC_PM25.rds"))
SCC <- as.data.table(readRDS("Source_Classification_Code.rds"))

NEI$type <- as.factor(NEI$type)

# plot6.R
vehicleSCC <- SCC[EI.Sector %like% 'Vehicle', .(SCC)]
cities <- NEI[(fips=='24510'|fips=='06037') & SCC %in% vehicleSCC$SCC, .(totEmi=sum(Emissions)), .(year, fips)]
ggplot(cities, aes(year, totEmi)) + geom_line(aes(color=fips))

dev.copy(png, 'plot6.png')
dev.off()
