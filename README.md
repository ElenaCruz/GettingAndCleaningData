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

*Note: how to read the tidy dataset:*
As David Hood points out in his excellent 'David's personal course project FAQ' in the Course forum, the tidy data can't be read 'as is' using notepad or a similar text editor. Thus, if you want to read the resulting txt file please use this code: 

`data <- read.table(file_path, header = TRUE) #if they used some other way of saving the file than a default write.table, this step will be different
View(data)`

##Steps that have been followed:
1. **STEP 0:** Retrieve raw data in a good shape, so we can merge files later. This has been achieved by loading the three .txt files for each subset (train and test) of data, so they can be joined later in the following steps. Inertial folder will be ignored as, in the end, they're not related to the mean or the standard deviation we want to obtain.
 1. The first step has been to define a set of 'configuration data', that is, folder names, and file names to be used as part of the file retrieving process
 2. I have also defined a set of patterns that have been used to reuse code to load the train and tests subsets
 3. I have retrieved the names of the features from the 'features.txt' file, and used them to compose the names for the datasets. These names have been processed to get syntactically correct values, using `make.names`
 4. I've loaded the training data, by loading the subject, X and Y files and then joining them with `cbind`. In order to have a clear dataset, I've also used the named retrieved in step 0.3 for the dataframe
 5. I've loaded the test data, by following the same process indicated in step 0.4
2. **STEP 1:** Merge the training and the test sets to create one data set.  This has been achieved by using `rbind` with the two datasets obtained in step 0, since this is the appropriate way of joining the 561+2 columns of the data (the 2 extra columns are the Subject and Activity ones.
3. **STEP 2:** Extract only the measurements on the mean and standard deviation for each measurement. I've used here `grep`, so I can define patterns to get only the mean and std values. I've considered only those columns which had mean and std data as part of their names, discarding the meanFreq values.
 1. Filter the names in order to get the mean and std valid column names
 2. Build a selected names vector in order to have all the column names we are going to keep (including Subject and Activity)
 3. Get only the selected data, by subsetting in the complete dataset usign the selected column names
4. **STEP 3:** Use descriptive activity names to name the activities in the data set. To achieve this, I have:
 1. Retrieve activities' names (using the same names as in the original dataset)
 2. Change to factors and use the activity names as labels (see Ray Jones' comment on the 'How to apply activity labels?" thread in the forum for more details on how to do this)
5. **STEP 4:** Appropriately label the data set with descriptive variable names. This step has been partially done as part of the extracting only the mean and std measures process ((step 2)), as I was more comfortable working with column names rather than numbers. The names are in a 'syntactically correct' form, so they can be used for selecting, etc. Thus, I'll only remove the "..." and ".." from the names, in order to have a cleaner set of names. This has been done using `gsub`
6. **STEP 5:** From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject. For this last step, I've chained a `group_by`, to group the filtered data set by Subject and Activity with a `summarise_each`operation, available in the dplyr package, which allows summarizing several columns. The function I've used to summarize is `mean`, so I can calculate the average of each variable as requested.

Finally, I've written the tidy dataset to a .txt file, usign row.name=FALSE, so the file is written as required.
 

