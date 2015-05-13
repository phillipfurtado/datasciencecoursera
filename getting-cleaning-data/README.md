Getting and Cleaning Data - Course Project
==========================================

### What's is this project

This project refers to the Getting and Cleaning Data Course Project, written in R.

Dataset: [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

### How to Run

Download the run_analysis.R from this repository then run inside R the following code:

```{r}
source('~/run_analysis.R')
```

The R script will deal with the dataset, download, unzip and process it.
At the end of script execution an output file is written in the folder: 
```{r}
./UCI HAR Dataset/merged/averages_dataset.txt'
```

### Details

The whole details about how the script works can be accessed in the `CodeBook.md`.
