## Study design

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

## Data dictionary
The tidy data 14220 rows that correspond to each unique set of `subject_id`, `activity`, and `measurement`.

There are four variables/columns in the tidy data. The columns in the output file are as follows:

* subject_id [integer] - The subject who performed the activity
  * Values:
    * 1..30
* activity [character] - The activity performed
  * Values:
    * walking 
    * walking_upstairs
    * walking_downstairs
    * sitting
    * standing
    * laying
* measurement [character] - The measurement type
  * Values:
    * frequency_body_acceleration_mean_x
    * frequency_body_acceleration_mean_y
    * frequency_body_acceleration_mean_z
    * frequency_body_acceleration_meanfreq_x
    * frequency_body_acceleration_meanfreq_y
    * frequency_body_acceleration_meanfreq_z
    * frequency_body_acceleration_std_x
    * frequency_body_acceleration_std_y
    * frequency_body_acceleration_std_z
    * frequency_body_acceleration_jerk_mean_x
    * frequency_body_acceleration_jerk_mean_y
    * frequency_body_acceleration_jerk_mean_z
    * frequency_body_acceleration_jerk_meanfreq_x
    * frequency_body_acceleration_jerk_meanfreq_y
    * frequency_body_acceleration_jerk_meanfreq_z
    * frequency_body_acceleration_jerk_std_x
    * frequency_body_acceleration_jerk_std_y
    * frequency_body_acceleration_jerk_std_z
    * frequency_body_acceleration_mag_mean
    * frequency_body_acceleration_mag_meanfreq
    * frequency_body_acceleration_mag_std
    * frequency_body_acceleration_jerk_mag_mean
    * frequency_body_acceleration_jerk_mag_meanfreq
    * frequency_body_acceleration_jerk_mag_std
    * frequency_body_gyroscope_scope_jerk_mag_mean
    * frequency_body_gyroscope_scope_jerk_mag_meanfreq
    * frequency_body_gyroscope_scope_jerk_mag_std
    * frequency_body_gyroscope_scope_mag_mean
    * frequency_body_gyroscope_scope_mag_meanfreq
    * frequency_body_gyroscope_scope_mag_std
    * frequency_body_gyroscope_scope_mean_x
    * frequency_body_gyroscope_scope_mean_y
    * frequency_body_gyroscope_scope_mean_z
    * frequency_body_gyroscope_scope_meanfreq_x
    * frequency_body_gyroscope_scope_meanfreq_y
    * frequency_body_gyroscope_scope_meanfreq_z
    * frequency_body_gyroscope_scope_std_x
    * frequency_body_gyroscope_scope_std_y
    * frequency_body_gyroscope_scope_std_z
    * time_body_acceleration_mean_x
    * time_body_acceleration_mean_y
    * time_body_acceleration_mean_z
    * time_body_acceleration_std_x
    * time_body_acceleration_std_y
    * time_body_acceleration_std_z
    * time_body_acceleration_jerk_mean_x
    * time_body_acceleration_jerk_mean_y
    * time_body_acceleration_jerk_mean_z
    * time_body_acceleration_jerk_std_x
    * time_body_acceleration_jerk_std_y
    * time_body_acceleration_jerk_std_z
    * time_body_acceleration_jerk_mag_mean
    * time_body_acceleration_jerk_mag_std
    * time_body_acceleration_mag_mean
    * time_body_acceleration_mag_std
    * time_body_gyroscope_scope_mean_x
    * time_body_gyroscope_scope_mean_y
    * time_body_gyroscope_scope_mean_z
    * time_body_gyroscope_scope_std_x
    * time_body_gyroscope_scope_std_y
    * time_body_gyroscope_scope_std_z
    * time_body_gyroscope_scope_jerk_mean_x
    * time_body_gyroscope_scope_jerk_mean_y
    * time_body_gyroscope_scope_jerk_mean_z
    * time_body_gyroscope_scope_jerk_std_x
    * time_body_gyroscope_scope_jerk_std_y
    * time_body_gyroscope_scope_jerk_std_z
    * time_body_gyroscope_scope_jerk_mag_mean
    * time_body_gyroscope_scope_jerk_mag_std
    * time_body_gyroscope_scope_mag_mean
    * time_body_gyroscope_scope_mag_std
    * time_gravity_acceleration_mean_x
    * time_gravity_acceleration_mean_y
    * time_gravity_acceleration_mean_z
    * time_gravity_acceleration_std_x
    * time_gravity_acceleration_std_y
    * time_gravity_acceleration_std_z
    * time_gravity_acceleration_mag_mean
    * time_gravity_acceleration_mag_std
* avg_value [numeric] - Mean of the value for each unique set of subject_id, 
activity, and measurement
  * Values:
    *  -0.9976661..0.9745087

