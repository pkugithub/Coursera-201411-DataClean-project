
# 1. Merges the training and the test sets to create one data set.

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destfile <- "getdata-projectfiles-UCI_HAR_Dataset.zip"

print("Downloading zipped data file bundle...")
download.file(url, destfile, quiet = TRUE, method="curl")

print("Unzipping data file bundle...")
unzip(destfile)

print("Perform data cleansing and manipulation...")
      
df_activity_labels_text <- read.table("./UCI HAR Dataset/activity_labels.txt")

df_X_test_txt       <- read.table("./UCI HAR Dataset/test/X_test.txt")
df_subject_test_txt <- read.table("./UCI HAR Dataset/test/subject_test.txt")
df_y_test_txt       <- read.table("./UCI HAR Dataset/test/y_test.txt")

df_X_train_txt        <- read.table("./UCI HAR Dataset/train/X_train.txt")
df_subject_train_txt  <- read.table("./UCI HAR Dataset/train/subject_train.txt")
df_y_train_txt        <- read.table("./UCI HAR Dataset/train/y_train.txt")

# df_X_test <- cbind(df_subject_test_txt, df_X_test_txt)
# df_X_train <- cbind(df_subject_train_txt, df_X_train_txt)

df_X <- rbind(df_X_test_txt , df_X_train_txt )

df_features_txt <- read.table("./UCI HAR Dataset/features.txt")
column_names <- as.character( df_features_txt[,2]) 
colnames(df_X) <- column_names

df_subject <- rbind(df_subject_test_txt, df_subject_train_txt)
colnames(df_subject) <- "subjectId"

df_activity_labels <- df_activity_labels_text
colnames(df_activity_labels) <- c("actId", "actName")

df_y <- rbind(df_y_test_txt, df_y_train_txt)
colnames(df_y) <- "actId"

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
mean_std_indices <- grep("-mean\\(\\)|-std\\(\\)", column_names)

column_names_indexed <- column_names[mean_std_indices]  # for debugging
df_X_mean_std <- df_X[, mean_std_indices]

# 3. Uses descriptive activity names to name the activities in the data set
colnames(df_X_mean_std) <- sub('\\.\\.', '', make.names( colnames(df_X_mean_std )) )

# 4. Appropriately labels the data set with descriptive variable names. 
colnames(df_X_mean_std) <- sub('^t', 'time.', colnames(df_X_mean_std))
colnames(df_X_mean_std) <- sub('^f', 'freq.', colnames(df_X_mean_std))

column_names_pretty <- colnames(df_X_mean_std) 

df_y_merged  <- merge(df_y, df_activity_labels, by = "actId")

df_result1 <- cbind(df_subject, df_y_merged[,"actName"], df_X_mean_std)
colnames(df_result1)[2] <- "actName"

# 5. From the data set in step 4, creates a second, independent tidy data set with 
#    the average of each variable for each activity and each subject.

library(dplyr)

df_result_group_by_subject_act <- df_result1 %>%
  group_by(subjectId, actName) %>%
  summarise_each( funs(mean) ) %>%
  arrange(subjectId, actName)

outfile <- "result_group_by_subject_act.txt"
write.table(df_result_group_by_subject_act, file=outfile , row.names = FALSE)

print(paste("Done - result is stored in", outfile))
