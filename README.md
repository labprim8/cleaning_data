Getting and cleaning Data assigment
===================================

# Desciption

The R script in run_analysis.R was written to clean and tidy data from a study at UCI into Human activity recognition using smartphones.

The study itself can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

# Method

the steps involved cleaning the data are as follows:

1. the zip file of the data is downloaded and unzipped into the current working directory

2. for the test set of data data the files (*subject_test.txt, y_test.txt and X_test.txt*) were imported and joined together using cbind() into a new data.frame

3. for the testing set of data data the files (*subject_train.txt, y_train.txt and X_train.txt*) were imported and joined together using cbind() into a new data.frame

4. the data.frames created in step 2 and step 3 where merged together using rbind()

5. using the data in features.txt the headers were added to the data table

6. any column which did not end with mean() or std(), with the exception of analysis and subject, was removed from the set leaving 68 columns. This was done using the grep command and the following regex 

    mean\\(\\)|std\\(\\)|Subject|activity

7. the numbers which correspond to the activity_labels were replaced with the text description to make the data more readable using the factor function

8. the headers were altered to give a more meaningful discription of the variable using a series of sub() statements to find and replace common strings

9. the data table was then averaged grouping by subject and activity so that there is just one variable per subject/activity using the aggregate function

10. the results of this aggregation are written out to a file as the tidy data. 

A description of the variables can be found in the codebook.