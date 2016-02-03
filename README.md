# Getting and Cleaning Data Course Prjoject
As a part of Getting and Cleaning Data Course Project from John Hopkins University via Coursera

Performs the following operations in run_analysis.R
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names.
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

There are three functions in the file
* dowloadandUnzipFile : is a wrapper for download file and unzip functions. takes two parameters such as file.url and destination.file .
* cleaningData: It performs first 4 steps of the project mentioned above. It uses the folder unzipped by the dowloadandUnzipFile function
* tidyAverageData: Creates independent tidy data set with the average of each variable for each activity and each subject.It uses the cleaned data created by cleaningData function
