complete <- function(directory, id = 1:332) {
    record <- data.frame()
    files <- list.files(directory, full.names = T)

    #selectedFiles <- files[id]
    #for(file in selectedFiles) {

    for(monitor in id) {
        observations <- read.csv(files[monitor], comment.char="")
        completeCases <- complete.cases(observations)
        record <- rbind(record, data.frame(id = monitor, nobs= nrow(observations[completeCases,])))
    }    

    record
}

#complete("specdata", c(2, 4, 8, 10, 12))
#complete("specdata", 1:20)
