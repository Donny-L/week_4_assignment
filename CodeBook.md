The run_analysis.R script records the data preparation that was done and then followed by the 5 steps required as described in the course project’s instructions.

Download the dataset
Dataset downloaded and extracted under the folder called UCI HAR Dataset

Assign each data to variables
features <- features.txt : 561 rows, 2 columns
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.

activities <- activity_labels.txt : 6 rows, 2 columns
List of activities performed when the corresponding measurements were taken and its codes (labels)

subject_test <- test/subject_test.txt : 2947 rows, 1 column
contains test data of 9/30 volunteer test subjects being observed

x_test <- test/X_test.txt : 2947 rows, 561 columns
contains recorded features test data

y_test <- test/y_test.txt : 2947 rows, 1 columns
contains test data of activities’code labels

subject_train <- test/subject_train.txt : 7352 rows, 1 column
contains train data of 21/30 volunteer subjects being observed

x_train <- test/X_train.txt : 7352 rows, 561 columns
contains recorded features train data

y_train <- test/y_train.txt : 7352 rows, 1 columns
contains train data of activities’code labels

(1) Merges the training and the test sets to create one data set
x_merge (10299 rows, 561 columns) was created by merging x_train and x_test using rbind() function
y_merge (10299 rows, 1 column) was created by merging y_train and y_test using rbind() function
subject_bind (10299 rows, 1 column) is created by merging subject_train and subject_test using rbind() function
all_merge (10299 rows, 563 column) is created by merging subject_bind, y_merge and x_merge using cbind() function

(2) Extracts only the measurements on the mean and standard deviation for each measurement
mean_and_std (10299 rows, 72 columns) is created by subsetting all_merge, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement

(3) Uses descriptive activity names to name the activities in the data set
Entire numbers in code column of the mean_and_std replaced with corresponding activity taken from second column of the activities variable
such as "standing, layin, walking, walking upstairs, walking downstairs. 

(4) Appropriately labels the data set with descriptive variable names
code column in mean_and_std renamed with activity names
All Acc in column’s name replaced by Accelerometer
All Gyro in column’s name replaced by Gyroscope
All BodyBody in column’s name replaced by Body
All Mag in column’s name replaced by Magnitude
All start with character f in column’s name replaced by Frequency
All start with character t in column’s name replaced by Time
So on...

(5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
tidy (180 rows, 72 columns) was created by sumarizing mean_and_std, taking the means of each variable for each activity and each subject, after groupped by subject and activity.
Then just export the "tidy" dataset into tidy.txt file.

END
