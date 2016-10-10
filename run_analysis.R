library(stringr)
library(dplyr)
library(reshape2)
options(stringsAsFactors=FALSE)
#Clear environment
rm(list = ls())
# Start the clock
ptm <- proc.time()
#set working directory!!! CHANGE AS REQUIRED!!!!
setwd("f:/coursera/ucihar/")
#Test and Training directories
testdir<-"./test/"
trainingdir<-"./train/"
#Read input files into Dataframes
xTestDF<-data.frame(fread(paste(testdir,"X_test.txt",sep=""), nrows=2947 ,header=FALSE))
yTestDF<-data.frame(fread(paste(testdir,"y_test.txt",sep=""), nrows=2947,header=FALSE))
sTestDF<-data.frame(fread(paste(testdir,"subject_test.txt",sep=""), nrows=2947 ,header=FALSE))
xTrainingDF<-data.frame(fread(paste(trainingdir,"X_train.txt",sep=""), nrows=7352  ,header=FALSE))
yTrainingDF<-data.frame(fread(paste(trainingdir,"y_train.txt",sep=""), nrows=7352 ,header=FALSE))
sTrainingDF<-data.frame(fread(paste(trainingdir,"subject_train.txt",sep=""), nrows=7352  ,header=FALSE))
featureDF<-data.frame(fread("features.txt", nrows=561,header=FALSE))
activityDF<-data.frame(fread("activity_labels.txt", nrows=6 ,header=FALSE))

# The next three sections will be used to create lookup tables to be used later on in script
#Create a lookup table of subject IDs and a description of Subject Type Training or Testing
trainingDF<-data.frame("subjectID"=unique(sTrainingDF$V1),"Dataset"="Training")
testDF<-data.frame("subjectID"=unique(sTestDF$V1),"Dataset"="Test")
subjectDF<-arrange(rbind(trainingDF,testDF),subjectID)

#Create the tidy lookup table of ID and Descriptions for the activities.
colnames(activityDF)<-c("ID" , "Description")

#Create a lookup table with SEARCH terms for grep functions and correspinging COLUMNS and VALUES.
scvDF<-data.frame(search=c("^t","^f","^a","Acc","Gyro","Body","Gravity","X","Y","Z","Jerk","Mag","mean","Mean","std"),
                   column=c("Domain","Domain","Domain","Sensor","Sensor","Signal Component","Signal Component","Axis","Axis","Axis","Jerk","Magnitude","Measurement","Measurement","Measurement"),
                   value=c("Time","Frequency(Hz)","Frequency (Rad/s)","Accelerometer","Gyroscope","Body","Gravity","X","Y","Z",FALSE,FALSE,"Mean","Mean","SD"))

#Subset the featured Dataframe to only include mean and Standard Deviation (SD) values
featureDF<-featureDF[grepl("mean|Mean|std",featureDF$V2),]

#Merge datasets first by columns and then by rows. Subset to only exclude the mean and std variables.
trainingDF<-cbind(sTrainingDF,yTrainingDF,xTrainingDF[,featureDF$V1])
testDF<-cbind(sTestDF,yTestDF,xTestDF[,featureDF$V1])
mergeDF<-rbind(trainingDF,testDF)

#Rename columns
colnames(mergeDF)<-c("subjectID", "Activity",featureDF$V2)

#Attach activity labels
mergeDF$Activity <- activityDF[,2][match(mergeDF$Activity , activityDF[,1])]

#Determine the mean by subjectID and activity
meanDF<-aggregate(x=mergeDF[3:88],by=list("subjectID"=as.factor(mergeDF$subjectID),"Activity"=as.factor(mergeDF$Activity)),FUN="mean")
meanDF<-arrange(meanDF,subjectID,Activity)

#Use Melt function to narrow the number of dataframe columns - (from reshape library )
meltDF<-melt(meanDF,id=1:2,measure=3:88)

#Using the Variable column in Tidy Dataframe, separate into different features.
meltDF[c("Measurement","Domain","Sensor","Signal Component","Axis","Jerk","Magnitude")]<-NA

#Fill the columns using the grep function. scvDF is a lookup table with search strings, values and column names
for (i in 1:15) {
meltDF[,paste(scvDF$column[i])][grep(paste(scvDF$search[i]),meltDF$variable)]=paste(scvDF$value[i])
}

#Reorder columns
meltDF<-meltDF[,c("subjectID","Activity","Signal Component","Sensor","Domain","Axis","Jerk","Magnitude","variable","Measurement","value")]

#Add Set column
meltDF<-merge(meltDF,subjectDF,by.x="subjectID")
meltDF<-meltDF[c(1,12,2:11)]

#Sort the dataframe 
meltDF<-arrange(meltDF,subjectID,Activity)
meltDF$variable<-NULL
# Create the tidy Dataframe and format the Activity variable
tidyDF<-meltDF[c(1:7,10:11)]
tidyDF$Activity<-gsub("_"," ",tidyDF$Activity)
tidyDF$Activity<-str_to_title(tidyDF$Activity)
tidyDF$Activity<-gsub(" ","",tidyDF$Activity)

# Stop the clock
proc.time() - ptm
