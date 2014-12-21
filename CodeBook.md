# Transformations

0. If the source dataset directory does not exist, it is automatically downloaded and unpacked.
1. Train and test sets sourced from `X_train.txt` and `X_test.txt` (measurement vectors), `y_train.txt` and `y_test.txt` (activity IDs), and `subject_train.txt` and `subject_test.txt` (subject IDs) are merged one after another using `rbind`.
2. Columns in measurement vectors are named with labels sourced from `features.txt`. Then only columns including substring `mean()` or `std()` are selected.
3. Activity IDs are replaced in rows using labels sourced from `activity_labels.txt`.
4. Activity and subject columns are named. All sets (subjects, activities, vectors) are joined using `cbind`. Resulting tidy dataset 1 is written into csv and txt files.
5. Dataset 1 is melted using subject and activity as IDs and all measurement columns as variables and casted producing the summarized average for each (mean and standard deviation) feature for each subject-activity pair. Separate tidy dataset 2 is written into csv and txt files.

# Data

### subjectID

Subject ID describing participant who performed the activities.

### activity

Activity performed by the participant, one of:
* WALKING
* WALKING_UPSTAIRS
* WALKING_DOWNSTAIRS
* SITTING
* STANDING
* LAYING

### (measurements, column names preserved from source dataset) 

Source: [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones), README.txt therein

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

-----

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

* mean(): Mean value
* std(): Standard deviation
* ~~mad(): Median absolute deviation~~ (in tidy dataset, only mean() and std() are used)
* ~~max(): Largest value in array~~
* ~~min(): Smallest value in array~~
* ~~sma(): Signal magnitude area~~
* ~~energy(): Energy measure. Sum of the squares divided by the number of values.~~
* ~~iqr(): Interquartile range~~
* ~~entropy(): Signal entropy~~
* ~~arCoeff(): Autorregresion coefficients with Burg order equal to 4~~
* ~~correlation(): correlation coefficient between two signals~~
* ~~maxInds(): index of the frequency component with largest magnitude~~
* ~~meanFreq(): Weighted average of the frequency components to obtain a mean frequency~~
* ~~skewness(): skewness of the frequency domain signal~~
* ~~kurtosis(): kurtosis of the frequency domain signal~~
* ~~bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.~~
* ~~angle(): Angle between to vectors.~~

~~Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable.~~
