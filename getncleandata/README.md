# Instructions to Run 'run_Analysis.R'
## Input
* 'activity_labels.txt'
 * Contains the activity labels
 * Should be in the same directory as the script
* 'features.txt'
 * Contains the column variable labels
 * Should be in the same directory as the script
* 'subject_test.txt'
 * Contains the ids for the subjects that performed the activities, one per row
 * File should be in a 'test' directory under script location
* 'X_test.txt'
 * Contains the raw data for the test set
 * File should be in a 'test' directory under script location
* 'y_test.txt'
 * Contains the ids for Activities performed, one per row, match labels in 'activity_labels.txt'
 * File should be in a 'test' directory under script location
* 'subject_train.txt'
 * Contains the ids for the subjects that performed the activities, one per row
 * File should be in a 'train' directory under script location
* 'X_train.txt'
 * Contains the raw data for the training set
 * File should be in a 'train' directory under script location
* 'y_train.txt'
 * Contains the ids for Activities performed, one per row, match labels in 'activity_labels.txt'
 * File should be in a 'train' directory under script location

## Output
* 'tidyDataSet.txt'
 * Contains the tidy data
 * Found in the same directory as the script
* 'tidyAverages.txt'
 * Contains the calculated averages for Subject ID, Activity, and Variable name combinations.
 * Found in the same directory as the script

## Steps
1. Place input files according to 'Input' section
2. Run run_Analysis.R
3. Ouput will be generated according to 'Output' section

## High Level Description of Script
1. The script reads and concatenates the files in the 'test' directory so that the subject id and activity id columns are appended to the data. The same operation is executed to the files in the 'train' directory.
2. The resulting enriched 'train' data.frame is appended to the bottom of the enriched 'test' data.frame.
3. The column variable labels are read-in and inserted into the tidy data.frame
4. Columns of interest are evaluated (i.e. those that contain standard deviation of mean information) and the tidy data.frame is trimmed to contain only columns of interest.
5. The activity labels are read-in and merged via a join into the tidy data.frame.
6. The tidy data.frame's activity id column is removed, and the data.frame column and row orderings are rearranged for improved tidiness.
7. The tidy data.frame is written to file as tidyDataSet.txt
8. The tidy data.frame is 'melted' so that each row represents a Subject ID, Activity, and Variable combination.
9. The melted data.frame is sliced and diced into sub data.frames based on Subject ID and Activity combinations with same variable name groupings and the average calculation is applied to each sub data.frame. 
10. The result is written to the 'tidyAverages.txt' file


# Code Book
NOTE: It is not very clear what exactly I should have here since generally the code book will contain a list of sampled variable 
information, which in this case was captured in the raw data code book. Consequently I'll address the output variables in the tidy files.
## File 'tidyDataSet.txt'
* variable: 'Subject_ID'
* variable type: integer
* allowable values: 1-30 
* description: Unique IDs for test subjects

* variable: 'Activity'
* variable type: string
* allowable values: those found in the file 'activity_labels.txt'
* description: activities executed by subjects under test

* variables: list found in 'features.txt', but only ones that capture standard deviation (contain 'std()') or mean (contain 'mean()')
* variable type: string
* allowable values: those found in 'features.txt' that contain 'std()' or 'mean()'.
* description: experiment results 

## File 'tidyAverages.txt'
* variable: 'Subject_ID'
* variable type: integer
* allowable values: 1-30 
* description: Unique IDs for test subjects

* variable: 'Activity'
* variable type: string
* allowable values: those found in the file 'activity_labels.txt'
* description: activities executed by subjects under test

* variable: 'variable'
* variable type: string
* allowable values: list found in 'features.txt', but only ones that capture standard deviation (contain 'std()') or mean (contain 'mean()')
* description: variables whose mean was calculated

* variable: 'mean'
* variable type: number
* allowable values: double
* description: calculated means for Subject_ID/Activity/<variable> combinations




