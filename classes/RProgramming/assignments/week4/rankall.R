rankall <- function(outcome, num = "best") {
    ## Read outcome data
    outcomeList <- list("heart attack" = 11, "heart failure" = 17, "pneumonia" = 23)
    stateColumn <- 7
    hospitalColumn <- 2
    outcomeColumn <- outcomeList[[outcome]]

    ## Check that state and outcome are valid
    if (is.null(outcomeColumn)) {
        stop("Invalid outcome")
    }

    outcomeData <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    outcomeData <- outcomeData[, c(hospitalColumn, outcomeColumn, stateColumn)]

    # once we have the columns of interest, the new column positions are:
    hospitalName <- 1
    outcomeValue <- 2
    stateColumn <- 3

    hospitalsInState <- data.frame()

    ## For each state, find the hospital of the given rank
    outcomeData[,stateColumn] <- as.factor(outcomeData[,stateColumn])
    for (state in levels(outcomeData[,stateColumn])) {
        stateData <- outcomeData[outcomeData[,stateColumn] == state,]

        if (nrow(stateData) == 0) {
            hospitalsInState <- rbind(hospitalsInState, data.frame("hospital" = NA, "state" = state))
            continue
        }

        stateData[,outcomeValue] <- as.numeric(stateData[,outcomeValue])
        stateData <- stateData[!is.na(stateData[,outcomeValue]),]
        sortedData <- stateData[order(stateData[outcomeValue], stateData[hospitalName]),]

        selectedNum <- num
        if (num == "best") {
            selectedNum <- 1
        } else if (num == "worst") {
            selectedNum <- nrow(sortedData)
        }

        hospital <- NA
        if (selectedNum > nrow(sortedData)) {
            hospital <- NA
        } else {
            hospital <- sortedData[selectedNum, hospitalName]
        }
        
        hospitalsInState <- rbind(hospitalsInState, data.frame("hospital" = hospital, "state" = state))
    }

    ## Return a data frame with the hospital names and the
    ## (abbreviated) state name
    hospitalsInState
}
