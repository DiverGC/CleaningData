#-----------------------------
#TEST FOLDER
#-----------------------------

#File locations
subject_test_location="./test/subject_test.txt"
test_X_location="./test/X_test.txt"
test_y_location="./test/y_test.txt"

#Reading files
subject_test_table=read.table(subject_test_location, sep="")
test_X_table=read.table(test_X_location, sep="")
test_y_table=read.table(test_y_location, sep="")

#Merging files
test_compilation=cbind(subject_test_table,test_y_table)
test_compilation=cbind(test_compilation,test_X_table)

#-----------------------------
#TRAIN FOLDER
#-----------------------------

#File locations
subject_train_location="./train/subject_train.txt"
train_X_location="./train/X_train.txt"
train_y_location="./train/y_train.txt"

#Reading files
subject_train_table=read.table(subject_train_location, sep="")
train_X_table=read.table(train_X_location, sep="")
train_y_table=read.table(train_y_location, sep="")

#Merging files
train_compilation=cbind(subject_train_table,train_y_table)
train_compilation=cbind(train_compilation,train_X_table)

#-----------------------------
#MERGING BOTH FILES
#-----------------------------
data=rbind(train_compilation,test_compilation)

#-----------------------------
#TRANSLATING y_train AND y_test VALUES
#-----------------------------

data[,2]=as.character(data[,2])
for(i in 1:nrow(data)){
	if(data[i,2]=="1"){
		data[i,2]=gsub("1","WALKING",data[i,2])
	} else if(data[i,2]=="2"){
		data[i,2]=gsub("2","WALKING_UPSTAIRS",data[i,2])
	} else if(data[i,2]=="3"){
		data[i,2]=gsub("3","WALKING_DOWNSTAIRS",data[i,2])
	} else if(data[i,2]=="4"){
		data[i,2]=gsub("4","SITTING",data[i,2])
	} else if(data[i,2]=="5"){
		data[i,2]=gsub("5","STANDING",data[i,2])
	} else if(data[i,2]=="6"){
		data[i,2]=gsub("6","LAYING",data[i,2])
	}
}

#-----------------------------
#INITIAL LABELLING COLUMNS
#-----------------------------

#Label first 2 columns
colnames(data)[1]="Subject"
colnames(data)[2]="Activity"

#Location of other column names
col_names_location="./features.txt"


#Read NAMES ONLY into file
name_files=read.table(col_names_location, sep=" ",stringsAsFactors=FALSE)[,2]

#Name column
for (i in 1:length(data)){
	if(i>2){
		colnames(data)[i]=name_files[i-2]
	}
}

#-----------------------------
#EXTRACT MEAN AND STANDARD DEVIATION COLUMNS
#-----------------------------

#Copy the columns with subject and activity
data2=data[,1:2]

#Search columns for text "mean()" and "std()"
data1=data[,grep("mean\\(\\)|std()", colnames(data))]

#Merge the two tabl
data3=cbind(data2,data1)

#-----------------------------
#SUMMARIZING MEAN EACH SUBJECT'S ACTIVITY'S
#-----------------------------
#Split by subject and activity

library(plyr)
results=ddply(data3,.(Subject,Activity),numcolwise(mean))

#-----------------------------
#RENAME COLUMNS
#-----------------------------
names1=gsub("^t","TimeDomainFor",colnames(results))
names2=gsub("^f","FrequencyDomainFor",names1)
names3=gsub("Acc","Acceleration,",names2)
names4=gsub("-mean()","MeanValue",names3,fixed="TRUE")
names5=gsub("-std()","StandardDeviationValue",names4,fixed="TRUE")
names6=gsub("-X","ForXAxis",names5)
names7=gsub("-Y","ForYAxis",names6)
names8=gsub("-Z","ForZAxis",names7)
names9=gsub("Gyro","Gyroscope,",names8)
names10=gsub("Mag","Magnitude",names9)
names11=gsub("BodyBody","Body",names10)
colnames(results)=names11
write.csv(results, file = "Project.csv",row.names=FALSE)
