# =============================================================================
# Clean up the UCI Samsung Galaxy acceleromter data for analysis
# =============================================================================

library(tidyr)
library(dplyr)

# -----------------------------------------------------------------------------
# Activity and feature lookups
# -----------------------------------------------------------------------------
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
colnames(activities) <- c("label","activity")
activities$activity <- tolower(activities$activity)
features <- read.table("UCI HAR Dataset/features.txt")
colnames(features) <- c("label","feature")

# -----------------------------------------------------------------------------
# Test Data
# -----------------------------------------------------------------------------

# Subjects and Activities
test.subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
colnames(test.subject) <- c("subject")
test.activity <- read.table("UCI HAR Dataset/test/y_test.txt")
test.activity <- inner_join(test.activity, activities, by = c("V1" = "label"))
test.activity <- data.frame(activity=test.activity$activity)

# Get feature values
test.values <- read.table("UCI HAR Dataset/test/X_test.txt")
colnames(test.values) <- features$feature

# Build list of variables to keep -- means and standard deviations
keep <- grep("mean\\(|std\\(",features$feature,value = TRUE)

# Put together test data into tidy data
test.data = cbind(
  test.subject,
  data.frame(group=rep("test", length(test.subject))),
  test.activity,
  test.values[,keep]
)

# -----------------------------------------------------------------------------
# Train Data
# -----------------------------------------------------------------------------

# Subjects and Activities
train.subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
colnames(train.subject) <- c("subject")
train.activity <- read.table("UCI HAR Dataset/train/y_train.txt")
train.activity <- inner_join(train.activity, activities, by = c("V1" = "label"))
train.activity <- data.frame(activity=train.activity$activity)

# Get feature values
train.values <- read.table("UCI HAR Dataset/train/X_train.txt")
colnames(train.values) <- features$feature

# Build list of variables to keep -- means and standard deviations
keep <- grep("mean\\(|std\\(",features$feature,value = TRUE)

# Put together train data into tidy data
train.data = cbind(
  train.subject,
  data.frame(group=rep("train", length(train.subject))),
  train.activity,
  train.values[,keep]
)

# -----------------------------------------------------------------------------
# Tidy data set # 1
# -----------------------------------------------------------------------------

tidy.data <- rbind(
  train.data,
  test.data
)
write.table(tidy.data, file = "tidy_data_1.txt", row.names = FALSE)

# -----------------------------------------------------------------------------
# Tidy data set # 1
# -----------------------------------------------------------------------------

tidy.data.2 <- tidy.data %>% 
  gather(metric, value, -subject, -group, -activity) %>% 
  group_by(subject, group, activity, metric) %>% 
  summarise(avg=mean(value)) %>% 
  spread(metric, avg)
write.table(tidy.data.2, file = "tidy_data_2.txt", row.names = FALSE)

# clean up environment
rm(list=ls())