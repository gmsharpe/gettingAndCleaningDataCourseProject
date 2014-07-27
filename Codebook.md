---
title: "Getting and Cleaning Data Course Project Code Book"
author: "Gary Sharpe"
date: "Saturday, July 26, 2014"
output: word_document
---

The dataset includes the following files:
============================================

run_analysis.R
all_data.txt
tidy_data_set_containing_means_of_all_variables.txt

The run_analysis.R script combines the test and training data from the UCI HAR Dataset.  Second, it computes the mean of each variable from the combined data and calculates a mean of the observed variables for each activity and subject.

The all_data.txt file contains all of the means and std calculated from the UCI HAR Dataset for each observed subject performing each of the six activities.

The tidy_data_set_containing_means_of_all_variables.txt contains calculations of the mean of means and the mean of stds for each activity and subject


The test and training data from the UCI HAR Dataset was combined from files that separately stored the subject #, the observations for each variable, the activities performed, and a lookup for matching the activities to a descriptive name for each activity.

These original files included:
============================================

activity_labels.txt': Links the class labels with their activity name.
'train/X_train.txt': Training set.
'train/y_train.txt': Training labels.
'test/X_test.txt': Test set.
'test/y_test.txt': Test labels.
'train/subject_train.txt'
'train/Inertial Signals/total_acc_x_train.txt'
'train/Inertial Signals/body_acc_x_train.txt'
'train/Inertial Signals/body_gyro_x_train.txt'
'test/subject_test.txt'
'test/Inertial Signals/total_acc_x_test.txt'
'test/Inertial Signals/body_acc_x_test.txt'
'test/Inertial Signals/body_gyro_x_test.txt'

The set of signals that were gathered from the origbinal UCI HAR Dataset were modified to be more descriptive.  These signals include: 
============================================

TimeSignals BodyAcc [XYZ]-Axis
TimeSignals GravityAcc [XYZ]-Axis
TimeSignals BodyAccJerk [XYZ]-Axis
TimeSignals BodyGyro [XYZ]-Axis
TimeSignals BodyGyroJerk [XYZ]-Axis
TimeSignals BodyAccMag
TimeSignals GravityAccMag
TimeSignals BodyAccJerkMag
TimeSignals BodyGyroMag
TimeSignals BodyGyroJerkMag
FrequencyDomainSignals BodyAcc [XYZ]-Axis
FrequencyDomainSignals BodyAccJerk [XYZ]-Axis
FrequencyDomainSignals BodyGyro [XYZ]-Axis
FrequencyDomainSignals BodyAccMag
FrequencyDomainSignals BodyAccJerkMag
FrequencyDomainSignals BodyGyroMag
FrequencyDomainSignals BodyGyroJerkMag

The set of variables that were included in this summary of the UCI HAR Dataset from these signals are:
===========================================
Mean: Mean value
Std: Standard deviation

The set of calculated variables in the tidy_data_set_containing_means_of_all_variables.txt include:
===========================================

mean of means for each activity and subject
mean of std for each activity and subject

These variables are represented as:

MeanOf <append each of all of the above variables>

Additional Transformations:
===========================================

When the activity was appended to the observed variables, the code representing the activity was replaced with the descriptive name (e.g. "WALKING" instead of '1')
