# About

This repo is my project submission for the JHU Getting and Cleaning Data Coursera course.

# Study Design

The `run_analysis.R` script takes the raw feature data sets from the [UCI smartphone accelerometer data](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and transform them into tidy data sets ready for analysis. The process is as follows:

1. Read in Feature and Activity Codes
2. Read in and Transform Test Group Data
  * Read in Test Group Subject and Activity data
  * Read in Test Group Feature Values
  * Combine subject identifier, group identifier ("test"), activity identifier, and feature value means and standard deviations
3. Read in and Transform Training Group Data
  * Read in Training Group Subject and Activity data
  * Read in Training Group Feature Values
  * Combine subject identifier, group identifier ("train"), activity identifier, and feature value means and standard deviations
4. Create first tidy data set by appending training and testing data
5. Create second tidy data set by finding the average of every feature value for each subject for each activity

# Code Book

### Tidy Data Set 1

The first tidy data set, [tidy_data_1.txt](tidy_data_1.txt), has a row of every data for every recorded observation. Each row contains the following data:

* subject: The identifier for the subject (1-30)
* group: Identifier for if the subject was randomly assigned to UCI's training or test group
* activity: Identifier for which of the [6 activities](activity_labels.txt) the occurring during the observation
* [feature]mean()-[XYZ]: the mean of each feature, documented [here](features_info.txt), for each of the 3 axes, X, Y and Z.
* [feature]std()-[XYZ]: the standard deviation of each feature, documented [here](features_info.txt), for each of the 3 axes, X, Y and Z.

### Tidy Data Set 2

The second tidy data set, [tidy_data_2.txt](tidy_data_2.txt), has a row of every subject, for every activity. Each row contains the following data:

* subject: The identifier for the subject (1-30)
* group: Identifier for if the subject was randomly assigned to UCI's training or test group
* activity: Identifier for which of the [6 activities](activity_labels.txt) the occurring during the observation
* [feature]mean()-[XYZ]: the *__AVERAGE__* mean of each feature, documented [here](features_info.txt), for each of the 3 axes, X, Y and Z.
* [feature]std()-[XYZ]: the *__AVERAGE__* standard deviation of each feature, documented [here](features_info.txt), for each of the 3 axes, X, Y and Z.
