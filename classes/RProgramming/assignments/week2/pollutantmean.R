pollutantmean <- function(directory, pollutant, id = 1:332) {
    allObservations <- numeric()
    files <- list.files(directory, full.names = T)
    selectedFiles <- files[id]
    for(file in selectedFiles) {
        observations <- read.csv(file, comment.char = "")
        allObservations <- c(allObservations, observations[[pollutant]])
    }

    mean(allObservations, na.rm = T)
}

#pollutantmean("specdata", "sulfate", 1:30)
#pollutantmean("specdata", "nitrate", 2:30)
