#


## load libraries
library(data.table)



## load required files into data.frame
test.x <- read.table("UCI HAR Dataset/test/x_test.txt", encoding="utf-8")
test.y <- read.table("UCI HAR Dataset/test/y_test.txt", encoding="utf-8")
test.subject <- read.table("UCI HAR Dataset/test/subject_test.txt", encoding="utf-8")

train.x <- read.table("UCI HAR Dataset/train/x_train.txt", encoding="utf-8")
train.y <- read.table("UCI HAR Dataset/train/y_train.txt", encoding="utf-8")
train.subject <- read.table("UCI HAR Dataset/train/subject_train.txt", encoding="utf-8")

features <- read.table("UCI HAR Dataset/features.txt")
activities <- read.table("UCI HAR Dataset/activity_labels.txt", encoding="utf-8")

## merging data together into single data.frame
test <- cbind(test.x, test.y, test.subject)
train <- cbind(train.x, train.y, train.subject)
data <- rbind(test, train)

columnNames <- c(as.vector(features$V2), "Subject", "Activity")
colnames(data) <- columnNames


## exluding not mean or std
tmp <- grep("-mean()", columnNames, fixed = TRUE)
tmp1 <- grep("-std()", columnNames, fixed = TRUE)
tmp11 <- grep("Subject",columnNames, fixed = TRUE)
tmp111 <- grep("Activity",columnNames, fixed = TRUE)
tmp2 <- sort(c(tmp, tmp1, tmp11, tmp111))
newData <- data[, tmp2]

## merging with activities names
newData1 <- merge(newData, activities, by.x="Activity", by.y="V1")
### removing duplicated column
newData1 <- newData1[,-grep("Activity", colnames(newData1), fixed = TRUE)]
tmpCN <- colnames(newData1)
tmpCN[grep("V2", tmpCN)] = "Activity"
colnames(newData1) <- tmpCN

## preparing data for aggregate
Subject <- newData1$Subject
Activity <- newData1$Activity
newData2 <- newData1[,-which(names(newData1) == "Subject")]
newData2 <- newData2[,-which(names(newData1) == "Subject")]

## aggregate data
tmpData <- aggregate(newData2, by = list(Subject, Activity), FUN=mean)

### column names
names(tmpData)[names(tmpData) == "Group.1"] <- "Subject"
names(tmpData)[names(tmpData) == "Group.2"] <- "Activity"

### writing to file
write.table(tmpData, file="result.txt", row.names=FALSE)



