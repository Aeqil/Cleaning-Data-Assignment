# Cleaning-Data-Assignment
The repository for storing run_analysis.R for the Coursera course Getting and Cleaning Data.

The run_analysis.R file requires the presence of the UCI HAR dataset (as a zipped file or as an expanded folder) within the working directory.

First, the script checks to see if the folder for the data set exists, and if it does not, then it unzips the provided zip file into that folder.

It then reads in the data from the test and train sets, as well as secondary files containing variable names, subject IDs and other identifying markers. The variable names of the data sets are then updated with more useful nomenclature that gives meaning to each value.

The script extracts the measurements for the mean and standard deviation of the observed signals, and stores them in data sets. Additional context is then provided to the data, specifically activity labels and subject IDs for each observation.

Once this is completed, the two data sets are merged together. Merging the sets now rather than upon reading them in is a deliberate choice designed to minimise impact on system resources, since our extraction of specific variables means that a large portion of the original data set has been discarded, and so attempting to merge that unnecessary data as well would be wasteful.

The script then calculates the aggregate mean for each variable by subject ID and activity label, leaving us with the average of each variable for a given subject and activity.

Finally, the activity labels are given specific names to further clarify the data.

The resultant data set is then returned to the user.
