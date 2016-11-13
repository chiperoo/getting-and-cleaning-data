## Purpose
This fulfills the Getting and Cleaning Data Course Project on Coursera. The course website is at: [Getting and Cleaning Data](https://www.coursera.org/learn/data-cleaning/home/info)

## Overview
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.

## Grading Criteria
The review criteria for the project is as follows:

1. The submitted data set is tidy.
2. The Github repo contains the required scripts.
3. GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
4. The README that explains the analysis files is clear and understandable.
5. The work submitted for this project is the work of the student who submitted it.

## Data
This code assumes that the dataset is downloaded and unzipped in the current working directory.

The [zipped data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) is available for download.

## Contents
* `CodeBook.md` - Describes the process how to generate tidy data, as well as the data contents of the tidy data set
* `run_analysis.R` - Script to generate the tidy data
* `README.md` - This file.

## Tidy notes
The data in the generated `tidy_data.txt` is the long form of tidy data. Per 
the criteria that defines tidy:
  1. Each variable forms a column
    * The variables here are: `subject_id`, `activity`, `measurement`, `value`
  2. Each observation forms a row
    * There are no duplicated rows for each unique set of `subject_id`, `activity`, and `measurement`
  3. Each type of observational unit forms a table
    * Everything is contained in one table

## Getting started
1. Download and unzip the [experiment data]((https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) in the current working directory.
2. Run the `run_analysis.R` script to generate the `tidy_data.txt` output.
3. The `tidy_data.txt` file will be generated in the current working directory.
4. To read in the tidy data, run:

	```r
	tidy_data <- read.table("tidy_data.txt", header = TRUE)
	View(tidy_data)
	```
