# --------------------------------------------------
#  A script that processes the following dataset:
#   Human Activity Recognition Using Smartphones Data Set 
#    Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto. 
#    Smartlab - Non Linear Complex Systems Laboratory 
#    DITEN - UniversitÃ  degli Studi di Genova, Genoa I-16145, Italy. 
#    activityrecognition '@' smartlab.ws 
#    www.smartlab.ws 
#   
#  Obtainable from:
#   http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# 
#  Into a tidy dataset, doing the following steps (per Coursera's Getting and Cleaning Data project assignment):
#
#   1. Merges the training and the test sets to create one data set.
#   2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#   3. Uses descriptive activity names to name the activities in the data set
#   4. Appropriately labels the data set with descriptive variable names. 
#   5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable
#      for each activity and each subject.
#
#  The script expects input data in the structure of the unpacked referenced dataset.
#  Resulting tidy datasets are stored in the working directory both as csv&txt tables in names determined by
#  dataset[1/2].file.name variables.
#
# --------------------------------------------------
library(reshape2)

dataset1.file.name = "tidy_dataset"
dataset2.file.name = "tidy_dataset_averages"

# --------------------------------------------------
#  Dataset preparation (download&extract if needed)
# --------------------------------------------------
zip.file.name = "UCI HAR Dataset.zip"
dataset.dir.name = "UCI HAR Dataset"

# check if the data set directory is in the working directory
if (!file.exists(dataset.dir.name)) {
  if (!file.exists(zip.file.name)) {
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                  destfile = zip.file.name, mode = "wb")
  }
  unzip(zip.file.name)    
}


# --------------------------------------------------
#  Read all necessary files
# --------------------------------------------------
x.train <- read.table(file.path(dataset.dir.name, "train", "X_train.txt"))
y.train <- read.table(file.path(dataset.dir.name, "train", "y_train.txt"))
s.train <- read.table(file.path(dataset.dir.name, "train", "subject_train.txt"))
x.test  <- read.table(file.path(dataset.dir.name, "test",  "X_test.txt"))
y.test  <- read.table(file.path(dataset.dir.name, "test",  "y_test.txt"))
s.test  <- read.table(file.path(dataset.dir.name, "test",  "subject_test.txt"))

labels.features   <- read.table(file.path(dataset.dir.name, "features.txt"))
labels.activities <- read.table(file.path(dataset.dir.name, "activity_labels.txt"))


# --------------------------------------------------
#  1. Merge training and test sets
# --------------------------------------------------
all.vectors   <- rbind(x.train, x.test)
all.activities <- rbind(y.train, y.test)
all.subjects  <- rbind(s.train, s.test)


# --------------------------------------------------
#  2. Extract only means and standard deviations on measurements
# --------------------------------------------------

# name the features, feature labels: column1 (V1) = ID, column2 (V2) = feature label
names(all.vectors) <- labels.features[,"V2"]

# only columns with names including "mean()" or "std()"
mean_std_columns <- grep("mean\\(\\)|std\\(\\)",names(all.vectors))
all.vectors <- all.vectors[,mean_std_columns]


# --------------------------------------------------
#  3. Use descriptive names for activities
# --------------------------------------------------

# activities:      column1 (V1) = ID
# activity labels: column1 (V1) = ID, column2 (V2) = descriptive name

# add a row number column, because merge does not preserve order
all.activities$ID <- seq_along(all.activities$V1)
all.activities <- merge(all.activities, labels.activities, by.x = "V1", by.y = "V1")
# restore order using row numbers
all.activities <- all.activities[order(all.activities$ID),]

all.activities <- all.activities[,"V2", drop=FALSE] # drop=F ensures the result is still a dataframe


# --------------------------------------------------
#  4. Label sets with variable names
# --------------------------------------------------
names(all.activities) <- c("activity")
names(all.subjects) <- c("subjectID")
# all.vectors were named in step 2 when extracting columns


# --------------------------------------------------
#  Merge columns and write dataset #1
# --------------------------------------------------
dataset <- cbind(all.subjects, all.activities, all.vectors)

write.table(dataset, file = paste(dataset1.file.name, "txt", sep="."), row.names = FALSE)
write.csv(  dataset, file = paste(dataset1.file.name, "csv", sep="."), row.names = FALSE)

# ----------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------

# --------------------------------------------------
#  5. Create separate data set with variable averages per subject and activity
# --------------------------------------------------

# melt into: subjectID, activity, variable, value
melted <- melt(dataset, id = c("subjectID", "activity"))
# recast into: subjectID, activity, variable1_avareage, variable2_average, ...
dataset_avg <- dcast(melted, subjectID + activity ~ variable, mean)

# rename (variable columns only) to include prefix "avg_"
nlen <- length(names(dataset_avg))
names(dataset_avg)[3:nlen] <- lapply(names(dataset_avg)[3:nlen], function(x) paste("avg_", x, sep="") )

write.table(dataset_avg, file = paste(dataset2.file.name, "txt", sep="."), row.names = FALSE)
write.csv(  dataset_avg, file = paste(dataset2.file.name, "csv", sep="."), row.names = FALSE)