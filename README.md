# GettingAndCleaningData
Repository containing my Getting and Cleaning Data Course Project for the Coursera specialization. 

This README.md file explains how the script(s) work and how they are connected

The repository includes the following files:

**CodeBook.md**
Markdown file containing thecode book that describes the variables, the data, and any transformations or work that I've performed to clean up the data

**run_analysis.R**
This R script will perform the following tasks (as indicated in the course project description)

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
 
**tidyDataset.txt**
Project result, tidy data set with the average of each variable for each activity and each subject, as indicated in the project description.

##How to the tidy dataset:
As David Hood points out in his excellent 'David's personal course project FAQ' in the Course forum, the tidy data can't be read 'as is' using notepad or a similar text editor. Thus, if you want to read the resulting txt file please use this code: 

`data <- read.table(file_path, header = TRUE) #if they used some other way of saving the file than a default write.table, this step will be different
View(data)`
