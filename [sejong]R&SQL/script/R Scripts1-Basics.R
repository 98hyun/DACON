##################################################
# R Scripts 1: Basics                            #
#  (Selected Topics from                         #
#     UC Business Analytics R Programming Guide) #
##################################################

browseURL("http://uc-r.github.io/basics")

###########################
# Assignment & Evaluation
###########################

# assignment - assign a value to a variable (scalar)
x <- 3 #shortcut key: Alt + - (dashed line)

# evaluation
x

####################
# R as a Calculator
####################

8 + 9 / 5 ^ 2
1 / 7

# changing the number of digits
options(digits = 3)
1 / 7
#number of digits: default - 7, maximum - 22
options(digits = 22)
pi

# division
42 / 4          # regular division
42 %/% 4        # integer division
42 %% 4         # modulo (remainder)

# Miscellaneous Mathematical Functions

x <- 10
abs(x)      # absolute value
sqrt(x)     # square root
exp(x)      # exponential transformation
log(x)      # logarithmic transformation
cos(x)      # cosine and other trigonometric functions

## Infinite, and NaN Numbers

# When performing undefined calculations, R will produce Inf (infinity) and NaN (not a number) outputs.

1 / 0           # infinity
## [1] Inf
Inf - Inf       # infinity minus infinity
## [1] NaN - Not A Number
-1 / 0          # negative infinity
## [1] -Inf
0 / 0           # not a number
## [1] NaN
sqrt(-9)        # square root of -9
## Warning in sqrt(-9): NaNs produced
## [1] NaN

################################################
# The basic format of a variable in R is vector
################################################

x <- c(1, 3, 4) # use 'c()' function (c stands for combine or concatenate)
y <- c(1, 2, 4)
# a vectorized function which can operate on entire vectors at once

# add each element in x and y
x + y

# multiply each element in x and y
x * y

# compare each element in x to y
x > y
