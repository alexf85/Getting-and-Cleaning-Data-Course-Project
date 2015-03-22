## Introduction

Aggregation script for 'Human Activity Recognition Using Smartphones Dataset'.
Script performs the fllowing steps:
<ol>
<li>Merges the training and the test sets to create one data set.</li>
<li>Extracts only the measurements on the mean and standard deviation for each measurement.</li>
<li>Uses descriptive activity names to name the activities in the data set.</li>
<li>Appropriately labels the data set with descriptive variable names.</li>
<li>From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.</li>
<li>The output file name is 'average-tidy.txt'</li>
</ol>

## Usage

This script should be run from the working directory without any parameters. 
It is assumed that the following files are present
* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels.

## Output

File 'average-tidy.txt'contains the average of each variable for each activity and each subject.
