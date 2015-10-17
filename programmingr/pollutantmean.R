require("dplyr", warn.conflicts=FALSE, quietly=TRUE)
if(!exists("readPollutantFile", mode="function")) {
    source(paste(getwd(),"/pollutantUtils.R", sep=""))
}

pollutantmean <- function(directory, pollutant, id = 1:332) {
    #====== calculatePollutantMean =========================================
    calculatePollutantMean <- function(directory, pollutant, id) {

        file_data <- readPollutantFile(directory, id)
        pollutant_data <- select(file_data, matches(pollutant))
        pollutant_data <- pollutant_data[!is.na(pollutant_data)]
        sum_n_rows <- c(0,0)
        sum_n_rows[1] <- sum(pollutant_data)
        sum_n_rows[2] <- length(pollutant_data)
        debugPrint(paste("file sum = ", sum_n_rows[1], sep=""))
        debugPrint(paste("file num of rows = ", sum_n_rows[2], sep=""))
        return (sum_n_rows)
    }
    
    #====== pollutantmean =========================================
    # Loop through all files specified in 'id', calculate mean for each
    # file/pollutant, and add means to total mean_sum.
    sum_n_rows <- c(0, 0)

    for (cur_id in id) {
       sum_n_rows <- sum_n_rows + 
           calculatePollutantMean(directory, pollutant, cur_id)
       debugPrint(paste("Accumulated sum = ", sum_n_rows[1], sep=""))
       debugPrint(paste("Accumulated num of rows = ", sum_n_rows[2], sep=""))
    }
    
    mean <- sum_n_rows[1] / sum_n_rows[2]
    debugPrint(paste("final sum = ", sum_n_rows[1], sep=""))
    debugPrint(paste("final number of rows = ", sum_n_rows[2], sep=""))
    debugPrint(paste("mean = ", mean, sep=""))
    return(mean)
}
