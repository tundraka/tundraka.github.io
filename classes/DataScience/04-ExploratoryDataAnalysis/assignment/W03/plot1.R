## This first line will likely take a few seconds. Be patient!
library(data.table)
NEI <- as.data.table(readRDS("summarySCC_PM25.rds"))
SCC <- as.data.table(readRDS("Source_Classification_Code.rds"))

NEI$type <- as.factor(NEI$type)

# plot1.R
pmSumByYear <- NEI[,.(totalEmissions=sum(Emissions)), .(year)]
plot(pmSumByYear$year, pmSumByYear$totalEmissions, type='l')

dev.copy(png, 'plot1.png')
dev.off()

#trendUp <- function(sccValues) {
    #print(sccValues)
    #coef(lm(year ~ totEmi, sccValues))['totEmi'] > 0
#}