## Methodology
1. Load the data files:
	1. Training files

		```r
		x_train <- read.table("UCI\ HAR\ Dataset/train/X_train.txt")
		y_train <- read.table("UCI\ HAR\ Dataset/train/y_train.txt")
		s_train <- read.table("UCI\ HAR\ Dataset/train/subject_train.txt")
		```

	2. Testing files

		```r
		x_test <- read.table("UCI\ HAR\ Dataset/test/X_test.txt")
		y_test <- read.table("UCI\ HAR\ Dataset/test/y_test.txt")
		s_test <- read.table("UCI\ HAR\ Dataset/test/subject_test.txt")
		```

	3. Features

		```r
		label_names = read.table("UCI\ HAR\ Dataset/features.txt", 
	                         colClasses = c("NULL",NA), 
	                         stringsAsFactors=FALSE)
		```

	4. Activities

		```r
		activity_labels = read.table("UCI\ HAR\ Dataset/activity_labels.txt", 
	                         stringsAsFactors=FALSE)
		```

2. Merge the data frames
	1. `cbind` the train data frames

		```r
		train <- cbind(x_train, y_train, s_train)
		```

	2. `cbind` the test data frames

		```r
		test <- cbind(x_test, y_test, s_test)
		```

	3. `rbind` the train and test data frames into `total_data`

		```r
		total_data <- rbind(train, test)
		```

	4. Rename the columns to names from the features
		1. Add in `activity_id` and `subject_id` respectively to reflect Y and 
		subject data frames

			```r
			colnames(total_data) <- c(label_names$V2, "activity_id", "subject_id")
			
			```

	5. Rename the columns of the `activity_labels` data frame
		
		```r
		colnames(activity_labels) <- c("activity_id", "activity")
		```

3. Extract the columns of interest
	1. Fix the column names to make them unique. This collapses all names to 
	valid R names by replacing each invalid character to a ".".

		```r
		valid_column_names <- make.names(names=names(total_data), unique = TRUE)
		names(total_data) <- valid_column_names
		```

	2. Add in the activity name to `total_data`
		
		```r
		total_data <- left_join(total_data, activity_labels, by="activity_id")
		```

	3. Extract any column that has "mean" or "std" in the column name
	4. Extract the `activity` and `subject_id` columns
	5. Remove any column that has "angle" in the name. Note that "meanFreq" 
	columns are not removed.
	6. Store the resulting data frame into `mean_std_data`

		```r
		mean_std_data <- total_data %>% 
	  		select(matches(".*(mean|std)|^activity$|^subject_id$")) %>%
	  		select(-matches("^(.*angle).*$"))
	  	```

4. Create the tidy data set
	1. Clean the column names from `mean_std_data`
	2. Gather all the "feature" columns into the key-value pair `measurement` 
	and `value`
	3. Group the records by `subject_id`, `activity`, and `measurement`
	4. Calculate the mean for each unique set of `subject_id`, `activity`, and 
	`measurement`
	5. Sort by `subject_id`, `activity`, and `measurement`
	6. Store the data into `tidy_data`

		```r
		tidy_data <- mean_std_data %>% 
	  		clean_names() %>% 
	  		gather(measurement, value, tbodyacc_mean_x:fbodybodygyrojerkmag_meanfreq) %>% 
	  		group_by(subject_id,activity,measurement) %>% 
	  		summarise(avg_value=mean(value)) %>% 
	  		arrange(subject_id, activity, measurement)
	  	```

	7. Make the measurements more descriptive

	  	```r
		tidy_data$measurement <- gsub("^f","frequency_", tidy_data$measurement) 
		tidy_data$measurement <- gsub("^t","time_", tidy_data$measurement) 
		tidy_data$measurement <- gsub("(body){2}","body_", tidy_data$measurement) 
		tidy_data$measurement <- gsub("acc","acceleration_", tidy_data$measurement) 
		tidy_data$measurement <- gsub("(body)([a-z])","body_\\2", tidy_data$measurement)
		tidy_data$measurement <- gsub("(gyro)","gyroscope_", tidy_data$measurement)
		tidy_data$measurement <- gsub("(gravity)","gravity_", tidy_data$measurement)
		tidy_data$measurement <- gsub("(jerk)","jerk_", tidy_data$measurement)
		tidy_data$measurement <- gsub("(_){2}","_", tidy_data$measurement)
	  	```

5. Write the tidy data to file

	```r
	write.table(tidy_data, "tidy_data.txt", row.name = FALSE)
	```

6. Clean up

	```r
	rm(test, train, x_test, x_train, y_test, y_train, s_test, s_train, 
  		activity_labels, label_names, mean_std_data, total_data, valid_column_names)
  	```

## More information
More information can be found in the `README.md` file or in the 
`features_info.txt` file included in the [project data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)