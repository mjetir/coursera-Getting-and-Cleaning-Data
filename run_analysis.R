#Read the measurement data. The data are assumed to be in the working directory.
X_test<-read.table("UCI HAR Dataset/test/X_test.txt",header=FALSE)
X_train<-read.table("UCI HAR Dataset/train/X_train.txt",header=FALSE)

#Read the features data and set the features as column names to the measurement data.
features<-read.table("features.txt",header=FALSE)
colnames(X_test)<-features$V2
colnames(X_train)<-features$V2

#Extract only the measurements on the mean and standard deviation for each measurement.
indeces<-sort(c(grep("mean\\(\\)",features$V2),grep("std\\(\\)",features$V2)))
X_test<-X_test[,indeces]
X_train<-X_train[,indeces]

#Read the subject data and give an appropriate variable name.
subject_test<-read.table("test/subject_test.txt",header=FALSE)
subject_train<-read.table("train/subject_train.txt",header=FALSE)
colnames(subject_test)<-"subject"
colnames(subject_train)<-"subject"

#Read the activity data and replace the activity codes by descriptive activity names.
activity_labels<-read.table("activity_labels.txt",header=FALSE)
y_test<-read.table("test/y_test.txt",header=FALSE)
y_train<-read.table("train/y_train.txt",header=FALSE)
colnames(y_test)<-"activity"
colnames(y_train)<-"activity"
y_test$activity<-activity_labels$V2[y_test$activity]
y_train$activity<-activity_labels$V2[y_train$activity]

#Create variable that tells to which group (test or train) the measurement belongs. 
#Set the variable values for the test data.
set<-rep("test",nrow(X_test))
#Combine subject labels, group labels (test or train), activities and measurements 
#of test data into one data set.
test<-cbind(subject_test,set,y_test,X_test)
#Create variable that tells to which group (test or train) the measurement belongs. 
#Set the variable values for the train data.
set<-rep("train",nrow(X_train))
#Combine subject labels, group labels, activities and measurements of train data 
#into one data set.
train<-cbind(subject_train,set,y_train,X_train)

#Merge the test and train data.
data<-rbind(test,train)

#Modify the variable names of the measurements so that they are more human readable.
variables<-colnames(data[,4:69])
variables<-gsub("\\(\\)", "",variables)
variables<-gsub("BodyBody", "Body",variables)
variables<-gsub("^t","time",variables)
variables<-gsub("^f","frequency",variables)
variables<-gsub("Acc", "Accelerometer",variables)
variables<-gsub("Gyro", "Gyroscope",variables)
variables<-gsub("Mag", "Magnitude",variables)
colnames(data)<-c(colnames(data[,1:3]),variables)

#Create a data set with the average of each variable for each activity and each subject.
data2<-aggregate(data[4:69],by=list(data$subject,data$activity),FUN=mean)
#Set appropriate variable names.
colnames(data2)<-c("subject","activity",paste(rep("mean-of-",length(data[4:69])),
                                              colnames(data[4:69]),sep=""))

write.table(data2,"tidyData.txt",row.name=FALSE)
