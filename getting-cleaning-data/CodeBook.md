# How the script works

The way that the script implements the five steps described in the course project's definition is detailed below:


0. Initially the script download and unzip the dataset.
1. All train and test of X,Y and subject datasets are merged using `rbind()`.
2. Extracts only the measurements on the mean and standard deviation for each measurement using `grep()` from `features` dataset. Then, the old column names are replaced by the correct names.
3. Activity labels are extracted from `activity_labels` dataset that takes places in the new merged dataset replacing the old numeric labels.
4. The column names are replaced by more descriptive labels.
5. The three main datasets are merged into a temporary dataset using `cbind()` then replaced by a new one with the average of each variable for each activity and each subject. The final dataset is exported to a folder called `merged/averages_dataset.txt`

# Variables description

Variable Name  | Description
------------- | -------------
X_train, X_test, y_train, y_test, subject_train, subject_test  | Downloaded datasets
X_train_test, y_train_test, subject_train_test  | Merged Train and Test datasets
features | Dataset containing the correct names for X_train_test
features_mean_std_only_ids | Dataset containing only the mean and std attributes
activities_labels | Dataset containing the correct labels for y_train_test
complete_dataset | Merged dataset of X,Y and subject dataset
averages_dataset | Tidy and aggregated dataset by activities and subjects.
