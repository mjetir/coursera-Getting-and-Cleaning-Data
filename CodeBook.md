subject: the subject who performed the activity for each window sample (the range is from 1 to 30)

activity: the activity that the subject performed (six alternatives: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)

Other variables describe means of chosen variables from the original data (X_test.txt, X_train.txt). The chosen variables are the means (mean()) and the standard deviations (std()) of the features obtained from the measured signals. For more information (e.g. units) about these features and measured signals, see the "features_info.txt" file related to the original data. The variable names in the tidy data set produced in this project begin with "mean-of-" which are followed by names that correspond to the variable names in the original data (listed in "features.txt") in the following way:

* time-> t (notation in the produced data -> notation in the original data)

* frequency -> f

* Magnitude -> Mag

* Gyroscope -> Gyro

* Accelerometer -> Acc

* In addition, compared to the original data, the brackets after mean and std in the variable names have been removed. Also, the repetition of the word "Body" in some variable names is removed in the produced data set.

