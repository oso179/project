#Download file
If(!file.exists("./data")){dir.create("./data")}
fileUrl <- https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
download.file(fileUrl, destfile="./data/activities.zip",method="curl")
 
#Unzip file
If(!file.exists("UCI HAR Dataset")){unzip("activities.zip"}

#define
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
features <- read.table("UCI HAR Dataset/features.txt", header = FALSE)
features_info <- read.table("UCI HAR Dataset/features_info.txt", header = FALSE)
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
subject_test <- read.table("UCI HAR Dataset/train/subject_test.txt", header = FALSE)

#1_Merges the training and the test sets to create one data set
X <- rbind(X_train,X_test)
Y <- rbind(y_train,y_test)
subject <- rbind(subject_train,subject_test)

#3_Uses descriptive activity names to name the activities in the data set
#4_Appropriately labels the data set with descriptive variable names
names(X) <- features$V2
names(Y) <-c("activities")
names(subject) <-c("subject")

Merged_1 <- cbind(Subject,Y)
Merged <- cbind (Merged_1,X)

#2_Extracts only the measurements on the mean and standard deviation for each measurement
measurements <- features$V2[grep("mean\\(\\)|std\\(\\)", features$V2)]

#5_Create a second, independent tidy data set
data <- subset(measurements,select="activities"|"subject") 
str(data)

#Use write.table to create a txt file
write.table(data,file="result.txt",row.names = FALSE)
