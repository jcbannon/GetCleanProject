# GetCleanProject
Project for Getting and Cleaning Data

Jeffrey Bannon - 05/23/2015

The R script in this repository (run_analysis.R) constructs two datasets from the UCI HAR Dataset (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). The original dataset captures movement measurements of subjects wearing Samsung Galaxy S II smartphones. The measurements are associated with subjects and a given physical activity:

- WALKING
- WALKING_UPSTAIRS
- WALKING_DOWNSTAIRS
- SITTING
- STANDING
- LAYING

The complete list of variables of each feature vector is available in 'features.txt.'

## First dataset

The script first creates a dataset ('samsung') by combining the training and test datasets and taking a subset of the measurements. The 'samsung' dataframe is created in the following steps:

- the training and test datasets are read into dataframes
- the variable names are added from the 'features.txt' file
- the variables subset to include only those containing the mean and standard deviation. Note: All measurements are normalized and bounded within [-1,1]
- the test and training sets are merged
- the names of the activities are read from 'activity_labels.txt' and the 'activity' variable is made a factor with these labels.

## Second dataset

The script nexts creates a summary of the first dataset by calculating the mean of each measurement by subject and activity. The resulting dataframe ('samsum') is written to a text file ('Samsung_Avg.txt').

