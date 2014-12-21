zip.file.name = "UCI HAR Dataset.zip"
dataset.dir.name = "UCI HAR Dataset"

# check if the data set directory is in the working directory
if (!file.exists(dataset.dir.name)) {
  # download zip if needed
  if (!file.exists(zip.file.name)) {
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = zip.file.name, mode = "wb")
  }
  # unpack it
  unzip(zip.file.name)    
}