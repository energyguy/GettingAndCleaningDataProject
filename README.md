##Getting and Cleaning Data Project

In partial fulfilment of the Johns Hopkins University and Coursera course - Getting and Cleaning Data.  
 
###Abstract
run_analysis.R is an R script that reads training and test datasets from the UCI machine learning repository,
 in text file formats, processes it and outputs a tidy dataset which can be used for further analysis and/or visualisation.
 
###Instructions.
1) Download datasets folder from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip .
   Unpack to a drive of your choice.
2) Contents of datasets folder.
The 'UCI HAR Dataset' folder contains two subfolders - test and train as well as following text files:
+ activity_labels.txt
+ features.txt
+ features_info.txt
+ README.txt (Please reference this file for more detailed information regarding UCI HAR)

#####The test subfolder contains:
+ Inertial Signals subfolder
+ subject_test.txt
+ X_test.txt
+ y_test.txt

#####The train subfolder contains:
+ Inertial Signals subfolder
+ subject_train.txt
+ X_train.txt
+ y_train.txt

Note! The Inertial subfolders contain raw signal data that will not be used in the run_analysis.R script

3) Open the run_analysis.R script in R GUI or RStudio.

4) Please ensure that that the following packages are installed.
+ data.table_1.9.7 !!! fwrite function uses development version. Follow download instructions here   https://github.com/Rdatatable/data.table/wiki/Installation
+ reshape2_1.4.1 
+ dplyr_0.5.0 
+ stringr_1.1.0   

5) Set the working directory by editing the setwd("workingdir") statement on line 9 with the path of the dataset folder downloaded in step 1.

6) Run script.

7) The tidyDF dataframe is exported, using the fwrite function, to tidyDF.csv which will be located in the working directory.

8) To view datasets use notepad++ which can be downloaded from https://notepad-plus-plus.org/download/v7.html




