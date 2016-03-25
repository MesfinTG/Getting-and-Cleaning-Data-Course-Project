# setwd("C:/Users/user/DataScience_Coursera/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/")
setwd("C:/Users/user/DataScience_Coursera/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/Run_Analysis_R_Code/")
train.x <- read.table("C:/Users/user/DataScience_Coursera/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
train.y <- read.table("C:/Users/user/DataScience_Coursera/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", sep="", header=FALSE)
train.sub <- read.table("C:/Users/user/DataScience_Coursera/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)
test.x <- read.table("C:/Users/user/DataScience_Coursera/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
test.y <- read.table("C:/Users/user/DataScience_Coursera/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt", sep="", header=FALSE)
test.sub <- read.table("C:/Users/user/DataScience_Coursera/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)

Combo_x <- rbind(train.x, test.x)

## get column labels info
features_txt <- read.table("C:/Users/user/DataScience_Coursera/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt", sep="", header=FALSE)

## Extract only columns pertaining to the mean and standard deviation for each measurement
## also tidy field names 
features_txt[,2] <- gsub('[()]', "", features_txt[,2])
features_txt[,2] <- gsub('-mean', "mean", features_txt[,2])
features_txt[,2] <- gsub('-std', "std", features_txt[,2])

colnames(Combo_x) <- c(features_txt$V2)

cols_to_keep <- grep(".*mean.*|.*std.*", features_txt[,2])

Combo_x <- Combo_x[,cols_to_keep]
colnames(Combo_x) <- tolower(colnames(Combo_x))

# merge and append y and sub files
train_y_sub <- cbind(train.y, train.sub)
test_y_sub <- cbind(test.y, test.sub)

Combo_y_sub <- rbind(train_y_sub, test_y_sub)
# label colums 
colnames(Combo_y_sub) <- c("Activity", "Subject")

# Finally create a combined single dataset
Combo_Data <- cbind(Combo_x, Combo_y_sub)

## use descriptive activity names to label activity numbers in the combined dataset
Get_activity_label <- read.table("C:/Users/user/DataScience_Coursera/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)

## format activity numbers with descriptive activity labels 

Active <- 1
for(i in Get_activity_label$V2) {
        Combo_Data$Activity <- gsub(Active, i, Combo_Data$Activity)
        Active = Active + 1
}

## remove unwanted datasets/variables from the workspace
rm(cols_to_keep, features_txt, Get_activity_label, Active)
rm(train.x, train.y, train.sub, test.x, test.y, test.sub)
rm(Combo_y_sub, train_y_sub, test_y_sub, Combo_x, i)

## Next create activity and subject groups in the combined data
## load the dplyr library 
require(dplyr)

Combo_Data <- group_by(Combo_Data, Activity, Subject)

Final_Data <- suppressWarnings(aggregate(Combo_Data, by=list(activity=Combo_Data$Activity, subject=Combo_Data$Subject), mean))

Final_Data <- select(Final_Data, -Activity, -Subject)

write.table(Final_Data, "tidy_data.txt", row.name=FALSE, sep="\t")