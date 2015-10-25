#Dependencies
library(reshape2)

#1) Merges the training and the test sets to create one data set.
ingest_dataset = function(data_folder, dataset_name){
  features_file <- file.path("data/features.txt")
  features <- read.table(features_file, header = FALSE, as.is = TRUE, col.names=c("MeasureID", "MeasureName"))
  measures <- features$MeasureName
  
  y_file <- file.path(data_folder, paste0("y_", dataset_name, ".txt"))
  y_data <- read.table(y_file, header = FALSE, col.names = c("ActivityID"))
  
  x_file <- file.path(data_folder, paste0("X_", dataset_name, ".txt"))
  x_data <- read.table(x_file, header = FALSE, col.names = measures)
  
  subject_file <- file.path(data_folder, paste0("subject_", dataset_name, ".txt"))
  subject_data <- read.table(subject_file, header = FALSE, col.names = c("SubjectID"))
  
  subset_features <- grep(".*mean\\(\\)|.*std\\(\\)", measures)
  
  x_subset = x_data[, subset_features]
  
  x_subset$ActivityID = y_data$ActivityID
  x_subset$SubjectID = subject_data$SubjectID
  
  x_subset
}

train_data <- ingest_dataset("data/train", "train")
test_data <- ingest_dataset("data/test", "test")

merge_data <- rbind(test_data, train_data)
renamed_cols <- colnames(merge_data)
renamed_cols <- gsub("\\.+mean\\.+", cnames, replacement = "Mean")
renamed_cols <- gsub("\\.+std\\.+", cnames, replacement = "Std")
colnames(merge_data) = renamed_cols

#2) Extracts only the measurements on the mean and standard deviation for each measurement. 
# DONE along with #1

#3) Uses descriptive activity names to name the activities in the data set
labels <- read.table("data/activity_labels.txt", header = FALSE, as.is = TRUE, col.names = c("ActivityID", "ActivityName"))

#4) Appropriately labels the data set with descriptive variable names. 
labels$ActivityName <- as.factor(labels$ActivityName)
merged_labels <- merge(merge_data, labels)

#5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
ids <- c("ActivityID", "ActivityName", "SubjectID")
measure_columns <- colnames(merged_labels)
measure_vars <- setdiff(measure_columns, ids)
molten <- melt(merged_labels, id = ids, measure.vars = measure_vars)
tidy <- dcast(molten, ActivityName + SubjectID ~ variable, mean)

#Writes the tidy data
write.table(tidy, "tidy_data.txt",row.name=FALSE)

