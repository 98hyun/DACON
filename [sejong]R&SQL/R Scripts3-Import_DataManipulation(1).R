##################################################
# R Scripts 3: Data Import & Export and          #
#                Data Manipulation               #
#  (Selected Topics from                         #
#     UC Business Analytics R Programming Guide) #
##################################################

########################
# Data Import & Export #
########################
browseURL("http://uc-r.github.io/import")
browseURL("http://uc-r.github.io/exporting")

### Dataframe objects in R and csv files are most commonly used file types


### setwd('./csv/') need to do.


## Importing (or reading) a csv file into R as a dataframe ----
customers <- read.csv("./csv/customers.csv", stringsAsFactors = F, na.strings = c("NA", "NULL"))

employees <- read.csv("./csv/employees.csv", stringsAsFactors = F, na.strings = c("NA", "NULL"))

# the csv file is located at "_data/BA_DA/MySql_classicmodels" folder under the working directory at "C:/Users/Seunghee Yu/Documents/R"
# of course, your folder may vary, and the path should be modified accordingly.
# stringAsFactors = F: keep strings as characters, no longer needed in R 4.0
# na.strings = c("NA", "NULL"): change NULL to NA

## Alternatively,
customers <- read.csv(file.choose()) #file explorer will pop up, and you simply choose a csv file to import

# Evaluating and investigating the dataset
customers
dim(customers)
head(customers)
str(customers)
summary(customers) 

employees
dim(employees)
head(employees)
str(employees)
summary(employees) 

## Converting the datasets into tibble datasets
# install.packages("dplyr")
library(dplyr)

customers_tbl <- tibble(customers)
employees_tbl <- tibble(employees)

# Investigating the tibble datasets
customers_tbl
dim(customers_tbl)
head(customers_tbl)
str(customers_tbl)
summary(customers_tbl) 

employees_tbl
dim(employees_tbl)
head(employees_tbl)
str(employees_tbl)
summary(employees_tbl) 

## Exporting (or saving) a R object in a dataframe as a csv file ----

# Checking and changing your working directory 
getwd()

# Let's export 'customers' dataset 
write.csv(customers, "./export/customers.csv", row.names=F) 
#the file 'customers.csv' will be create in "your working directory/_data" folder
#'row.names = F' prevents adding a new index column 


###################################
# Data Transformation using dplyr #
###################################
browseURL("http://uc-r.github.io/dplyr")

# Packages Utilized
# install.packages("dplyr")
library(dplyr)

## %>% Operator
# Although all the functions in tidyr and dplyr can be used without the pipe operator, one of the great conveniences these packages provide is the ability to string multiple functions together by incorporating %>%
# The pipeline operator %>% is very handy for stringing together multiple dplyr functions in a sequence of operations. 
# Every time we wanted to apply more than one function, the sequence gets buried in a sequence of nested function calls that is difficult to read, i.e.

# third(second(first(x)))
# This nesting is not a natural way to think about a sequence of operations. The %>% operator allows you to string operations in a left-to-right fashion, i.e.
# first(x) %>% second %>% third

# A simple example: 
str(customers)
# or
customers %>% str() # shortcut key for %>%: ctrl+shift+m

## 1. select() function: 
##   -- selects variables (or columns) 
##       from a dataframe (or tibble) dataset
###############################################

str(customers)

## selecting columns (or variables) from a dataframe
customers.sub <- select(customers, customerName, salesRepEmployeeNumber, creditLimit)
head(customers.sub) # for brevity only display first 6 rows
head(customers.sub, n=10) # first 10 rows

# using %>% 
customers.sub <- customers %>% select(customerName, salesRepEmployeeNumber, creditLimit)
head(customers.sub)
# or
customers %>% select(customerName, salesRepEmployeeNumber, creditLimit) %>% head() # 'customers.sub' object won't be created

## selecting variables by using "-" (de-selecting)
cust2 <- customers %>% select(-contactLastName:-country)
head(cust2)

