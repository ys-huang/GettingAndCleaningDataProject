## 0. Load library
library(dplyr)
library(tidyr)

## 1. Merges the training and the test sets to create one data set

# Set Directory
setwd('./UCI HAR Dataset/')

# import data in:
features     <- read.table('./features.txt',header=FALSE);
activityLabel <- read.table('./activity_labels.txt',header=FALSE); 
subjectTrain <- read.table('./train/subject_train.txt',header=FALSE);
xTrain       <- read.table('./train/x_train.txt',header=FALSE);
yTrain       <- read.table('./train/y_train.txt',header=FALSE);
subjectTest  <- read.table('./test/subject_test.txt',header=FALSE); 
xTest        <- read.table('./test/x_test.txt',header=FALSE); 
yTest        <- read.table('./test/y_test.txt',header=FALSE); 

# Assign colum names:
colnames(features)      <- c("featureId","featureName")
colnames(activityLabel)  <- c("activityId", "activityLabel")
colnames(subjectTrain)  <- "subjectId"
colnames(xTrain)        <- features[,2]
colnames(yTrain)        <- "activityId"
colnames(subjectTest)   <- "subjectId"
colnames(xTest)         <- features[,2]
colnames(yTest)         <- "activityId"

# Merge trainnig and testing data together
trainData = cbind(yTrain, subjectTrain, xTrain)
testData  = cbind(yTest, subjectTest, xTest)
data      = rbind(trainData, testData)


## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

# select only mean and standard deviation
colIndex <- grepl("subjectId|activityId|mean|std", names(data)) # identify the colum names with "mean" or "std"
dataExtract <- data[, colIndex] 


## 3. Uses descriptive activity names to name the activities in the data set


# Merge activity label into data
dataFinal = merge(activityLabel, dataExtract,  by='activityId', all.x=TRUE)


## 4. Appropriately labels the data set with descriptive variable names. 

nameDes <- names(dataFinal)
nameDes <- gsub("^t", nameDes, replacement = "time")
nameDes <- gsub("^f", nameDes, replacement = "freq")
nameDes <- gsub("-?mean\\(\\)-?", nameDes, replacement = "Mean")
nameDes <- gsub("-?std\\(\\)-?", nameDes, replacement = "Std")
nameDes <- gsub("-?meanFreq\\(\\)-?", nameDes, replacement = "MeanFreq")
nameDes <- gsub("BodyBody", nameDes, replacement = "Body")

#Write back to the column name
names(dataFinal) = nameDes

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# expand to long data
dataLong <- gather(dataFinal[,-1], variable, value, -subjectId, -activityLabel)
dataSum <- summarise(group_by(dataLong, subjectId, activityLabel, variable), value=mean(value))

# export the tidy data to a txt file
write.table(dataSum, './tidyData.txt',row.name=FALSE);
