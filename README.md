---
title: "Getting and Cleaning Data Course Project README"
author: "Gary Sharpe"
date: "Saturday, July 26, 2014"
---
===================================



The dataset includes the following files:
============================================

run_analysis.R
all_data.txt
tidy_data_set_containing_means_of_all_variables.txt

The run_analysis.R script combines the test and training data from the UCI HAR Dataset.  Second, it computes the mean of each variable from the combined data and calculates a mean of the observed variables for each activity and subject.

The all_data.txt file contains all of the means and std calculated from the UCI HAR Dataset for each observed subject performing each of the six activities.

The tidy_data_set_containing_means_of_all_variables.txt contains calculations of the mean of means and the mean of stds for each activity and subject