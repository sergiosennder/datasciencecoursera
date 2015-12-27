require("dplyr", warn.conflicts=FALSE, quietly=TRUE)
require("data.table", warn.conflicts=FALSE, quietly=TRUE)
require("plyr", warn.conflicts=FALSE, quietly=TRUE)
require("reshape2", warn.conflicts=FALSE, quietly=TRUE)

extendedDataSet <- function(dataSetFile, activityFile, subjectFile) {
    return (cbind(read.table(subjectFile), read.table(activityFile), 
                    read.table(dataSetFile)))
}

# Append the subject ID and Activity ID columns to each 'test' and 'train' read-in
# data files, then append the 'train' file to the end of the 'test' file
mergedData <- rbind (
    extendedDataSet("./test/X_test.txt", "./test/y_test.txt", "./test/subject_test.txt"),
    extendedDataSet("./train/X_train.txt", "./train/y_train.txt", "./train/subject_train.txt")
)

# Read the column variable labels and add labels for the subject and activity IDs
dataLabels <- read.table("./features.txt")
dataLabels <- c("Subject_ID", "Activity_ID", as.vector(dataLabels[,2]))
names(mergedData) <- dataLabels

# grab only the column variable labels that contain standard deviation (i.e. 'std()')
# and mean (i.e. 'mean()') data, then re-append the subject and activity ID labels
indexesOfLabelsOfInterest <- grep("(std\\(\\)|mean\\(\\))", dataLabels)
labelsOfInterest <- c("Subject_ID", "Activity_ID", dataLabels[indexesOfLabelsOfInterest])
mergedData <- subset(mergedData, select = labelsOfInterest)

# read the activity labels, and name the columns so that a join can be performed
# between the Activity labels and the Activity IDs as the labels get merged into the
# tidy data
activityLabels <- read.table("./activity_labels.txt")
names(activityLabels) <- c("Activity_ID", "Activity")
mergedData <- merge(activityLabels, mergedData, by="Activity_ID")

# remove the Activity ID column now that the Activity labels are merged;
# simultaneously rearrange columns so that the subject ID column (i.e. column 3)
# comes before the Activity labels (i.e. column 2)
mergedData <- mergedData[,c(3,2,4:ncol(mergedData))]

# order the data to group together by subject ID
mergedData <- mergedData[order(mergedData$Subject_ID),]

# write the tidy data to file
write.table(mergedData, file="./tidyDataSet.txt", row.name=FALSE, sep = "\t")

# reorder the data so that it is grouped by subject, activity, and variable name.
meltedData <- melt(mergedData, id.vars=c("Subject_ID", "Activity"))

# find the mean of each subject, activity, and variable grouping
tidyMeans <- ddply(meltedData, c("Subject_ID", "Activity", "variable"), summarise, 
                    mean = mean(value))

# write the tidy averages to file
write.table(tidyMeans, file="./tidyAverages.txt", row.name=FALSE, sep = "\t")

