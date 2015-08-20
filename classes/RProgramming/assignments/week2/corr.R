corr <- function(directory, threshold = 0) {
    completeSets <- complete(directory, 1:332)
    setsAboveThreshold <- completeSets[which(completeSets[,"nobs"] > threshold), "id"]
    files <- list.files(directory, full.names = T)

    correlations <- numeric()
    for (file in files[setsAboveThreshold]) {
        set <- read.csv(file, comment.char = "")
        completeCases <- which(complete.cases(set))

        sulfate <- set[completeCases, "sulfate"]
        nitrate <- set[completeCases, "nitrate"]

        correlations <- c(correlations, cor(sulfate, nitrate))
    }

    correlations
}

#https://d396qusza40orc.cloudfront.net/rprog%2Fdoc%2Fcorr-demo.html
#cr <- corr("specdata", 150)
#head(cr)
#summary(cr)
