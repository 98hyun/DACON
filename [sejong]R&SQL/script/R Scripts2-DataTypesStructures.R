##################################################
# R Scripts 2: Data Types and Structures         #
#  (Selected Topics from                         #
#     UC Business Analytics R Programming Guide) #
##################################################

########################
# Dealing with numbers
########################
browseURL("http://uc-r.github.io/section3_numbers/")

# Numeric Types: integer vs. double

# creating a string of double-precision values
dbl_var <- c(1, 2.5, 4.5)  
dbl_var

# creating a string of integers - place an L after the values 
int_var <- c(1L, 6L, 10L)
int_var

# checking for numeric type
# identifies the vector type (double, integer, logical, or character)
typeof(dbl_var)
typeof(int_var)

# Converting Between Integer and Double Values
# converts integers to double-precision values
as.double(int_var)     

# identical to as.double()
as.numeric(int_var)    

# converts doubles to integers
as.integer(dbl_var)         

## Comparing Numeric Values
# There are multiple ways to compare numeric values and vectors. This includes logical operators along with testing for exact equality and also near equality.

# Comparison Operators - The normal binary operators allow you to compare numeric values and provides the answer in logical form:

# for comparison of single numbers
x <- 9
y <- 10

x < y     # is x less than y
x > y     # is x greater than y
x <= y    # is x less than or equal to y
x >= y    # is x greater than or equal to y
x == y    # is x equal to y
x != y    # is x not equal to y

# for comparison of numbers within vectors
x <- c(1, 4, 9, 12)
y <- c(4, 4, 9, 13)

x < y     # is x less than y
x > y     # is x greater than y
x <= y    # is x less than or equal to y
x >= y    # is x greater than or equal to y
x == y    # is x equal to y
x != y    # is x not equal to y

# How many pairwise equal values are in vectors x and y
sum(x == y)    
# Where are the pairwise equal values located in vectors x and y
which(x == y)    

## Rounding numeric values _The following illustrates the common ways to round x:
x <- c(1, 1.35, 1.7, 2.05, 2.4, 2.75, 3.1, 3.45, 3.8, 4.15, 4.5, 4.85, 5.2, 5.55, 5.9)  
# Round to the nearest integer
round(x)

# Round up
ceiling(x)

# Round down
floor(x)

# Round to a specified decimal
round(x, digits = 1)

###########################
# Character string basics
###########################
browseURL("http://uc-r.github.io/characters")

## Creating strings

a <- "learning to create"    # create string a
b <- "character strings"     # create string b

## Building strings
# paste together string a & b
paste(a, b)                      

# paste character and number strings (converts numbers to character class)
paste("The life of", pi)           

# paste multiple strings
paste("I", "love", "R")            

# paste multiple strings with a separating character
paste("I", "love", "R", sep = "-")  

# use paste0() to paste without spaces btwn characters
paste0("I", "love", "R")            

# paste objects with different lengths
paste("R", 1:5, sep = " v1.")       

# Converting to strings
a <- "The life of"    
b <- pi

is.character(a)
is.character(b)
c <- as.character(b)
is.character(c)
toString(c("Aug", 24, 1980))

# Converting cases
x <- "Learning To MANIPULATE strinGS in R"

tolower(x)
toupper(x)

# Replacing characters

x <- "This is A string."
chartr(old = "A", new = "a", x) # replace 'A' with 'a'

# multiple character replacements
y <- "Tomorrow I plzn do lezrn zbout dexduzl znzlysis."
chartr(old = "dz", new = "ta", y)# replace any 'd' with 't' and any 'z' with 'a'

#########################
# Dealing with Factors
#########################
browseURL("http://uc-r.github.io/factors/")

## Creating, Converting & Inspecting Factors
# Creating a factor string - Factor objects can be created with the factor() function:()
  
gender <- factor(c("male", "female", "female", "male", "female"))
gender

# inspect to see if it is a factor class
class(gender)

# show that factors are just built on top of integers
typeof(gender)

# See the underlying representation of factor
unclass(gender)

# what are the factor levels?
levels(gender)

# show summary of counts
summary(gender)

# If we have a vector of character strings or integers we can easily convert to factors:
  
group <- c("Group1", "Group2", "Group2", "Group1", "Group1")
str(group) # to look at the structure of data

# convert from characters to factors
as.factor(group)


## Ordering, Revaluing, & Dropping Factor Levels
# We can easily order, revalue, and drop factor levels as the following illustrates.

# Ordering Levels - When creating a factor we can control the ordering of the levels by using the levels argument:
  
