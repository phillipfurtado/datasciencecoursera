library(plyr)

#global vars
DATA_URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
ZIP_FILE <- './getdata-projectfiles-UCI HAR Dataset.zip'
UNZIP_DOWNLOAD_FOLDER <- './UCI HAR Dataset'

#check file existence, if necessary it will download it
if(!file.exists(ZIP_FILE)){
  download.file(DATA_URL, ZIP_FILE, method = "curl")
}

#check if there is an unziped folder with the data
if(!file.exists(UNZIP_DOWNLOAD_FOLDER)){
  unzip(ZIP_FILE)
}

#define the main path to files and creates the merged folder
actual_wd <- getwd()
MAIN_PATH <- paste0(actual_wd,"/", "UCI HAR Dataset/")
dir.create(file.path(MAIN_PATH, "merged"), showWarnings = FALSE)

#Merges the training and the test sets to create one data set
y_train <- read.table(paste0(MAIN_PATH,"train/y_train.txt"))
y_test <- read.table(paste0(MAIN_PATH,"test/y_test.txt"))
y_train_test <- rbind(y_train, y_test)
rm(y_train, y_test)

X_train <- read.table(paste0(MAIN_PATH,"train/X_train.txt"))
X_test <- read.table(paste0(MAIN_PATH,"test/X_test.txt"))
X_train_test <- rbind(X_train, X_test)
rm(X_train, X_test)

subject_train <- read.table(paste0(MAIN_PATH,"train/subject_train.txt"))
subject_test <- read.table(paste0(MAIN_PATH,"test/subject_test.txt"))
subject_train_test <- rbind(subject_train, subject_test)
rm(subject_train, subject_test)

#Extracts only the measurements on the mean and standard deviation for each measurement
features <- read.table(paste0(MAIN_PATH,"features.txt"))
features_mean_std_only_ids <- grep("-(mean|std)\\(\\)", features[, 2])

X_train_test <- X_train_test[, features_mean_std_only_ids]

names(X_train_test) <- features[features_mean_std_only_ids, 2]

#Uses descriptive activity names to name the activities in the data set
activities_labels <- read.table(paste0(MAIN_PATH,"activity_labels.txt"))
y_train_test[, 1] <- activities_labels[y_train_test[, 1], 2]

#Appropriately labels the data set with descriptive variable names. 
names(y_train_test) <- "activity_label"
names(subject_train_test) <- "subject"

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
complete_dataset <- cbind(X_train_test, y_train_test, subject_train_test)
averages_dataset <- ddply(complete_dataset, .(activity_label, subject), function(x) { 
    colMeans(x[, 1:66])
  })

#Exports the output dataset to filesystem 
write.table(averages_dataset, paste0(MAIN_PATH,"merged/averages_dataset.txt"), row.name=FALSE)
