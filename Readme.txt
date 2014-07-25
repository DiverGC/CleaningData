------------------------------
GENERAL SCRIPT INFO
------------------------------
This script takes data from the UCI HAR Dataset and outputs the average of the mean and standard deviation for 
various measurments of each activity(6) for each subject(30).  The working directory shall be the UCI HAR Dataset 
directory.  Put the script into the unzipped working directory to ensure its functionality.  The files used by the
 script include activity_labels.txt, features.txt, subject_test.txt,  subject_train.txt, X_test, y_test, X_train 
and y_train.  The output does not label test and train data since there was no requirement to do it and we are 
not comparing the two as far as this assignment is concerned.

------------------------------
HOW THE SCRIPT WORKS
------------------------------
The script starts by merging the data in the test folder(subject_test, X_test,y_test) into one file.  
The data in the train folder(subject_train, X_train, y_train) is merged into another file.  Both files are then 
combined.  The y_train and y_test values are translated from numbers to activity.  The column names are imported 
from the features file.  The script next creates a new dataset with all the relevant mean and standard deviation 
columns.  For each activity that a person performs, the average mean and standard deviation is also calculated.  
The last lines of code renames the columns into something meaningful and writes the now tidy data to a csv file 
in the working directory.  Sensor acceleration is divided into body and gravity acceleration.  meanFreq() signals 
were excluded as it is the weighted average of the frequency components. It is not a true mean. The angle data 
was also not used since it was the angle between two vectors and does not give the mean value itself.

------------------------------
RAW DATA INFO
------------------------------
This experiment was conducted by Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and 
Jorge L. Reyes-Ortiz and published as "Human Activity Recognition on Smartphones using a Multiclass 
Hardware-Friendly Support Vector Machine" by International Workshop of Ambient Assisted Living (IWAAL 2012), 
Vitoria-Gasteiz, Spain, Dec 2012.  The raw data came from 30 volunteers performing 6 activities, where 70% of the 
volunteers generated training data.  The remaining 30% generated test data.  For each activity that a volunteer 
performed, three axial accelerometer and gyroscope data were collected and processed.  More details about the 
processing is described in the features_info.txt file.  The files in this raw data set include(all type .txt): 
activity_labels, features, features_info, README, subject_test, X_test, y_test, subject_train, X_train, y_train, 
body_acc_x_train, body_acc_y_train, body_acc_z_train, body_gyro_x_train, body_gyro_y_train, body_gyro_z_train, 
total_acc_x_train, total_acc_y_train, total_acc_z_train, body_acc_x_test, body_acc_y_test, body_acc_z_test, 
body_gyro_x_test, body_gyro_y_test, body_gyro_z_test, total_acc_x_test, total_acc_y_test, and total_acc_z_test.
