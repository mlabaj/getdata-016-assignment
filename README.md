Getting and Cleaning Data Course Project
======================

This is a Course Project for Getting and Cleanind Data course on Coursera.org

* `README.md` - This document.
* `CodeBook.md` - Code book covering input and output data and transformations done.
* `run_analysis.R` - Script for converting the source dataset into tidy dataset(s).

# Source Dataset

[Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
```
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto. 
Smartlab - Non Linear Complex Systems Laboratory 
DITEN - UniversitÃ  degli Studi di Genova, Genoa I-16145, Italy. 
activityrecognition '@' smartlab.ws 
www.smartlab.ws
```

When the script is run, the source dataset is downloaded and unpacked automatically (if the dataset directory does not exist).

# Resulting Dataset

After running the script, two tidy datasets are created in the working directory.

* `tidy_dataset.[csv/txt]` - Contains measured values for each participant and his/her activities.
  * Train and test sets are merged.
  * Only mean and standard deviation based features are included for each measurement.
  * Activities have descriptive names.
  * Columns have descriptive variable names.
* `tidy_dataset_averages.[csv/txt]` - Contains the variables above averaged for each participant and activity.

# Requirements

This code was developed in R version `3.1.2` and uses `reshape2` library for melting and casting the resulting tidy dataset 1 into tidy dataset 2.

### sessionInfo()
```
R version 3.1.2 (2014-10-31)
Platform: x86_64-w64-mingw32/x64 (64-bit)

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] reshape2_1.4.1

```

# More information

For more information, see description in [CodeBook.md](CodeBook.md) and comments in [run_analysis.R](run_analysis.R).