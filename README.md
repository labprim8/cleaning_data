Getting and cleaning Data assigment
===================================

# Desciption

The R script in run_analysis.R was written to clean and tidy data from a study at UCI into Human activity recognition using smartphones.

The study itself can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

# Method

the steps involved cleaning the data are as follows:

1. the zip file of the data was downloaded and unziped
2. for the test set of data data the files subject_test.txt, y_test.txt and X_test.txt, were imported and joined together as columns
3. for the testing set of data data the files subject_train.txt, y_train.txt and X_train.txt, were imported and joined together as columns
4. the data tables created in step 2 and step 3 where merged together as rows
5. using the data in features.txt the headers were added to the data table
6. any column which did not end with mean() or std(), with the exception of analysis and subject, was removed from the set leaving 68 columns
7. the numbers which correspond to the activity_labels were replaced with the text description to make the data more readable
8. the headers were altered to give a more meaningful discription of the variable
9. the data table was then averaged grouping by subject and activity so that there is just one variable per subject/activity
10. the results of this aggregation are written out to a file as the tidy data. 

A description of the variables can be found in the codebook.