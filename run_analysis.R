# Project for Getting and Cleaning Data

library("readr")
library("dplyr")

# test set
test <- read_table('./UCI HAR Dataset/test/X_test.txt',col_names=FALSE)

str(test)

# supply variable names for test
varnames <- read.csv('./UCI HAR Dataset/features.txt',header=FALSE, sep = ' ')
head(varnames)
names(test) <- varnames[,2]

ytest <- read.csv('./UCI HAR Dataset/test/y_test.txt',header=FALSE)
names(ytest) <- c('activity')

subj_test <- read.csv('./UCI HAR Dataset/test/subject_test.txt',header=FALSE)
names(subj_test) <- c('subject')

# names(test)[!duplicated(names(test))]

test2 <- test[,names(test)[!duplicated(names(test))]]

test2a <- test2 %>%
    select(contains('mean()',ignore.case = FALSE))

test2b <- test2 %>%
    select(contains('std()',ignore.case = FALSE))


# training set
train <- read_table('./UCI HAR Dataset/train/X_train.txt',col_names=FALSE)

str(train)

# supply variable names for train
names(train) <- varnames[,2]

ytrain <- read.csv('./UCI HAR Dataset/train/y_train.txt',header=FALSE)
names(ytrain) <- c('activity')

subj_train <- read.csv('./UCI HAR Dataset/train/subject_train.txt',header=FALSE)
names(subj_train) <- c('subject')

train2 <- train[,names(train)[!duplicated(names(train))]]

train2a <- train2 %>%
    select(contains('mean()',ignore.case = FALSE))

train2b <- train2 %>%
    select(contains('std()',ignore.case = FALSE))

#combine datasets
test3 <- cbind(ytest,test2a,test2b,subj_test)
train3 <- cbind(ytrain,train2a,train2b,subj_train)
samsung <- rbind(test3,train3)

#label activity
activity_name <- read.csv('./UCI HAR Dataset/activity_labels.txt',header=FALSE,sep = ' ')
names(activity_name) <- c('activity','label')
samsung$activity <- factor(samsung$activity,labels = activity_name$label)
samsung$subject <- factor(samsung$subject)
str(samsung)

#clean up
rm(test2a)
rm(test2b)
rm(train2a)
rm(train2b)
rm(test)
rm(train)
rm(test2)
rm(train2)
rm(subj_test)
rm(subj_train)
rm(test3)
rm(train3)
rm(ytest)
rm(ytrain)
rm(varnames)
rm(activity_name)

# create summary dataset
samsum <- samsung %>%
    group_by(subject,activity) %>%
    summarise_each(funs(mean))
head(samsum)

write.table(samsum,'Samsung_Avg.txt',row.names=FALSE)

