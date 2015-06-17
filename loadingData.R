# load data into variables

test.x <- read.table("data/test/x_test.txt", encoding="utf-8")
test.y <- read.table("data/test/y_test.txt", encoding="utf-8")
test.subject <- read.table("data/test/subject_test.txt", encoding="utf-8")

test <- cbind(test.x, test.y, test.subject)

train.x <- read.table("data/train/x_train.txt", encoding="utf-8")
train.y <- read.table("data/train/y_train.txt", encoding="utf-8")
train.subject <- read.table("data/train/subject_train.txt", encoding="utf-8")

train <- cbind(train.x, train.y, train.subject)

data <- rbind(test, train)

features <- read.table("data/features.txt")
columnNames <- c(as.vector(features$V2), "Subject", "Activity")
colnames(data) <- columnNames

tmp <- grep("-mean()", columnNames, fixed = TRUE)
tmp1 <- grep("-std()", columnNames, fixed = TRUE)
tmp11 <- grep("Subject",columnNames, fixed = TRUE)
tmp111 <- grep("Activity",columnNames, fixed = TRUE)

tmp2 <- sort(c(tmp, tmp1, tmp11, tmp111))

activities <- read.table("data/activity_labels.txt", encoding="utf-8")

newData <- data[, tmp2]

newData1 <- merge(newData, activities, by.x="Activity", by.y="V1")
newData1 <- newData1[,-grep("Activity", colnames(newData1), fixed = TRUE)]
tmpCN <- colnames(newData1)
tmpCN[grep("V2", tmpCN)] = "Activity"


Subject <- newData1$Subject
Activity <- newData1$Activity
newData2 <- newData1[,-which(names(newData1) == "Subject")]
newData2 <- newData2[,-which(names(newData1) == "Subject")]

tmpData <- aggregate(newData2, by = list(Subject, Activity), FUN=mean)

write.table(tmpData, file="result.txt", row.names=FALSE)

names(tmpData)[names(tmpData) == "Group.1"] <- "Subject"
names(tmpData)[names(tmpData) == "Group.2"] <- "Activity"
write.table(tmpData, file="result.txt", row.names=FALSE)


library(data.table)
