##-----------------------------------------------------------------------------------------------------------------------------------------------------
## Getting and Cleanning Data - DataScience Specialization Coursera
## Course Project 
## Elena Cruz Martin, 2015-06-17
##-----------------------------------------------------------------------------------------------------------------------------------------------------
## This script performs the data loading, merging and cleaning in order to obtain the tidy dataset which fulfills the 
## project's requirements. This script will run as long as the Samsung data is in your working directory (and unzipped)
## As requested, the script will: 
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
##-----------------------------------------------------------------------------------------------------------------------------------------------------
## For more information about this tidying process, please check the README.md and the CodeBook.md files in my project repository:
## https://github.com/ElenaCruz/GettingAndCleaningData
##-----------------------------------------------------------------------------------------------------------------------------------------------------

## Configuration data (folder names, tags for each folder...)
folderName <- "UCI HAR Dataset"
trainTag <- "train"
testTag <- "test"

##We use patterns in order to build the strings with the names of the files, so we don't have to write long code strings
subjFilePattern <-"subject_%s.txt"
xFilePattern <- "X_%s.txt"
yFilePattern <- "y_%s.txt"

##Training set data loading
## 1. Read subject data
trSubjData <- read.table(file.path(folderName, trainTag, sprintf(subjFilePattern,trainTag)))
## 2. Read data set
trXData <- read.table(file.path(folderName, trainTag, sprintf(xFilePattern,trainTag)))
## 3. Read labels
trYData <- read.table(file.path(folderName, trainTag, sprintf(yFilePattern,trainTag)))

##Training dataframe composition
trData <- cbind(trSubjData,trXData,trYData)

##Test set data loading
## 1. Read subject data
teSubjData <- read.table(file.path(folderName, testTag, sprintf(subjFilePattern,testTag)))
## 2. Read data set
teXData <- read.table(file.path(folderName, testTag, sprintf(xFilePattern,testTag)))
## 3. Read labels
teYData <- read.table(file.path(folderName, testTag, sprintf(yFilePattern,testTag)))

##Test dataframe composition
teData <- cbind(teSubjData,teXData,teYData)