## 2. filter() function
##   -- filtering observations (or rows) 
#           from a dataframe (or tibble) dataset
###################################################

customers.sub %>% filter(salesRepEmployeeNumber == 1370)
customers.sub %>% filter(salesRepEmployeeNumber == 1370, creditLimit>100000) # and
customers.sub %>% filter(salesRepEmployeeNumber == 1370 | salesRepEmployeeNumber == 1166) # or
customers.sub %>% filter(salesRepEmployeeNumber == 1370 | creditLimit>100000)

## 3. group_by() & summarise function
##   -- groups data by categorical levels (or factor levels) 
##            and calculate summary statistics for each group
##            from a dataframe (or tibble) dataset
###############################################################

str(customers.sub) #'salesRepEmployeeNumber' is integer

# Need to convert the data type of salesRepEmployeeNumber to Factor 
customers.sub$salesRepEmployeeNumber <- as.factor(customers.sub$salesRepEmployeeNumber)
# check again
str(customers.sub) #now 'salesRepEmployeeNumber' is factor

customers.sub_grp <- customers.sub %>% group_by(salesRepEmployeeNumber)
# The group_by() function is a silent function in which no observable manipulation of the data is performed as a result of applying the function. 
# Rather, the only change you'll notice is, if you print the dataframe you will notice underneath the Source information and prior to the actual dataframe, an indicator of what variable the data is grouped by will be provided. 

# Compare the following two results:
head(customers.sub)
head(customers.sub_grp)

#The real magic of the group_by() function comes when we perform summary statistics 

#Summary statistics for all customers
customers.sub %>% summarise(No.of.Customers = n(),
                            Min_creditLimit = min(creditLimit, na.rm=T),
                           # Median_creditLimit = median(creditLimit, na.rm=T),
                            Mean_creditLimit = mean(creditLimit, na.rm=T),
                           # Var_creditLimit = var(creditLimit, na.rm=T),
                           # SD_creditLimit = sd(creditLimit),
                            Max_creditLimit = max(creditLimit),
                            Sum_creditLimit = sum(creditLimit, na.rm=T))

#Summary statistics for customers grouped by salesRepEmployees
customers.sub %>% group_by(salesRepEmployeeNumber) %>% 
  summarise(No.of.customers = n(),
            Min_creditLimit = min(creditLimit, na.rm=T),
          # Median_creditLimit = median(creditLimit, na.rm=T),
            Mean_creditLimit = mean(creditLimit, na.rm=T),
          # Var_creditLimit = var(creditLimit, na.rm=T),
          # SD_creditLimit = sd(creditLimit),
            Max_creditLimit = max(creditLimit),
            Sum_creditLimit = sum(creditLimit, na.rm=T))
   
        
## 4. arrange() function
##    -- orders rows
##########################

customers.sub %>% group_by(salesRepEmployeeNumber) %>% 
  summarise(No.of.Customers = n(),
            Min_creditLimit = min(creditLimit, na.rm=T),
          # Median_creditLimit = median(creditLimit, na.rm=T),
            Mean_creditLimit = mean(creditLimit, na.rm=T),
          # Var_creditLimit = var(creditLimit, na.rm=T),
          # SD_creditLimit = sd(creditLimit),
            Max_creditLimit = max(creditLimit),
            Sum_creditLimit = sum(creditLimit, na.rm=T)) %>%
    arrange(No.of.Customers) #or arrange(desc(No.of.Customers))


## 5. join() & mutate() functions
##    -- join separate dataframes and
##       create new variables
#########################################

# Let's add salesRep's names to the result above
# First, let's create an object and assign the result above
salesRep_cust <- customers.sub %>% group_by(salesRepEmployeeNumber) %>% 
  summarise(No.of.Customers = n(),
            Min_creditLimit = min(creditLimit, na.rm=T),
          # Median_creditLimit = median(creditLimit, na.rm=T),
            Mean_creditLimit = mean(creditLimit, na.rm=T),
          # Var_creditLimit = var(creditLimit, na.rm=T),
          # SD_creditLimit = sd(creditLimit),
            Max_creditLimit = max(creditLimit),
            Sum_creditLimit = sum(creditLimit, na.rm=T))

