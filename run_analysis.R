##Download the zipped data file to the current working directory
data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(data_url, "UCI_HAR_data.zip", method="internal")

##Unzips the data in place
unzip("UCI_HAR_data.zip")

##load required libraries
library(data.table)

##read in the features file
features <- fread("./UCI HAR dataset/features.txt")

## read in the 3 files associated with the Test set of data
test_x_data <- read.table("./UCI HAR dataset/test/X_test.txt")
test_y_data <- read.table("./UCI HAR dataset/test/y_test.txt")
test_subject_data <- read.table("./UCI HAR dataset/test/subject_test.txt")

## join the test columns together
test_combined <- cbind(test_subject_data, test_y_data, test_x_data)

## read in the 3 files for the Training data
train_x_data <- read.table("./UCI HAR dataset/train/X_train.txt")
train_y_data <- read.table("./UCI HAR dataset/train/y_train.txt")
train_subject_data <- read.table("./UCI HAR dataset/train/subject_train.txt")

## join the training columns together
train_combined <- cbind(train_subject_data, train_y_data, train_x_data)

## Join the test set rows and the training set rows together
all_data <- rbind(test_combined, train_combined)

## create the list of headers from the features file 
## plus headers for subject and activity
all_headers <- c(c("subject", "activity"), features[,V2])
names(all_data) <- all_headers

## keep only columns that are Means or Standard deviation
## plus headers for subject and activity
all_data <- all_data[,grep("mean\\(\\)|std\\(\\)|Subject|activity",all_headers)]

## read in the labels for the activity and change the values to the labels
activity_levels <- read.table("./UCI HAR dataset/activity_labels.txt")
all_data$activity <- factor(all_data$activity, labels=activity_levels[,2])

## rename the headers to make them more readable
## fix error in some headers where body is repeated
new_headers <- names(all_data)
new_headers <- sub("^t","time.signal.",new_headers)
new_headers <- sub("^f","frequency.signal.",new_headers)
new_headers <- sub("BodyAcc","body.linear.acceleration.",new_headers)
new_headers <- sub("BodyGyro","body.angular.acceleration.",new_headers)
new_headers <- sub("GravityAcc","gravity.linear.acceleration.",new_headers)
new_headers <- sub("Mag","magnitude.",new_headers)
new_headers <- sub("Bodybody","body",new_headers)
new_headers <- sub("Jerk","Jerk.",new_headers)
new_headers <- sub("-mean\\(\\)","mean",new_headers)
new_headers <- sub("-std\\(\\)","standard.deviation",new_headers)
new_headers <- sub("-X",".x.axis",new_headers)
new_headers <- sub("-Y",".y.axis",new_headers)
new_headers <- sub("-Z",".z.axis",new_headers)

## replace headers in the data table
names(all_data) <- new_headers

## create a tidy data table by group the data by subject and activity
## and calculating the mean
tidy_data <- aggregate(. ~ subject + activity,all_data, FUN=mean)

##write the data out to a text file in the current working directory
write.table(tidy_data, file="UCI_HAR_tidy_data.txt", row.names=F, sep="\t")