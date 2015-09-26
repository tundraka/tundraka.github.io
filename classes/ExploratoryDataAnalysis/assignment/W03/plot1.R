## This first line will likely take a few seconds. Be patient!
library(data.table)
NEI <- as.data.table(readRDS("summarySCC_PM25.rds"))
SCC <- as.data.table(readRDS("Source_Classification_Code.rds"))

NEI$type <- as.factor(NEI$type)

pmSumByYear <- NEI[,.(totalEmissions=sum(Emissions)), .(year)]
plot(pmSumByYear$year, pmSumByYear$totalEmissions, type='l')

baltimore <- NEI[fips=="24510"]
totsBaltimore <- baltimore[,.(totalEmissions=sum(Emissions)), .(year)]
with(totsBaltimore, plot(year, totalEmissions, type='l'))

totsBaltimore <- baltimore[,.(totalEmissions=sum(Emissions)), .(year, type)]
totsBaltimore[,totRoundEmi:=round(totalEmissions, digits=2)]

library(ggplot2)
ggplot(totsBaltimore, aes(year, totRoundEmi)) + 
    geom_line() + 
    facet_grid(type ~ .)

coal <- SCC[EI.Sector %like% 'Coal']
coalTotEmi <- NEI[SCC %in% coal$SCC,.(totEmi=sum(Emissions)), .(year)]
coalTotEmiBySCC <- NEI[SCC %in% coal$SCC, .(totEmi=sum(Emissions)), .(year, SCC)]

upScc <- coalTotEmiBySCC[,.(max(totEmi)), .(SCC, year)]
upSccs <- upScc[year==2008,.(SCC)]
upEmi <- coalTotEmiBySCC[SCC %in% upSccs$SCC]

ggplot(coalTotEmi, aes(year, totEmi)) + geom_line()
ggplot(coalTotEmiBySCC, aes(year, totEmi)) + geom_line(aes(color = SCC))
ggplot(coalTotEmiBySCC, aes(year, totEmi)) + geom_line(aes(color = SCC)) + coord_cartesian(ylim = c(0, 1.0e+05))
ggplot(coalTotEmiBySCC, aes(year, totEmi)) + geom_line(aes(color = SCC)) + coord_cartesian(ylim = c(0, 12500))
ggplot(upEmi, aes(year, totEmi)) + geom_line(aes(color = SCC))