## To add salesRep's names, we need to join 'salesRep_cust' and 'employees'
# Need a common variable with the same data type to join -- adding a common variable using mutate() function
# To check
str(employees) #'employeeNumber' is in integer type
str(salesRep_cust) #'salesRepEmployeeNumber' is in factor type

#changing the data type of 'employeeNumber' in 'employees' object to mathc the data type
employees$employeeNumber <- as.factor(employees$employeeNumber)

#renaming 'salesRepEmployeeNumber to 'employeeNumber' to match the variable names
salesRep_cust <- salesRep_cust %>% rename(employeeNumber = salesRepEmployeeNumber)
#alternativley, you may simply add a common variable using mutate() function
salesRep_cust <- salesRep_cust %>% mutate(employeeNumber = salesRepEmployeeNumber)

# as factor
salesRep_cust$employeeNumber=as.factor(salesRep_cust$employeeNumber)


# Check again
str(employees) # 'employeeNumber' is now factor
str(salesRep_cust) # has 'employeeNumber' variable in factor type

#joining salesRep_cust and employees
salesRep_cust_jn <- salesRep_cust %>% inner_join(employees)
str(salesRep_cust_jn)

#adding a new variable using mutate() function
salesRep_cust_jn <- salesRep_cust_jn %>% mutate(Diff_creditLimit = Max_creditLimit - Min_creditLimit)
str(salesRep_cust_jn)

# Let's export or save this dataset for future use
write.csv(salesRep_cust_jn, "./export/salesRep_cust_jn.csv", row.names=F) 

#selecting variable to display
salesRep_cust_jn.sub <- salesRep_cust_jn %>% select(employeeNumber, lastName, No.of.Customers, Min_creditLimit, Mean_creditLimit, Max_creditLimit, Sum_creditLimit, Diff_creditLimit)
salesRep_cust_jn.sub

#returning the top 10 employees with most customers
top10_Rep_No.of.Customers <- salesRep_cust_jn.sub %>% arrange(desc(No.of.Customers)) %>% slice(1:10)
#returning the top 10 employees with highest mean credit limit of their customers
top10_Rep_Mean_creditLimit <- salesRep_cust_jn.sub %>% arrange(desc(Mean_creditLimit)) %>% slice(1:10)

## Exporting (or saving) the top 10 list as a csv file
write.csv(top10_Rep_No.of.Customers, "./export/top10_Rep_No.of.Customers.csv", row.names = F)
write.csv(top10_Rep_Mean_creditLimit, "./export/top10_Rep_Mean_creditLimit.csv", row.names = F)
#Two files, 'top10_Rep_No.of.Customers.csv' and 'top10_Rep_Mean_creditLimit.csv' will be created in 'working directory/data/BA_DA'
#'row.names = F' prevents from adding a new index column 

## 6. Joining multiple dataframes (or tables)
##############################################

## Let's calculate the number of orders that each customer has made -- need to use three tables from the classicmodels: customers, orders, and orderdetails

# Importing additional tables as a dataframe
orders <- read.csv("./csv/orders.csv", stringsAsFactors = F, na.strings = c("NA", "NULL"))
orderdetails <- read.csv("./csv/orderdetails.csv", stringsAsFactors = F, na.strings = c("NA", "NULL"))

# Step 1: joining 3 dataframes
cus_order_orderdetails_jn <- customers %>% inner_join(orders) %>% inner_join(orderdetails) %>% tibble()
cus_order_orderdetails_jn

# Step 2: calculating the number of orders that each customer has made
cus_order_orderdetails_jn %>% group_by(customerNumber) %>% summarise(N=n())

# We can simply put Step 1 & 2 together like below
customers %>% inner_join(orders) %>% inner_join(orderdetails) %>% group_by(customerNumber) %>% summarise(N=n())

