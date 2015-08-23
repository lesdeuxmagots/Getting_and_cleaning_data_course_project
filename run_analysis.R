# setwd("~/Coursera/datasciencecoursera/Getting_And_Cleaning_Data/PA/Getting_and_cleaning_data_course_project")

library("dplyr")

# initial load of all data
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
test_data <- read.table("./UCI HAR Dataset/test/X_test.txt")
test_activity <- read.table("./UCI HAR Dataset/test/y_test.txt")
training_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
training_data <- read.table("./UCI HAR Dataset/train/X_train.txt")
training_activity <- read.table("./UCI HAR Dataset/train/y_train.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
data_labels <- read.table("./UCI HAR Dataset/features.txt")

# convert numeric activity data to activity labels
for(i in 1:length(activity_labels$V1)){
           
      test_activity <- replace(test_activity,test_activity == activity_labels[i,1],as.character(activity_labels[i,2]))
      
      training_activity <- replace(training_activity,training_activity == activity_labels[i,1],as.character(activity_labels[i,2]))
}

# convert numeric header data to data labels
names(test_data) <- data_labels$V2
names(training_data) <-data_labels$V2

# remove extraneous files
rm(activity_labels,data_labels,i)

# 1st merge with new column to dictate test vs training
test_merge <- cbind(test_subject,test_activity,test_data)
test_merge$set <- "test"
training_merge <- cbind(training_subject,training_activity,training_data)
training_merge$set <- "training"

# remove extraneous data
rm(test_subject,test_data,test_activity,training_subject,training_data,training_activity)

#merge test and training data
tidy_data <- rbind(test_merge,training_merge)

# remove old data
rm(test_merge,training_merge)

#rename and reorder columns
colnames(tidy_data)[1] <- "subject"
colnames(tidy_data)[2] <- "activity"
tidy_data <- tidy_data[,c(1,564,2:563)]

# means and stdev for each measurement
measurement_means <- colMeans(tidy_data[,4:564],na.rm=TRUE)
measurement_sd <- apply(tidy_data[,4:564],2,sd)

# Step 5
grouped_analysis <- tidy_data %.% group_by(subject,activity) %.% summarise_each(funs(mean))

write.table("grouped_analysis",row.names = FALSE)