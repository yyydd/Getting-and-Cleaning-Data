#### This script assumes that your working directory is set to the folder containing the Samsung data ( the working 
#### directory is the folder "UCI HAR Dataset")

#########################################################################################################################################

### 1. The below section of code merges the training data and the test data to create the final data set.

# Reads feature names and activity labels
features     = read.table('./features.txt',header=FALSE); #imports features.txt
activityType = read.table('./activity_labels.txt',header=FALSE); #imports activity_labels.txt


# Reads data from Train Folder
xTrain       = read.table('train/x_train.txt',header=FALSE); #reads x_train.txt
yTrain       = read.table('train/y_train.txt',header=FALSE); #reads y_train.txt
subjectTrain = read.table('train/subject_train.txt',header=FALSE); #imports subject_train.txt

# Assigns column Names 
colnames(activityType)  = c('ActivityId','Activity');
colnames(subjectTrain)  = "subjectId";
colnames(xTrain)        = features[,2]; 
colnames(yTrain)        = "ActivityId";


# Combines data from Train Folder
trainingData = cbind(yTrain,subjectTrain,xTrain);


# Reads data from the test folder
xTest        = read.table('test/x_test.txt',header=FALSE); #reads x_test.txt
yTest        = read.table('test/y_test.txt',header=FALSE); #impreadsorts y_test.txt
subjectTest  = read.table('test/subject_test.txt',header=FALSE); #reads subject_test.txt

# Assigns column Names 
colnames(subjectTest) = "subjectId";
colnames(xTest)       = features[,2]; 
colnames(yTest)       = "ActivityId";

# Combines data from the Test Folder
testData = cbind(yTest,subjectTest,xTest);




# Combines the training and the test data to create final data set
finalData = rbind(trainingData,testData);


#################################################################################################################################################


### 2.Extracts only the measurements on the mean and standard deviation for each measurement.

# "Colnames" contains all the column names of the "finalData" data set
colNames  = colnames(finalData);

# "featuresWanted" is a logical vector which contains TRUE values for the ID, mean & stddev columns and FALSE for others
featuresWanted = (grepl("Activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames)  | grepl("-std..",colNames))&  !grepl("-meanFreq..",colNames);

# Removes the  unwanted featues from "finalData"
finalData = finalData[featuresWanted==TRUE];


#################################################################################################################################################


### 3.Uses descriptive activity names to name the activities in the data set

# Merges the "finalData" with the "activityType" data set
finalData = merge(finalData,activityType,by='ActivityId',all.x=TRUE,sort=FALSE);

# Removes the column activity Id
finalData <- subset(finalData, select = -c(ActivityId) );

 
##################################################################################################################################################

### 4.Appropriately labels the data set with descriptive variable names. 

#Assigns column names of "finalData" to vector "colNames"
colNames=colnames(finalData);

#Assigns meaningful names
for (i in 1:length(colNames)) 
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev ",colNames[i])
  colNames[i] = gsub("-mean","Mean ",colNames[i])
  colNames[i] = gsub("^(t)","Time ",colNames[i])
  colNames[i] = gsub("^(f)","freq ",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity ",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro ",colNames[i])
  colNames[i] = gsub("Acc","Acceleration ",colNames[i])
  colNames[i] = gsub("-std","Standard Deviation ",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body ",colNames[i])
  colNames[i] = gsub("Jerk","Jerk ",colNames[i])
  colNames[i] = gsub("Mean","Mean ",colNames[i])
  colNames[i] = gsub("Gyro","Gyro ",colNames[i])
  colNames[i] = gsub("-X","Along X Axis ",colNames[i])
  colNames[i] = gsub("-Y","Along Y Axis ",colNames[i])
  colNames[i] = gsub("-Z","Along Z Axis ",colNames[i])
  colNames[i] = gsub("StdDev","Standard Deviation ",colNames[i])
  colNames[i] = gsub("Mag","Magnitude ",colNames[i])
  colNames[i] = gsub("freq","Frequency Of ",colNames[i])
};

#Assigns the meaningful column names back to the columns of "finalData"
colnames(finalData)=colNames;

####################################################################################################################################################

### 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

require(plyr);

# Finds out the columnwise mean of each variable by each subject and each activity
avgByActivityAndSubject = ddply(finalData, c("subjectId","Activity"), numcolwise(mean))

# Writes the tidy data set formed into the file "tidyDataSet.txt"
write.table(avgByActivityAndSubject, file = "tidyDataSet.txt",row.name=FALSE , quote = FALSE)

