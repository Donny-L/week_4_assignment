### Set Working Directory
setwd("/Users/donnyliu/Desktop/Coursera_R_programming/Getting_and_Cleaning_Data/assignment")

### Downloading and Cleaning the dataset

# 1. Unzip the dataset to my "data" directory
zipfile_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(zipfile_url, destfile = "./data/file.zip", mode = "wb")
unzip(zipfile = "./data/file.zip", exdir = "./data/unzip")

# 2. An error message popped up, so I want to check if the unziped file is 
#    in the directory data file
list.files("./data/unzip")

# 3. Listing all the datafiles in the "UCI HAR Dataset"
path <- file.path("./data/unzip", "UCI HAR Dataset")
#    Create a file with all 18 file names
files <- list.files(path, recursive = TRUE)
#    Display the file names
files 

# 4. Assigning all data frames with a handle
features <- read.table("./data/unzip/UCI HAR Dataset/features.txt",
                       col.names = c("n", "functions"))

activities <- read.table("./data/unzip/UCI HAR Dataset/activity_labels.txt",
                         col.names = c("code", "activity"))

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)

y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)

y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

### (1) Merges the training and the test sets to create one data set
x_merge <- rbind(x_train, x_test)
y_merge <- rbind(y_train, y_test)
subject_bind <- rbind(subject_train, subject_test)
all_merge <- cbind(subject_bind, y_merge, x_merge)

View(all_merge)
names(all_merge)

### (2) Extracts only the measurements on the mean and standard deviation for each
colNames<- colnames(all_merge)
extract <- (grepl("subject", colNames) | grepl("code", colNames) | grepl("mean..", colNames) |
                    grepl("std...", colNames))

mean_and_std <- all_merge[, extract == TRUE]

### (3) Use descriptive activity names to name the activities in the data set
mean_and_std$code <- activities[mean_and_std$code, 2]

### (4) Appropriately labels the data set with descriptive variable names
names(mean_and_std)[2] = "activity"
names(mean_and_std)<-gsub("Acc", "Accelerometer", names(mean_and_std))
names(mean_and_std)<-gsub("Gyro", "Gyroscope", names(mean_and_std))
names(mean_and_std)<-gsub("BodyBody", "Body", names(mean_and_std))
names(mean_and_std)<-gsub("Mag", "Magnitude", names(mean_and_std))
names(mean_and_std)<-gsub("^t", "Time", names(mean_and_std))
names(mean_and_std)<-gsub("^f", "Frequency", names(mean_and_std))
names(mean_and_std)<-gsub("tBody", "TimeBody", names(mean_and_std))
names(mean_and_std)<-gsub("-mean()", "Mean", names(mean_and_std), ignore.case = TRUE)
names(mean_and_std)<-gsub("-std()", "STD", names(mean_and_std), ignore.case = TRUE)
names(mean_and_std)<-gsub("-freq()", "Frequency", names(mean_and_std), ignore.case = TRUE)
names(mean_and_std)<-gsub("angle", "Angle", names(mean_and_std))
names(mean_and_std)<-gsub("gravity", "Gravity", names(mean_and_std))

### (5) From the data set in step 4, creates a second, independent tidy data set 
### with the average of each variable for each activity and each subject.

tidy <- mean_and_std %>%
        group_by(subject, activity) %>%
        summarise_all(funs(mean))

write.table(tidy, "tidy.txt", row.names = FALSE)





