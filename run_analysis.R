##-----------------------------------------------------------------------------------------------------------------------------------------------------
## Getting and Cleanning Data - DataScience Specialization Coursera
## Course Project 
## Elena Cruz Martin, 2015-06-17
##-----------------------------------------------------------------------------------------------------------------------------------------------------
## This script performs the data loading, merging and cleaning in order to obtain the tidy dataset which fulfills the 
## project's requirements. This script will run as long as the Samsung data is in your working directory (and unzipped)
## As requested, the script will: 
## 1. Merge the training and the test sets to create one data set.
## 2. Extract only the measurements on the mean and standard deviation for each measurement. 
## 3. Use descriptive activity names to name the activities in the data set
## 4. Appropriately label the data set with descriptive variable names. 
## 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
##-----------------------------------------------------------------------------------------------------------------------------------------------------
## For more information about this tidying process, please check the README.md and the CodeBook.md files in my project repository:
## https://github.com/ElenaCruz/GettingAndCleaningData
##-----------------------------------------------------------------------------------------------------------------------------------------------------

library(dplyr)

## STEP 0: Retrieve raw data in a good shape, so we can merge files later
## Configuration data (folder names, tags for each folder...)
folderName <- "UCI HAR Dataset"
trainTag <- "train"
testTag <- "test"
featuresFile <- "features.txt"
activitiesFile <-"activity_labels.txt"

##We use patterns in order to build the strings with the names of the files, so we don't have to write long code strings
subjFilePattern <-"subject_%s.txt"
xFilePattern <- "X_%s.txt"
yFilePattern <- "y_%s.txt"

##Retrieve features' names
ftNames <- read.table(file.path(folderName,featuresFile))

##Compose names for the datasets
namesV <- c("Subject","Activity", sapply(ftNames$V2,as.character))
namesV <- make.names(namesV) ##Get syntactically correct names

##Training set data loading
## 1. Read subject data
trSubjData <- read.table(file.path(folderName, trainTag, sprintf(subjFilePattern,trainTag)))
## 2. Read data set
trXData <- read.table(file.path(folderName, trainTag, sprintf(xFilePattern,trainTag)))
## 3. Read labels
trYData <- read.table(file.path(folderName, trainTag, sprintf(yFilePattern,trainTag)))

##Training dataframe composition  (subject, activity, all other variables)
trData <- cbind(trSubjData,trYData, trXData)
names(trData) <- namesV

##Test set data loading
## 1. Read subject data
teSubjData <- read.table(file.path(folderName, testTag, sprintf(subjFilePattern,testTag)))
## 2. Read data set
teXData <- read.table(file.path(folderName, testTag, sprintf(xFilePattern,testTag)))
## 3. Read labels
teYData <- read.table(file.path(folderName, testTag, sprintf(yFilePattern,testTag)))

##Test dataframe composition (subject, activity, all other variables)
teData <- cbind(teSubjData,teYData, teXData)
names(teData) <- namesV

## STEP 1: Merge the training and the test sets to create one data set
globalData <- rbind(trData, teData)

##STEP 2: Extract only the measurements on the mean and standard deviation for each measurement
meanCols <- grep("mean\\.",namesV) ##Get the column indexes containing "mean", case sensitive, using the '.' char to remove the meanFreq values
stdCols <- grep("std\\.", namesV) ##Get the column indexes containing "std", case sensitive
selectedCols <- c("Subject","Activity", namesV[sort(c(meanCols,stdCols))]) ##Build a vector with the names of the columns we want to keep (maintaining original order)
filteredData <- globalData[selectedCols]

##STEP 3: Use descriptive activity names to name the activities in the data set
##Retrieve activities' names (using the same names as in the original dataset)
acNames <- read.table(file.path(folderName,activitiesFile))
acNames <- sapply(acNames$V2,as.character)
##Change to factors and use the acNames as labels
## (see Ray Jones' comment on the 'How to apply activity labels?" thread in the forum for more details on how to do this)
filteredData[ ,"Activity"] <- factor(filteredData[ ,"Activity"], labels =acNames) 

##STEP 4: Appropriately label the data set with descriptive variable names.
##This step has been partially done as part of the extracting only the mean and std measures, as I was more comfortable working with column names 
##rather than numbers. The names are in a 'syntactically correct' form, so they can be used for selecting, etc. Thus, I'll only remove the "..." and ".." 
names(filteredData) <- gsub("\\.\\.\\.","",names(filteredData))
names(filteredData) <- gsub("\\.\\.","",names(filteredData))

##STEP 5:From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
bySubAct <- filteredData %>% group_by(Subject, Activity) ##Group filtered data by subject and activity
tidyData <- bySubAct %>% summarise_each(funs(mean)) ##Apply summarise_each to work with the whole set of columns

write.table(tidyData,file="tidyDataset.txt",row.name=FALSE)
 