gender <- factor(c("male", "female", "female", "male", "female")) # when not specified the default puts order as alphabetical
gender

# specifying order
gender <- factor(c("male", "female", "female", "male", "female"), 
                 levels = c("male", "female"))
gender

# We can also create ordinal factors in which a specific order is desired by using the ordered = TRUE argument. This will be reflected in the output of the levels as shown below in which low < middle < high:
  
ses <- c("low", "middle", "low", "low", "low", "low", "middle", "low", "middle",
           "middle", "middle", "middle", "middle", "high", "high", "low", "middle",
           "middle", "low", "high")
ses

# creating ordinal levels
ses <- factor(ses, levels = c("low", "middle", "high"), ordered = TRUE)
ses

# you can also reverse the order of levels if desired
factor(ses, levels=rev(levels(ses)))

# Revalue Levels - To recode factor levels I usually use the revalue() function from the plyr package.

plyr::revalue(ses, c("low" = "small", "middle" = "medium", "high" = "large"))
# ??? Using the :: notation allows you to access the revalue() function without having to fully load the plyr package.

# Dropping Levels - When you want to drop unused factor levels, use droplevels():
  
ses2 <- ses[ses != "middle"]
ses2

# let's say you have no observations in one level
summary(ses2)

# you can drop that level if desired
droplevels(ses2)

#########################
# Dealing with Logicals
#########################
browseURL("http://uc-r.github.io/logicals")

# The elements of a logical vector can have the values TRUE, FALSE, and NA (for "not available"). 
# The first two are often abbreviated as T and F, respectively.

# Logical vectors are generated by conditions. For example:

x <- 5
x

x > 13
x

x <- c(5, 14, 10, 22)
x > 13

12 == 12

12 <= c(12, 11)

12 %in% c(12, 11, 8) # for group membership

x <- c(12, NA, 11, NA, 8) # for missing values
is.na(x)

########################
# Dealing with Dates
########################
browseURL("http://uc-r.github.io/dates/")

## Getting current date & time

# To get current date and time information:
Sys.timezone()
Sys.Date()
Sys.time()

# If using the lubridate package:

# install.packages("lubridate")  
library(lubridate)
now()

## Converting strings to dates

x <- c("2015-07-01", "2015-08-01", "2015-09-01") # a string is in a date format (YYYY-MM-DD)
as.Date(x) # simply use as.Date() to convert into a date object

y <- c("07/01/2015", "07/01/2015", "07/01/2015") #a string is of different format
as.Date(y, format = "%m/%d/%Y") # need to incorporate the 'format' argument

## Extract & manipulate parts of dates

library(lubridate)

x <- c("2015-07-01", "2015-08-01", "2015-09-01")

year(x)
month(x)
month(x, label = TRUE) # show abbreviated name
month(x, label = TRUE, abbr = FALSE) # show unabbreviated name
wday(x, label = TRUE, abbr = FALSE)

##############################
# Dealing with Missing Values
##############################
browseURL("http://uc-r.github.io/missing_values")

## Testing for missing values

x <- c(1:4, NA, 6:7, NA) # vector with missing data
x
is.na(x) # testing for missing values

# data frame with missing data
df <- data.frame(col1 = c(1:3, NA),
                 col2 = c("this", NA,"is", "text"), 
                 col3 = c(TRUE, FALSE, TRUE, TRUE), 
                 col4 = c(2.5, 4.2, 3.2, NA),
                 stringsAsFactors = FALSE)

is.na(df) # identify NAs in full data frame
is.na(df$col4) # identify NAs in specific data frame column

# identifying location of NAs in vector
which(is.na(x))
## [1] 5 8

# identifying count of NAs in data frame
sum(is.na(df))
colSums(is.na(df)) # For data frames, a convenient shortcut to compute the total missing values in each column is to use colSums()

## Recoding missing values
# vector with missing data
x <- c(1:4, NA, 6:7, NA)
x

x[is.na(x)] <- mean(x, na.rm = TRUE) # recoding missing values with the mean
x
round(x, 2)

# data frame that codes missing values as 99
df <- data.frame(col1 = c(1:3, 99), col2 = c(2.5, 4.2, 99, 3.2))
df
# change 99s to NAs
df[df == 99] <- NA
df

# data frame with missing data
df <- data.frame(col1 = c(1:3, NA),
                 col2 = c("this", NA,"is", "text"), 
                 col3 = c(TRUE, FALSE, TRUE, TRUE), 
                 col4 = c(2.5, 4.2, 3.2, NA),
                 stringsAsFactors = FALSE)

