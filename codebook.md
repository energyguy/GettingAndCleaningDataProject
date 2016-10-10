## Codebook - UCI - Human Activity Recognition Datasets
###Data Dictionary
Variable name	
Variable Description
                    Data	
*Table 1: Arrangement of variables, description and Data as presented below.*


####subjectID			
*Identification number of subjects who participated in the experiment*
> 1..30

####Dataset			
#####Dataset Category#####        
* Test  
* Training

####Activity			
#####Types of activities performed by subjects.  
* WALKING	
* WALKING_UPSTAIRS	
* WALKING_DOWNSTAIRS	
* SITTING	
* STANDING	
* LAYING	

####Signal Component			
#####Components of the sensor acceleration signal.    	
* Body	
* Gravity	

####Sensor			
#####Type of embedded sensor that generated measurement.  	
* Accelerometer	
* Gyroscope	

####Domain			
#####Domain in which signal is processed.  	
* Time 	
* Frequency(Rad/s)	
* Frequency(Hz)	

####Axis			
#####Direction of movement.  	
* NA	
* X	
* Y	
* Z	

####Measurement			
#####Statistical measurement calculation type. 	
* Mean	
* SD (Standard Deviation	
    
####Jerk
#####Second derivative of acceleration  	
* TRUE	
* FALSE	
    
####Magnitude			
    
* TRUE	
* FALSE	
    
####Value	 
#####Value of Mean or Standard Deviation measurement.  	
* -0.99767 .. 0.97451	
*Units are in Seconds(s), Radians per second (Rad/s) and Hertz (Hz) depending on the value of the domain variable.*   
    
###Transformation and Work
1) Training datasets were combined by columns.
2) Test datasets were combined by columns.
3) Resulting two datasets were subsetted to only include the mean and standard variables and then combined by rows into one dataset.
4) Activity codes 1:6 were replaced by descriptive labels.
5) The aggregate value of the observations was determined based on activity and subject.
6) The dataset was reshaped, to make it narrower using the melt function.
7) Features were extracted from the composite features variable produced by the melt function and separated into 8 variables. Descriptive labels were then added to the variables.
8) The original dataset (training or test) was determined and stored in the set variable.
9) Observations were arranged by subject ID and Activity.
10) The Activity Variable was reformatted using function str_to_title from the stringr library.
11) The tidy Dataframe - tidyDF was exported to a csv file - tidyDF.csv using the fwrite() function from the data.table development package.


####Summary  
![summary-tidydf](https://cloud.githubusercontent.com/assets/21977957/19243829/3c06ed88-8f11-11e6-8566-7161f4e47b19.jpg)


####tidyDF Dataframe structure

![str-tidydf](https://cloud.githubusercontent.com/assets/21977957/19243833/42c4d086-8f11-11e6-9696-011449b32ced.JPG)
