## This first line will likely take a few seconds. Be patient!
library(data.table)
NEI <- as.data.table(readRDS("summarySCC_PM25.rds"))
SCC <- as.data.table(readRDS("Source_Classification_Code.rds"))

NEI$type <- as.factor(NEI$type)

# plot4.R
coal <- SCC[EI.Sector %like% 'Coal']
coalTotEmi <- NEI[SCC %in% coal$SCC,.(totEmi=sum(Emissions)), .(year)]
coalTotEmiBySCC <- NEI[SCC %in% coal$SCC, .(totEmi=sum(Emissions)), .(year, SCC)]

# Trying to find out trends upward in any of the coal burning.
upScc <- coalTotEmiBySCC[,.(max(totEmi)), .(SCC, year)]
upSccs <- upScc[year==2008,.(SCC)]

ggplot(coalTotEmi, aes(year, totEmi)) + geom_line()

#ggplot(coalTotEmiBySCC, aes(year, totEmi)) + geom_line(aes(color = SCC))
#ggplot(coalTotEmiBySCC, aes(year, totEmi)) + geom_line(aes(color = SCC)) + coord_cartesian(ylim = c(0, 1.0e+05))
#ggplot(coalTotEmiBySCC, aes(year, totEmi)) + geom_line(aes(color = SCC)) + coord_cartesian(ylim = c(0, 12500))

dev.copy(png, 'plot4.png')
dev.off()
