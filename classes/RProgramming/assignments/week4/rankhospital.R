rankhospital <- function(state, outcome, num) {
    outcomeList <- list("heart attack" = 11, "heart failure" = 17, "pneumonia" = 23)
    stateColumn <- 7
    hospitalColumn <- 2
    outcomeColumn <- outcomeList[[outcome]]

    columnsOfInterest <- c(hospitalColumn, outcomeColumn)

    if (is.null(outcomeColumn)) {
        stop("Invalid outcome")
    }

    outcomeData <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

    stateData <- outcomeData[outcomeData[,stateColumn] == state, columnsOfInterest]

    # TODO validate that the state provided is valid.
    # nrows == 0 -> error?
    if (nrow(stateData) == 0) {
        stop("invalid state")
    }

    # once stateData subset is defined the new columns positions are:
    hospitalName <- 1
    outcomeValue <- 2

    stateData[,outcomeValue] <- as.numeric(stateData[,outcomeValue])
    stateData <- stateData[!is.na(stateData[,2]),]
    sortedData <- stateData[order(stateData[outcomeValue], stateData[hospitalName]),]

    if (num == "best") {
        num = 1
    } else if (num == "worst") {
        num = nrow(sortedData)
    }

    if (num > nrow(sortedData)) {
        return(NA)
    }

    return(sortedData[num, hospitalName])
}

#best("TX", "heart attack")
#best("TX", "heart failure")
#best("MD", "heart attack")
#best("MD", "pneumonia")
#best("NY", "hert attack")
#best("BB", "heart attack")

