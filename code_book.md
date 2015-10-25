#Introduction

This Codebook explains the sequence of steps taken to transform the orignal data present in the original acelerometer data. 
The Original data can be found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The Original data description here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

##Transformations
- We merged the data of Y and X measurements per subject (by SubjectID).
- We selected the features on features.txt, but only mean and standard deviations. It appears that the rest of the data are derived from those measures, so refer to original data for this derivations, or rebuild then using the data on this tidy dataset.
- For the names of the selected features, we've put then in camel case through some small changes on the original names
- We gave labes to the data_set from the activity_labels.txt, converted to factors.

##Data
The final dataset has 68 variables, containning meand and standard deviation of gyroscope and acelerometer for each activity. There in total 180 (observations) which represents pairs of subjects and activities..
**ActivityID**: The id of the activitiy as in features.txt
**ActivityName**: The activity name as in features.txt
**SubjectID**: The id of the activitiy as in features.txt

The other variables are the combination of sensors, modes, and axis [X,Y,Z] for acelerometer and gyroscope.