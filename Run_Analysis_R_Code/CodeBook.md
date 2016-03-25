The original train and test files made avaialbe for this course assignment included data collected from several experiments with a group of subjects that perfomred six activities wearing a Samsung Galaxy S II smartphone 
(David Anguita et al. 2013). According to the authors referenced here, the six activities included walking, walking upstairs, walking downstairs, sitting, standing and laying. 

The run_analysis.R script included in this repo does the following:

1) Loads six original train and test data files into R console.
2) merges the several orginal files into a single file.
3) subsets the dataset by extracting those columns pertaining to the mean and standard deviation for each measurement.
4) created tidy field names by changing text to lower cases and also made field names human readable/recognizable.
5) included descriptive activity names such as walking, sitting, standing, among others, to label activity numbers in the combined dataset
6) removed unwanted datasets/variables from the workspace.
7) created two group_by variables for activity and subject data fields.
8) calculated mean values for all of the measurements using activity and subject fields as group by variables
9) exported the tidy dataset by writing a single tidy dataset named tidy_data.txt

 