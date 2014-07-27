run_analysis <- function(){
  
  # Read in Features (Column Titles) and Activity Labels
  features <- read.table("features.txt", header=FALSE)
  activity_labels <- read.table("activity_labels.txt", header=FALSE)
  
  # Construct a vector of features that are related to measuring mean() and std()
  newset <- c()
  for (x in features){
    newset <- c(newset, grep("mean\\(\\)|std\\(\\)", x, value=TRUE))
  }
  
  
  # Read in Training Data
  
  subject_train <- read.table("train/subject_train.txt", header=FALSE)
  y_train <- read.table("train/y_train.txt", header=FALSE)
  x_train <- read.table("train/X_train.txt", header=FALSE,colClasses=c(rep("numeric",561)))
  
  # Read in Test Data
  
  subject_test <- read.table("test/subject_test.txt", header=FALSE)
  y_test <- read.table("test/y_test.txt", header=FALSE)
  x_test <- read.table("test/X_test.txt", header=FALSE,colClasses=c(rep("numeric",561)))
  
  # label the columns with features as column names
  
  train_df <- x_train
#   print(head(train_df[,1],10))
#   print(features[,2])
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

# add columns for subject and activity performed
# TODO append these columns to the front

addActivityColumn <- function(df, activityCol){
  names(activityCol) <- "Activity"  
  df <- cbind(df, activityCol)
  return(df)
}

addSubjectColumn <- function(df, subjectCol){
  names(subjectCol) <- "Subject"
  df <- cbind(df, subjectCol)
  return(df)
}

makeHeadersFriendly <- function(df){
  
  # Change the names of the headers to be more friendly
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

#####################  run_analysis #####################

run_analysis()

