##Project for Getting and Cleaning Data

Data downloaded from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

After downloading and unziping the data, the script cleans the data and write the tidy data to a txt file.

The code uses the following packages:
    
    - `reshape2`

- `data.table`

does mainly the following things:
    
    - load relative files using `fread` function from `data.table`.

- use regular expression to extract rows containing "mean"" and "std" for later identify.

- merges the training sets and the test sets respectively to create two data set "train" and "test"

- merge train and test using `cbind`, asign the data frame to `cDT`.

- create a `.txt` file containing the data using `fwrite`.

