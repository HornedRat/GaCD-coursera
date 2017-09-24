# Wearable computing data analysis

This is a project for the Coursera "Getting and Cleaning Data" course.
The purpose of this project is to create a tidy dataset from raw data on wearable computing and summarise it.

## Setting up the script

To run the analysis, working directory must contain a folder named "UCI HAR Dataset". The folder must contain the unzipped data from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

## How to use the script

The user can run the script all at once. The script will create two files in the working directory:
* data.txt - a mean for every measurement for each subject and activity

## What does the script do

1. The script reads the raw data files
2. It appends the subject numbers and activities to the datasets
3. Merges the train and test data
4. Gives the merged data proper column names
5. Recodes the activities as a factor with proper levels
6. Selects the columns of interest: mean and standard deviation of all measurements
7. Creates a summary: mean of all the selected measurements for each subjects and activity
8. Writes the data created in previous step to working directory