df$col4[is.na(df$col4)] <- mean(df$col4, na.rm = TRUE)
df
df$col1[is.na(df$col1)]=mean(df$col1,na.rm=TRUE)

## Excluding missing values

x <- c(1:4, NA, 6:7, NA) # A vector with missing values
mean(x) # including NA values will produce an NA output

# excluding NA values will calculate the mathematical operation for all non-missing values
mean(x, na.rm = TRUE)

# data frame with missing values
df <- data.frame(col1 = c(1:3, NA),
                 col2 = c("this", NA,"is", "text"), 
                 col3 = c(TRUE, FALSE, TRUE, TRUE), 
                 col4 = c(2.5, 4.2, 3.2, NA),
                 stringsAsFactors = FALSE)

df

complete.cases(df) # check if each row is has missing values in it
## [1]  TRUE FALSE  TRUE FALSE

# subset with complete.cases to get complete cases
df[complete.cases(df), ]

# or subset with `!` operator to get incomplete cases
df[!complete.cases(df), ]

# An shorthand alternative is to simply use na.omit() to omit all rows containing missing values.

# or use na.omit() to get same as above
na.omit(df)


########################
# Data Structure Basics
########################
browseURL("http://uc-r.github.io/structure_basics")

## Identifying the data structure
# different data structures
vector <- 1:10
list <- list(item1 = 1:10, item2 = LETTERS[1:18])
matrix <- matrix(1:12, nrow = 4)   
df <- data.frame(item1 = 1:18, item2 = LETTERS[1:18])

# identifying the structure of each object
str(vector)
str(list)
str(matrix)
str(df)

# Assessing R object attributes

# assess attributes of an object
attributes(df)
attributes(matrix)

# assess names of an object
names(df)

# assess the dimensions of an object
dim(matrix)

# assess the class of an object
class(list)

# access the length of an object
length(vector)

# note that length will measure the number of items in a list or number of columns in a data frame
length(list)
length(df)


########################
# Managing Data Frames
########################
browseURL("http://uc-r.github.io/dataframes")

# A data frame is the most common way of storing data in R and, generally, is the data structure most often used for data analyses.

## Creating Data Frames
# Data frames are usually created by reading in a dataset using the read.table() or read.csv()

# for example,
classicmodel.product <- read.csv(file.choose())

# data frames can be created explicitly with the data.frame()
df <- data.frame(col1 = 1:3, 
                 col2 = c("this", "is", "text"), 
                 col3 = c(TRUE, FALSE, TRUE), 
                 col4 = c(2.5, 4.2, pi))

str(df) # assess the structure of a data frame. From R4.0, characters are no long imported as factors, unlike previous R versions --> NO need for stringsAsFactors = FALSE
nrow(df) # number of rows
ncol(df) # number of columns

# Converting pre-existing structures to a data frame.

v1 <- 1:3
v2 <-c("this", "is", "text")
v3 <- c(TRUE, FALSE, TRUE)

# convert same length vectors to a data frame using data.frame()
data.frame(col1 = v1, col2 = v2, col3 = v3)

# convert a list to a data frame using as.data.frame()
l <- list(item1 = 1:3, item2 = c("this", "is", "text"), item3 = c(2.5, 4.2, 5.1))
l

as.data.frame(l)

# convert a matrix to a data frame using as.data.frame()
m1 <- matrix(1:12, nrow = 4, ncol = 3)
m1
as.data.frame(m1)

## Adding on to Data Frames

# adding columns using 'cbind()' - column bind
v4 <- c("A", "B", "C")
cbind(df, v4)
str(df)

# adding rows using 'rbind() - row bind
df2 <- rbind(df, c(4, "R", F, 1.1))
df2
str(df2) # notice that the class of numeric columns are characters, instead of numbers because c() coverts all columns to a chracter class.

# To add rows appropriately, we need to convert the items being added to a data frame and make sure the columns are the same class as the original data frame.

adding_df <- data.frame(col1 = 4, col2 = "R", col3 = FALSE, col4 = 1.1, 
                        stringsAsFactors = FALSE) # 'stringsAsFactors = FALSE' no longer necessary in R4.0

df3 <- rbind(df, adding_df)

df3
str(df3) # Now, notice that numeric columns are in a numeric class

## Adding Attributes to Data Frames -- data frames can also have additional attributes such as row names, column names, and comments.
dim(df)
attributes(df) 

# add row names
rownames(df) <- c("row1", "row2", "row3")
attributes(df)

