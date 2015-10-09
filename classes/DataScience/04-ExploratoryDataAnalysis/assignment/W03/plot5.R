## This first line will likely take a few seconds. Be patient!
library(data.table)
NEI <- as.data.table(readRDS("summarySCC_PM25.rds"))
SCC <- as.data.table(readRDS("Source_Classification_Code.rds"))

NEI$type <- as.factor(NEI$type)

# plot5.R
vehicleSCC <- SCC[EI.Sector %like% 'Vehicle', .(SCC)]
baltimore <- NEI[fips=="24510" & SCC %in% vehicleSCC$SCC, .(totEmi=sum(Emissions)), .(year)]
ggplot(baltimore, aes(year, totEmi)) + geom_line()

dev.copy(png, 'plot5.png')
dev.off()
