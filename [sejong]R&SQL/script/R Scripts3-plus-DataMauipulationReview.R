#########################################################
# R Scripts 3 Plus: Data Transformation Exercise Review #
#    -- Creating the exercise table                     # 
#       with one single statement                       #
#########################################################

# Loading Packages
###################
library(dplyr)

# Reading Datasets
###################
# customers=read.csv("./csv/customers.csv", stringsAsFactors = F, na.strings = c("NA", "NULL"))

customers <- read.csv("./csv/customers.csv", stringsAsFactors = F, na.strings = c("NA", "NULL"))
employees=read.csv("./csv/employees.csv",stringsAsFactors=F,na.strings=c("NA","NULL"))
products=read.csv("./csv/products.csv",stringsAsFactors=F,na.strings=c("NA","NULL"))

str(customers)
str(employees)

# Data Transformation to Create the Table
#   -- one single statement
###########################################

#renaming 'salesRepEmployeeNumber in 'employees' object to 'employeeNumber' to match the variable names in two objects to be joined
customers <- customers %>% rename(employeeNumber = salesRepEmployeeNumber)
str(customers)

#creating the table 
jn <- customers %>% inner_join(employees) %>% 
  group_by(employeeNumber) %>%
  summarise(LastName =  paste(unique(lastName), collapse = ', '), # to keep 'lastName'
  # [group_by() & summarize] will only keep the group_by variable and summary statistics 
            No.of.Customers = n(),
            Min_creditLimit = min(creditLimit, na.rm=T),
            Mean_creditLimit = mean(creditLimit, na.rm=T),
            Max_creditLimit = max(creditLimit),
            Sum_creditLimit = sum(creditLimit, na.rm=T)) %>%
  mutate(Diff_creditLimit = Max_creditLimit - Min_creditLimit) %>%
  arrange(desc(No.of.Customers)) %>% 
  slice(1:10) %>% 
  select(LastName, employeeNumber, Max_creditLimit, Min_creditLimit, No.of.Customers, Mean_creditLimit, Sum_creditLimit, Diff_creditLimit)
  
str(jn)
View(jn)

