# Extracts only the measurements on the mean and standard deviation 
# for each measurement from experiment 'dataKind'. 
readData <- function(dataKind)
{
    measures <- read.table(paste(dataKind, "/X_", dataKind, ".txt", sep = ""));
    activity <- read.table(paste(dataKind, "/y_", dataKind, ".txt", sep = ""));
    subjects <- read.table(paste(dataKind, "/subject_", dataKind ,".txt", sep = ""));
    observationsNum <- nrow(measures)

    if (observationsNum != nrow(subjects))
        stop("number of measures does not match number of subjects")
    if (observationsNum != nrow(activity))
        stop("number of measures does not match number of activities")
    
    # get descriptive column names for features
    colNames <- read.table("features.txt")[,2]
    
    # give activities descriptive names
    activityLabels <- read.table("activity_labels.txt")
    activity[,1] <- sapply(X=activity[,1], 
                           FUN = function(x) {activityLabels[activityLabels == x, 2]})
    
    rowNames <- paste(dataKind, 1:observationsNum, sep="-")
    
    # Use descriptive activity names to name the activities in the data set
    colnames(activity) <- "Activity"
    colnames(subjects) <- "Subject"
    colnames(measures) <- colNames 
    
    # merge data
    colFilter <- grepl("\\-(mean|std)\\(\\)\\-", colNames)
    result <- cbind(subjects, activity, measures[, colFilter])
    rownames(result) <- rowNames # label the data set with descriptive variable names. 
    result
}

# Merge the training and the test sets to create one data set.
testData <- readData("test")
trainData <- readData("train")
# data is the tidy data
data <- rbind(testData, trainData)

# create subset with the average of each variable for each activity and each subject.
subset <- expand.grid(unique(data$Subject), unique(data$Activity))
subset <- subset[order(subset[1], subset[2]), ] # order by the subject id for convenience
print(subset)
for (i in 1:nrow(subset))
{
    subject <- subset[i, 1]
    activity <- subset[i, 2]
    frame <- data[(data$Subject == subject) & (data$Activity == activity), ]
    for (j in 3:ncol(data))
        subset[i,j] = mean(frame[,j])
}
colnames(subset)<-colnames(data)

# form final output
write.table(x = subset, file = "average-tidy.txt", row.names = F) 
