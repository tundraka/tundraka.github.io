## This first line will likely take a few seconds. Be patient!
library(data.table)
NEI <- as.data.table(readRDS("summarySCC_PM25.rds"))
SCC <- as.data.table(readRDS("Source_Classification_Code.rds"))

NEI$type <- as.factor(NEI$type)

# plot1.R
pmSumByYear <- NEI[,.(totalEmissions=sum(Emissions)), .(year)]
plot(pmSumByYear$year, pmSumByYear$totalEmissions, type='l')

# plot2.R
baltimore <- NEI[fips=="24510"]
totsBaltimore <- baltimore[,.(totalEmissions=sum(Emissions)), .(year)]
with(totsBaltimore, plot(year, totalEmissions, type='l'))

# plot3.R
totsBaltimore <- baltimore[,.(totalEmissions=sum(Emissions)), .(year, type)]
totsBaltimore[,totRoundEmi:=round(totalEmissions, digits=2)]

library(ggplot2)
ggplot(totsBaltimore, aes(year, totRoundEmi)) + geom_line() + facet_grid(type ~ .)

# plot4.R
coal <- SCC[EI.Sector %like% 'Coal']
coalTotEmi <- NEI[SCC %in% coal$SCC,.(totEmi=sum(Emissions)), .(year)]
coalTotEmiBySCC <- NEI[SCC %in% coal$SCC, .(totEmi=sum(Emissions)), .(year, SCC)]

# Trying to find out trends upward in any of the coal burning.
upScc <- coalTotEmiBySCC[,.(max(totEmi)), .(SCC, year)]
upSccs <- upScc[year==2008,.(SCC)]

ggplot(coalTotEmi, aes(year, totEmi)) + geom_line()
ggplot(coalTotEmiBySCC, aes(year, totEmi)) + geom_line(aes(color = SCC))
ggplot(coalTotEmiBySCC, aes(year, totEmi)) + geom_line(aes(color = SCC)) + coord_cartesian(ylim = c(0, 1.0e+05))
ggplot(coalTotEmiBySCC, aes(year, totEmi)) + geom_line(aes(color = SCC)) + coord_cartesian(ylim = c(0, 12500))

# plot5.R
vehicleSCC <- SCC[EI.Sector %like% 'Vehicle', .(SCC)]
baltimore <- NEI[fips=="24510" & SCC %in% vehicleSCC$SCC, .(totEmi=sum(Emissions)), .(year)]
ggplot(baltimore, aes(year, totEmi)) + geom_line()

# plot6.R
vehicleSCC <- SCC[EI.Sector %like% 'Vehicle', .(SCC)]
cities <- NEI[(fips=='24510'|fips=='06037') & SCC %in% vehicleSCC$SCC, .(totEmi=sum(Emissions)), .(year, fips)]
ggplot(cities, aes(year, totEmi)) + geom_line(aes(color=fips))
