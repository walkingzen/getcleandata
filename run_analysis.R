#To collect, work with, and clean a data set. 
#The goal is to prepare tidy data that can be used for later analysis. 
#Data set description is available at 
#http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
library(dplyr)
dowloadandUnzipFile <- function(
  file.url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
  dest.file = "Dataset.zip" ){
  #downloading files
  download.file(url =file.url, 
                destfile = dest.file )
  unzip(dest.file, overwrite = T )
}

cleaningData <- function() {
  #reading from files and creating data frame
  x.train <- read.table("UCI HAR Dataset/train/X_train.txt")
  x.test <- read.table("UCI HAR Dataset/test/X_test.txt")
  subject.train <- read.table("UCI HAR Dataset/train/subject_train.txt")
  subject.test <- read.table("UCI HAR Dataset/test/subject_test.txt")
  y.train <- read.table("UCI HAR Dataset/train/y_train.txt")
  y.test <- read.table("UCI HAR Dataset/test/y_test.txt")
  
  #reading the details of 561 features
  features <- read.table("UCI HAR Dataset/features.txt")
  activities <- read.table("UCI HAR Dataset/activity_labels.txt")
  
  #naming the columns (Described names are given to the columns [Step 4])
  names(features) <- c("feature.id", "feature.name")
  names(x.train) <- features$feature.name
  names(x.test)  <- features$feature.name
  names(y.train)  <- c("activity")
  names(y.test)  <- c("activity")
  names(subject.train)  <- c("subject.id")
  names(subject.test)  <- c("subject.id")
  names(activities) <- c("activity.id", "activity")
  
  #retaining only the mean and std columns of train and test data [Step 2]
  x.train.req <- x.train[,features$feature.id[grep("(std|mean)", 
                                                   features$feature.name, 
                                                   ignore.case = T)]]
  x.test.req <- x.test[,features$feature.id[grep("(std|mean)", 
                                                 features$feature.name, 
                                                 ignore.case = T)]]
  
  #binding the subject and activity with mean and std of features
  train <- cbind(subject.train,y.train, x.train.req )
  test <- cbind(subject.test, y.test, x.test.req)
  
  #merging train and test data [Step 1]
  #merged after removing not required data
  required.data <- rbind(train, test)
  
  #Uses descriptive activity names to name the activities in the data set [Step 3]
  required.data$activity <- sapply(required.data$activity, 
                                   function(x) {
                                     activities$activity[
                                       activities$activity.id == x]})
  return(required.data)
}

tidyAverageData <- function(data) {
  # Creates independent tidy data set with the average of each variable for each
  # activity and each subject. (Step 5)
  result  <- data %>%
    group_by(subject.id,activity) %>%
    summarise_each(funs(mean))
  write.table(result , file = "tidydata.txt", row.names = F)
  result
}

#calling examples
#data <- cleaningData()
#tidy.data <- tidyAverageData(data)
