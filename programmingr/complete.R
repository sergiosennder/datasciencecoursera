if(!exists("readPollutantFile", mode="function")) {
    source(paste(getwd(),"/pollutantUtils.R", sep=""))
}

complete <- function(directory, id = 1:332) {
    
    data_frame <- data.frame(id=1:length(id), nobs=1:length(id))
    index <- 1
    for (cur_id in id) {
        file_data <- readPollutantFile(directory, cur_id)
        
        data_frame[index,"id"] <- cur_id
        data_frame[index,"nobs"] <- nrow(file_data[complete.cases(file_data),])
        
        debugPrint(paste("Monitor id = ", cur_id, sep=""), "debug")
        debugPrint(paste("Number of complete cases = ", 
                            data_frame[index,"nobs"], sep=""), "debug")
        index <- index + 1
    }
    return (data_frame)
}
    
