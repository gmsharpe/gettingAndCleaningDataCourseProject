run_analysis <- function(){
  
  # Read in Features (Column Titles) and Activity Labels
  features <- read.table("UCI HAR Dataset/features.txt", header=FALSE)
  activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", header=FALSE)
  
  # Construct a vector of features that are related to measuring mean() and std()
  newset <- c()
  for (x in features){
    newset <- c(newset, grep("mean\\(\\)|std\\(\\)", x, value=TRUE))
  }
  
  # Read in Training Data
  
  subject_train <- read.table("train/subject_train.txt", header=FALSE)
  y_train <- read.table("UCI HAR Dataset/train/y_train.txt", header=FALSE)
  x_train <- read.table("UCI HAR Dataset/train/X_train.txt", header=FALSE,colClasses=c(rep("numeric",561)))
  
  # Read in Test Data
  
  subject_test <- read.table("test/subject_test.txt", header=FALSE)
  y_test <- read.table("UCI HAR Dataset/test/y_test.txt", header=FALSE)
  x_test <- read.table("UCI HAR Dataset/test/X_test.txt", header=FALSE,colClasses=c(rep("numeric",561)))
  
  # label the columns with features as column names
  
  train_df <- x_train
  names(train_df) <- features[,2]
  
  test_df <- x_test
  names(test_df) <- features[,2]
  
  # reduce train_df and test_df to just those columns with values pertaining to mean and std
  
  train_df <- train_df[,newset]
  test_df <- test_df[,newset]
  
  # add activity type column and activity type data
  
  train_df <- addActivityColumn(train_df,y_train)
  test_df <- addActivityColumn(test_df, y_test)
  
  # add subject column and subject data
  
  train_df <- addSubjectColumn(train_df, subject_train)
  test_df <- addSubjectColumn(test_df, subject_test)

  # replace activity codes with descriptive names
  
  train_df <- labelActivitiesWithFriendlyNames(train_df)
  test_df <- labelActivitiesWithFriendlyNames(test_df)
  
  # replace headers with descriptive names by removing abbreviations and unecessary characters
  train_df <- makeHeadersFriendly(train_df)
  test_df <- makeHeadersFriendly(test_df)
  
  write.table(train_df,file="all_data.txt", append=TRUE, row.names = FALSE)
  write.table(test_df,file="all_data.txt", append=TRUE, row.names = FALSE, col.names=FALSE)
  
  # Clean out the environment memory before moving on the next step
  rm(list=ls())
  
  # Read in all data to perform calculations of the average of each variable for each activity and each subject
  
  data <- read.table("all_data.txt", header=FALSE)
  
  # Example, select average all variables for subject 1 where activity = STANDING
  
  data <- data[data$Subject==1]
  
}

# Replaces numeric codes with actual names of the activities

labelActivitiesWithFriendlyNames <- function(data){
  # swap activity code with label 
  # 1 WALKING
  # 2 WALKING_UPSTAIRS
  # 3 WALKING_DOWNSTAIRS
  # 4 SITTING
  # 5 STANDING
  # 6 LAYING
  
  for(j in 1:nrow(data)){
    if(data$Activity[j] == 1) {data$Activity[j] <- "WALKING" }
    if(data$Activity[j] == 2) {data$Activity[j] <- "WALKING_UPSTAIRS" }
    if(data$Activity[j] == 3) {data$Activity[j] <- "WALKING_DOWNSTAIRS" }
    if(data$Activity[j] == 4) {data$Activity[j] <- "SITTING" }
    if(data$Activity[j] == 5) {data$Activity[j] <- "STANDING" }
    if(data$Activity[j] == 6) {data$Activity[j] <- "LAYING" }
  }
  return(data)
}

# add column for subject 

addActivityColumn <- function(df, activityCol){
  names(activityCol) <- "Activity"  
  df <- cbind(df, activityCol)
  return(df)
}

# add column for activity performed

addSubjectColumn <- function(df, subjectCol){
  names(subjectCol) <- "Subject"
  df <- cbind(df, subjectCol)
  return(df)
}

# change column titles to make them more descriptive, more 'tidy'.

makeHeadersFriendly <- function(df){
  
  friendly_names <- names(df)
  
  # if it starts with 't' replace with TimeSignals
  # if it starts with 'f' replace with FrequencyDomainSignals
  # replace BodyBody with Body
  # replace Acc with Acceleration
  
  friendly_names <- sub("^t", "TimeSignals ", friendly_names)
  friendly_names <- sub("^f", "FrequencyDomainSignals ", friendly_names)
  friendly_names <- gsub("BodyBody", "Body", friendly_names)
  friendly_names <- gsub("Acc", "Acceleration", friendly_names)
  friendly_names <- gsub("\\-mean\\(\\)", " Mean", friendly_names)
  friendly_names <- gsub("\\-std\\(\\)", " StandardDeviation", friendly_names)
  friendly_names <- gsub("-X$", " X-Axis", friendly_names)
  friendly_names <- gsub("-Y$", " Y-Axis", friendly_names)
  friendly_names <- gsub("-Z$", " Z-Axis", friendly_names)
  friendly_names <- gsub("Mag", "Magnitude", friendly_names)
  
  names(df) <- friendly_names
  
  return(df)
  
}

compute_means <- function(){
  
  # Read in all data to perform calculations of the average of each variable for each activity and each subject
  
  data <- read.table("all_data.txt", header=TRUE, stringsAsFactors=FALSE, colClasses=c(rep("numeric",66),"character", "numeric"))
  
  # Example, select average all variables for subject 1 where activity = STANDING
  
  # 1 WALKING
  # 2 WALKING_UPSTAIRS
  # 3 WALKING_DOWNSTAIRS
  # 4 SITTING
  # 5 STANDING
  # 6 LAYING
  
  activities <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")
  titles <- names(data)
  
  # This computed len is used to loop over all observed mean and std variables, 
  # ignoring the subject and activity columns
  
  len <- length(titles) - 2 
  
  # Add 'Mean Of' to the beginnng of all column titles where the mean of observed variables is calculated
  # for each activity and each subject
  
  for(m in 1:len) {
    titles[m] <- paste("MeanOf ", titles[m])
  }
  
  # Loop over all Subjects ('k'), and for each activity ('i'), loop through all variables ('j') and calculate 
  # the mean of observations given that subject and activity.  Add each result for each variable to an array that is printed
  # to the file 'tidy_data_set_containing_means_of_all_variables.txt'
  # Printing each row to the file is is not very fast, but it works...
  
  for(k in 1:30){
    for(i in 1:length(activities)){
      
      record <- data.frame()
      
      for(j in 1:len){
        subset <- data[data$Subject==k & data$Activity==activities[i],]
        result <- tapply(subset[[j]], subset$Subject, mean)
        record[1,j] <- result    
      }
      
      record[1,len + 1] <- activities[i]
      record[1,len + 2] <- k
      names(record) <- titles

      if(k == 1 & i == 1){
        write.table(record,file="tidy_data_set_containing_means_of_all_variables.txt", append=FALSE, row.names = FALSE, col.names=TRUE)
      }
      else {
        write.table(record,file="tidy_data_set_containing_means_of_all_variables.txt", append=TRUE, row.names = FALSE, col.names=FALSE)
      }
    }
  }
 
}

#####################  run_analysis and compute_means #####################

#run_analysis()
compute_means()
