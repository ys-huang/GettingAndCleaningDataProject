## Getting and Cleaning Data Project

Information about the variables, data and transformations used in this project for Coursera Getting and Cleaning Data course.

### Source Data
Please find the full description of the data used in this project [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
And the data used in this project con be downloaded from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

### Summary of Data Set

The data was collected from the accelerometers from the Samsung Galaxy S smartphone, and a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. 

Using its embedded accelerometer and gyroscope, the data captured 3-axial linear acceleration and 3-axial angular velocity, and a vector of features was obtained by calculating variables from the time and frequency domain.

The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

### Data Attribute
For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

### Step 1. Merge the training and the test sets to create one data set.
The file we read into data frame was located in
- features.txt
- activity_labels.txt
- subject_train.txt
- x_train.txt
- y_train.txt
- subject_test.txt
- x_test.txt
- y_test.txt

Assign column names and merge the testing and training data altoghther to create one data set according to the project requirement.

## Step 2. Extract only the measurements on the mean and standard deviation for each measurement. 
Since we need only mean and standard deviation data, we do select only the columns containning the data we want:
1. Create a vector judging whether the column name contains "mean" or "std".
2. Utilize the vector to choose right columns.

## Step 3. Use descriptive activity names to name the activities in the data set
Merge activity label into data according to activity ID

## Step 4. Appropriately label the data set with descriptive activity names.
Apply gsub to mkae column names more descriptive

## Step 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 
For each activity and sebgect, we aggregate the value and then calculate the mean. 
