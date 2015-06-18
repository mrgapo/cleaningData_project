# Coursera course Cleaning Data assignment
### Description
This script "run_analysis.R" solve the project for Coursera Cleaning Data project assigment.
It does: 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



### Prerequisites
At first you need to have samsung data and extract them to **folder "UCI HAR Dataset"** in R working directory.
Define libraries are also needed:

 - data.table
 
### How to run
enter 
**source("run_analysis.R")**
in console

### Result
Script will create new file "result.txt" where it will store result 
