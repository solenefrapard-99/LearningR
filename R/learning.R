# Here's an example of a conflict
10

# R basics ----------------------------------------------------------------
weight_kilos <- 100
weight_kilos <- 10
colnames(airquality)
str(airquality)
summary(airquality)

2 + 2 # Do command shift P to style active file

2 + 2


# Packages  -----------------------------------------------------------

library(tidyverse) # Tidyverse is a metapackage, collection of packages that works together. Always use, if we can, packages from tidyverse of R Studio.
library(NHANES) # National Health Assessment blah blah study, example of dataset on the population in the US over many years

# This will be used for testing out Git


# Looking at data ---------------------------------------------------------

glimpse(NHANES)
select(NHANES, Age, Weight, BMI) # The data object in the datafirst is always the first argument, here the second argument is the column
# This command is not changing the dataset, it is only a visualisation of one or many columns

select(NHANES, -HeadCirc) # This should allow us to exclude a column

select(NHANES, starts_with("BP")) # Allow us to select every data column related to blood pressure aka BP

select(NHANES, ends_with("Day")) # Similar function to select only the columns finishing with Day

select(NHANES, contains("Age")) # Similar function to select only the columns that contain Age

# Let's create now a new object to work only with a few variables

nhanes_small <- select(NHANES, Age, Gender, BMI, Diabetes, PhysActive, BPSysAve, BPDiaAve, Education)
nhanes_small
