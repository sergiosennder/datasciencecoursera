readPollutantFile <- function(directory, id) {
    # generate file path by reading the file number (e.g. "23"),
    # splitting the number into characters (e.g. "2", "3"), 
    # appending front-end zeroes (e.g. "0", "0", "2", "3"), 
    # and utilizing last three chars for file path name (e.g. "023").
    adjusted_id <- strsplit(as.character(id), split=vector(length=0))[[1]]
    adjusted_id <- tail(c("0", "0", adjusted_id), 3)
    id_str <- gsub(", ", "", toString(adjusted_id))
    pollutant_file <- paste(directory,"/",id_str,".csv", sep="")
    debugPrint(paste("Reading ",pollutant_file, sep=""), "info")
    
    file_data <- read.csv(pollutant_file)
}


debug_level <- "none"
debug_levels <- list(none=0, error=1, warning=2, info=3, debug=4)

debugPrint <- function(str, level="debug") {
    
    if (level == "none") return
    if (debug_levels[[level]] <= debug_levels[[debug_level]]) {
        print(str)
    }
}
