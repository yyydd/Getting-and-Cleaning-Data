# Getting-and-Cleaning-Data

This repository contains the following files-
1) Raw Data
2) Script run_analysis.r
3) Tidy Data 
4) Code Book

1) Raw Data

The data can be obtained from: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The full description of the data can be obtained from
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

2) Script run_analysis.R

The script run_analysis.R does the following.

	1.Merges the training and the test sets to create one data set.
		The files x_train.txt, y_train.txt and subject_train.txt from the training folder are concatenated with the files 				x_test.txt, y_test.txt and subject_test.txt from the test folder to create one dataset.
		
	2.Extracts only the measurements on the mean and standard deviation for each measurement.
		The measurements meanFreq() are not taken beacause they are the weighted average of the frequency components.
		
	3.Uses descriptive activity names to name the activities in the data set.
		The activity dataset obtained from the activity_label.txt are merged with the dataset.
		
	4.Appropriately labels the data set with descriptive variable names. 
	
	5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each 			  activity and each subject.
		The columnwise mean of each variable by each subject and each activity is obtained.The resulting tidy data (in 					wide row format) is stored in the file tidyDataSet.txt .
		
3) Tidy Data 

The tidy data is obtained in wide row format. It is obtained by running the script run_analysis.r on the raw data.

4) Code Book

The code book contains the information about the variables and the data.
	

Note 1- In order to run the script run_analysis.r successfully, please unzip the Raw Data Folder from source https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip to get a folder called UCI HAR Dataset. Make this folder the working directory.

Note 2- The script  run_analysis.r requires the package plyr. Use statement install.packages("plyr") to install it if it is not already installed.
