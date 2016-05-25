runanalysis <- function()
  {
  
  ## If the data has not already been unzipped, then unzip it into a directory we can pull it from
  
  if(!file.exists("UCI HAR Dataset"))
    unzip("getdata-projectfiles-UCI HAR Dataset.zip")
  
  ## Read the data into table format
  ## The X files are the data, and the y files are the labels for each data set
  
  X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")

  y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
  
  X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")

  y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
  
  ## The subject files identify the subject involved in each observation,
  ## the features file gives the names of the variables, and the activity labels are, well, the activity labels
  
  features <- read.table("./UCI HAR Dataset/features.txt")
  
  subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

  subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
  
  actlabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
  
  ## Replace the generic column names for the dataset with the provided variable names

  names(X_test) <- features$V2

  names(X_train) <- features$V2
  
  ## Extract the mean and standard deviation measures
  ## This also pulls alon the mean frequency measures, which need to be removed

  test_measures <- X_test[grep("(std|mean)",names(X_test))]

  test_measures <- test_measures[!grepl("meanFreq",names(test_measures))]

  train_measures <- X_train[grep("(std|mean)",names(X_train))]

  train_measures <- train_measures[!grepl("meanFreq",names(train_measures))]
  
  ## Append the activity labels and the subject IDs for each measurement

  test_measures$label <- y_test$V1

  train_measures$label <- y_train$V1

  test_measures$subject <- subject_test$V1

  train_measures$subject <- subject_train$V1
  
  ## Merge the two tables together

  measurestable <- merge(test_measures, train_measures, all = TRUE)
  
  ## Use the aggregate function to get the mean of each column broken down by activity and subject
  
  finaldata <- aggregate(measurestable, list(measurestable$label,measurestable$subject), mean)
  
  ## The above function creates two new columns that are duplicates of the subject and label columns, so remove them
  
  finaldata <- finaldata[,c(-1,-2)]
  
  ## Replace the numeric activity labels with the descriptive strings provided in the activity labels file
  
  actvals <- finaldata$label
  
  for(i in 1:length(actvals))
    actvals[i] <- as.character(actlabels$V2[[as.numeric(actvals[i])]])
  
  finaldata$label <- actvals
  
  ## Return the final dataset, with all tidying and analysis complete
  
  finaldata
}