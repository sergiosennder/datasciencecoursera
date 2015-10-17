corr <- function(directory, threshold = 0) {
    
    files <- list.files(path=directory, pattern="*.csv", full.names=TRUE)
    
    debugPrint(paste("Threshold = ", threshold, sep=""), "info")
    debugPrint(files, "debug")
    
    tmp_correlations <- c(1:length(files))
    index <- 1
    
    for (cur_file in files) {
        file_data <- read.csv(cur_file)
        
        file_data <- file_data[complete.cases(file_data),]
        num_complete <- nrow(file_data)
        debugPrint(paste("Number of complete cases = ", num_complete, sep=""), 
                    "info")
        
        if (num_complete >= threshold) {
           nitrate_data <- select(file_data, matches("nitrate"))
           debugPrint("Nitrate data", "debug")
           debugPrint(nitrate_data, "debug")

            sulfate_data <- select(file_data, matches("sulfate"))
            debugPrint("Sulfate data", "debug")
            debugPrint(sulfate_data, "debug")
            
            tmp_correlations[index] <- cor(nitrate_data, sulfate_data)
            debugPrint(paste("Correlation = ", correlations[index], sep=""), 
                       "info")            
            index <- index + 1
            
        }
        correlations <- tmp_correlations[1:(index-1)]
    }
    return (correlations)
}
