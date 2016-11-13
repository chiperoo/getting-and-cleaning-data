# This script is assuming that the files are downloaded and unzipped.
# The script will then operate based on the assumption that the script and
# unzipped data directory are at the same path

# load the required libraries
library(dplyr)
library(janitor)
library(tidyr)

######################
# 1. Load the data files
######################
# read in the train files
x_train <- read.table("UCI\ HAR\ Dataset/train/X_train.txt")
y_train <- read.table("UCI\ HAR\ Dataset/train/y_train.txt")
s_train <- read.table("UCI\ HAR\ Dataset/train/subject_train.txt")

# read in the test files
x_test <- read.table("UCI\ HAR\ Dataset/test/X_test.txt")
y_test <- read.table("UCI\ HAR\ Dataset/test/y_test.txt")
s_test <- read.table("UCI\ HAR\ Dataset/test/subject_test.txt")

# read in the column labels; skip first column
label_names = read.table("UCI\ HAR\ Dataset/features.txt", 
                         colClasses = c("NULL",NA), 
                         stringsAsFactors=FALSE)

# read in the activity labels
activity_labels = read.table("UCI\ HAR\ Dataset/activity_labels.txt", 
                        stringsAsFactors=FALSE)

######################
# 2. Merge data frames
######################
# cbind each set of train and test data frames
train <- cbind(x_train, y_train, s_train)
test <- cbind(x_test, y_test, s_test)

# merge train and test data frames
total_data <- rbind(train, test)

# set the column names
colnames(total_data) <- c(label_names$V2, "activity_id", "subject_id")
colnames(activity_labels) <- c("activity_id", "activity")



######################
# 3. Extract columns of interest
######################
# fix column names to make them unique
valid_column_names <- make.names(names=names(total_data), unique = TRUE)
names(total_data) <- valid_column_names

# add in the activity name to total data
total_data <- left_join(total_data, activity_labels, by="activity_id")

# get all columns that have either "mean" or "std" or "activity" or "subject_id"
# in the name
# remove the columns that have "angle" in the name
mean_std_data <- total_data %>% 
  select(matches(".*(mean|std)|^activity$|^subject_id$")) %>%
  select(-matches("^(.*angle).*$"))

# make the activity all lower case
mean_std_data$activity <- tolower(mean_std_data$activity)

######################
# 4. Create the tidy data set
######################
tidy_data <- mean_std_data %>% 
  clean_names() %>% 
  gather(measurement, value, tbodyacc_mean_x:fbodybodygyrojerkmag_meanfreq) %>% 
  group_by(subject_id,activity,measurement) %>% 
  summarise(avg_value=mean(value)) %>% 
  arrange(subject_id, activity, measurement)

# make the measurements more descriptive
tidy_data$measurement <- gsub("^f","frequency_", tidy_data$measurement) 
tidy_data$measurement <- gsub("^t","time_", tidy_data$measurement) 
tidy_data$measurement <- gsub("(body){2}","body_", tidy_data$measurement) 
tidy_data$measurement <- gsub("acc","acceleration_", tidy_data$measurement) 
tidy_data$measurement <- gsub("(body)([a-z])","body_\\2", tidy_data$measurement)
tidy_data$measurement <- gsub("(gyro)","gyroscope_", tidy_data$measurement)
tidy_data$measurement <- gsub("(gravity)","gravity_", tidy_data$measurement)
tidy_data$measurement <- gsub("(jerk)","jerk_", tidy_data$measurement)
tidy_data$measurement <- gsub("(_){2}","_", tidy_data$measurement)

######################
# 5. Write tidy data to file
######################
write.table(tidy_data, "tidy_data.txt", row.name = FALSE)

######################
# 6. Clean up
######################
rm(test, train, x_test, x_train, y_test, y_train, s_test, s_train, 
  activity_labels, label_names, mean_std_data, total_data, valid_column_names)