# add/change column names with colnames()
colnames(df) <- c("col_1", "col_2", "col_3", "col_4")

df
attributes(df)

# add/change column names with names()
names(df) <- c("col.1", "col.2", "col.3", "col.4")

df
attributes(df)

# adding a comment attribute
comment(df) <- "adding a comment to a data frame"

attributes(df)

## Subsetting Data Frames

# subsetting by row numbers
df[2:3, ]

# subsetting by row names
df[c("row2", "row3"), ]

# subsetting columns like a list
df[c("col.2", "col.4")]

# subsetting columns like a matrix
df[ , c("col.2", "col.4")]

# subset for both rows and columns
df[1:2, c(1, 3)]

# use a vector to subset
v <- c(1, 2, 4)
df[ , v]

# simplifying results in a named vector
df[, 2]
## [1] "this" "is"   "text"

# preserving results in a 3x1 data frame
df[, 2, drop = FALSE]

## Subseting data frames based on conditional statements. 
# To illustrate we'll use the built-in mtcars data frame:

head(mtcars) # list the first 5 rows in 'mtcars' dataset
# 'mtcars' is one data set from data sets in package 'datasets'
data() # to list the data sets

# If we want to subset mtcars for all rows where mpg is greater than 20 we can perform this in two ways:
  
# using brackets
mtcars[mtcars$mpg > 20, ] 

# using the simplified subset function
subset(mtcars, mpg > 20)

# filtering for multiple conditions using brackets
mtcars[mtcars$mpg > 20 & mtcars$cyl == 6, ]

# using the simplified subset function
subset(mtcars, mpg > 20 & cyl == 6)

# And if we want to perform this filtering along with return only specified columns we simply state the columns we want to return.

# using brackets
mtcars[mtcars$mpg > 20 & mtcars$cyl == 6, c("mpg", "cyl", "wt")]

# using the simplified subset function
subset(mtcars, mpg > 20 & cyl == 6, c("mpg", "cyl", "wt"))


########################
# Managing Tibbles
########################
browseURL("http://uc-r.github.io/tibbles")

# Tibbles are data frames, but they tweak some older behaviors to make life a little easier. 
# The name comes from d
: originally you created these objects with tbl_df(), which was most easily pronounced as "tibble diff". 
# Tibbles are provide by the tibbles package (which also comes automatically in the tidyverse package). 

# to install 'tidyverse' package
# install.packages("tidyverse")

# loading directly
library(tibbles)

# loading indirectly - also loads readr, tidyr, d
, purrr
library(tidyverse)

## Creating Tibbles
# Most other R packages use regular data frames, so you might want to coerce a data frame to a tibble. 
# You can do that with as_tibble()

as_tibble(iris) # 'iris' is a data set from 'datasets' package

# You can create a new tibble from individual vectors with tibble(). tibble() will automatically recycle inputs of length 1, and allows you to refer to variables that you just created (z is defined using x and y)

tibble(
  x = 1:5, 
  y = 1, 
  z = x ^ 2 + y
)

# to compare (not able to define z using x and y)
data.frame(
  x = 1:5, 
  y = 1, 
  z = x ^ 2 + y
)

# If you're already familiar with data.frame(), note that tibble() does much less:
# it never changes the type of the inputs (e.g. it never converts strings to factors!)
# it never changes the names of variables, and 
# it never creates row names.

## Comparing Tibbles to Data Frames
# There are two main differences in the usage of a tibble vs. a classic data.frame: printing and subsetting.

# Printing - Tibbles have a refined print method that shows only the first 10 rows along with the number of columns that will fit on your screen.

tibble(
  a = lubridate::now() + runif(1e3) * 86400,
  b = lubridate::today() + runif(1e3) * 30,
  c = 1:1e3,
  d = runif(1e3),
  e = sample(letters, 1e3, replace = TRUE)
)

# to compare
data.frame(
  a = lubridate::now() + runif(1e3) * 86400,
  b = lubridate::today() + runif(1e3) * 30,
  c = 1:1e3,
  d = runif(1e3),
  e = sample(letters, 1e3, replace = TRUE)
)

## Subsetting

df_tb <- tibble(
  x = runif(5),
  y = rnorm(5)
)
df_tb

# Extract by name
df_tb$x
df_tb[["x"]]

# Extract by position
df_tb[[1]]

# Extracing like a matrix
df_tb[,1]

# compare
df_df <- data.frame(df_tb)
df_df[,1] 
df_df[,1, drop=F]
 

