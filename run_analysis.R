library(data.table)
library(reshape2)

fileurl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
download.file(fileurl, file.path('./data', 'datafile.zip'))
unzip(zipfile = "datafiles.zip")

activity_labels <- fread('./data/activity_labels.txt', col.names = c('level', 'activitytype'))
feature <- fread('./data/features.txt', col.names = c('index', 'featurename'))

featurewant <- grep(pattern = "(mean|std)\\(\\)", feature[, featurename])
measurements <- feature[featurewant, featurename]
measurements <- gsub('[()]', '', measurements)

trainX <- fread('./data/train/X_train.txt')[, featurewant, with = FALSE]
setnames(trainX, colnames(trainX), measurements)
trainY<- fread("./data/train/Y_train.txt", col.names = c("activity"))
trainsubject <- fread("./data/train/subject_train.txt", col.names = c('subject'))
train <- cbind(trainsubject, trainY, trainX)

testX <- fread('./data/test/X_test.txt')[, featurewant, with=FALSE]
setnames(testX, colnames(testX), measurements)
testY<- fread("./data/test/Y_test.txt", col.names = c("activity"))
testsubject <- fread("./data/test/subject_test.txt", col.names = c('subject'))
test <- cbind(testsubject, testY, testX)

cDT <- rbind(train, test)

cDT$activity <- factor(cDT$activity,
                       levels = activity_labels$level,
                       labels = activity_labels$activitytype
)

cDT <- melt(cDT, id = c('subject', 'activity'))
cDT <- dcast(cDT, subject + activity ~ variable, fun.aggregate = mean)

fwrite(x = cDT, file = "tidyData.txt", quote = FALSE)