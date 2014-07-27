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
#results <- data.frame()
# names(results) <- titles
len <- length(titles) - 2


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
   # record <- data.frame(temp)
    #dim(record)
    names(record) <- titles
    #results <- rbind(results,record,titles)
   if(k == 1 & i == 1){
     write.table(record,file="computed_results.txt", append=FALSE, row.names = FALSE, col.names=TRUE)
   }
   else {
     write.table(record,file="computed_results.txt", append=TRUE, row.names = FALSE, col.names=FALSE)
   }
  }
}




