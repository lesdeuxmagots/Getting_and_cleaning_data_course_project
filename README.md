# Getting_and_cleaning_data_course_project

## Synopsis

This is the Course Project of the Getting and Cleaning Data course on Coursera. The script combines and performances some basic analysis on the wearables data provided by the instructions

## Files Included

This repo includes the script file which is used in the analysis, readme and code book associated  

## Code Walkthrough

Script loads all the files necessary to run the analysis.
Script then converts numeric data in the activity labels and headers to actual descriptive labels
Script then merges the files together, grouped by test vs. training subjects, and then adds a column designated this difference
The 2 subfiles are then merged into a master file.

This file should include all data, properly labeled, for the test and training subjects, marked as such. 

File then runs the mean and standard deviation per instructions

Script then creates a new dataset called step5 which summarises columns in a file grouped by subject and activity
