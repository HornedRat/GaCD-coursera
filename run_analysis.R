library(dplyr)
library(data.table)

#reads data into separate objects
as.data.table(fread("./UCI HAR Dataset/train/X_train.txt")) -> train.data
as.data.table(fread("./UCI HAR Dataset/train/y_train.txt")) -> train.activities
as.data.table(fread("./UCI HAR Dataset/train/subject_train.txt")) -> train.subjects
as.data.table(fread("./UCI HAR Dataset/test/X_test.txt")) -> test.data
as.data.table(fread("./UCI HAR Dataset/test/y_test.txt")) -> test.activities
as.data.table(fread("./UCI HAR Dataset/test/subject_test.txt")) -> test.subjects

read.table("./UCI HAR Dataset/features.txt", stringsAsFactors = F) -> var.labels
read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors = F) -> activity.labels

#merges the data into separate data tables for train and test, 
train.dt <- cbind(train.subjects, train.activities, train.data)
test.dt <- cbind(test.subjects, test.activities, test.data)

#merging into one data table
all.dt <- rbind(train.dt, test.dt)

#giving proper names to the columns
names(all.dt) <- c("subject", "activity", var.labels[,2])

#recodes the activities as a factor with proper labels
all.dt[,activity:=as.factor(activity)]
levels(all.dt$activity) <- activity.labels[,2]

#select the columns with mean() or std(), plus the subject and activity columns
cols <- grep("mean\\()|std\\()", names(all.dt), ignore.case = T)
dataset.dt <- all.dt[, c(1:2, cols), with = F]

#removes the objects, that will no longer be used to free memory
rm(activity.labels, test.activities, test.data, test.dt, test.subjects,
   train.activities, train.data, train.dt, train.subjects, var.labels, cols, all.dt)

#creates summary of all variables by subject and activity
sub.acc.summary <- dataset.dt %>%
    group_by(subject, activity) %>% summarise_all(mean)

#writes the output table to working directory
write.table(sub.acc.summary, file = "data.txt", row.names = F)
