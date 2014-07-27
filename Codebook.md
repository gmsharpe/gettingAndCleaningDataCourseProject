---
title: "Getting and Cleaning Data Course Project Code Book"
author: "Gary Sharpe"
date: "Saturday, July 26, 2014"
---

The dataset includes the following files:
============================================

run_analysis.R
all_data.txt
tidy_data_set_containing_means_of_all_variables.txt

The run_analysis.R script combines the test and training data from the UCI HAR Dataset.  Second, it computes the mean of each variable from the combined data and calculates a mean of the observed variables for each activity and subject.

The all_data.txt file contains all of the means and std calculated from the UCI HAR Dataset for each observed subject performing each of the six activities.

The tidy_data_set_containing_means_of_all_variables.txt contains calculations of the mean of means and the mean of stds for each activity and subject


The set of signals that were gathered from the origbinal UCI HAR Dataset include: 
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
mean: Mean value
std: Standard deviation

The set of calculated variables in the tidy_data_set_containing_means_of_all_variables.txt include:
===========================================

mean of means for each activity and subject
mean of std for each activity and subject

These variables are represented as:

MeanOf <append each of all of the above variables>

Notes:
============================================


