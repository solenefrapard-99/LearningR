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


# Fixing variable names ---------------------------------------------------

# Those variable are in camel case and we don't want this formqat so we will need to rename them in the snakecase format

nhanes_small <- rename_with(nhanes_small, snakecase::to_snake_case) # Careful we run snakecase::to_snake_case as an object so we should not have open brackets for that
# This is use to rename all the variables at the time

nhanes_small <- rename(nhanes_small, sex = gender) # First object is the dataset, the second object is the new name = the old name
# This is to rename one variable at the time


# Piping ------------------------------------------------------------------

colnames(nhanes_small) # normal visualization

nhanes_small %>%
  colnames() # The pipe is taking the previous object and putting it at the first position

nhanes_small %>%
  select(phys_active) %>% # To make the pipe symbol, do command shift M
  rename(physically_active = phys_active)
# Do not forget to do command shit P, Style active file

# Exercise: 7.8 Practicing what we've learned

nhanes_small %>%
  select(bp_sys_ave, education)

nhanes_small %>%
  rename(
    bp_sys = bp_sys_ave,
    bp_dia = bp_dia_ave
  )

nhanes_small %>%
  select(bmi, contains("age"))

nhanes_small %>%
  select(starts_with("bp")) %>%
  rename(bp_systolic = bp_sys_ave)

# Filtering rows ----------------------------------------------------------

# Filtering use logic and it is very easy to make mistakes, always ask for second opinion. Always mke sure that we use really basic logic.

nhanes_small %>%
  filter(phys_active != "No") # The filter will keep every person which is physically active

nhanes_small %>%
  filter(bmi >= 25, phys_active == "No") # Using a coma here is equivalent to use &

nhanes_small %>%
  filter(bmi == 25 | phys_active == "No") # To do OR, press option and 7 --> |
# Be careful when using logic operators and especially OR


# Arranging rows ----------------------------------------------------------

nhanes_small %>%
  arrange(desc(age), bmi, education) # Does not make much sens to sort with more than one or two variables

# Mutating columns --------------------------------------------------------

nhanes_small %>%
  mutate(
    age_month = age * 12,
    logged_bmi = log(bmi),
    age_weeks = age_month * 4,
    old = if_else(
      age >= 30,
      "old",
      "young"
    )
  )
# Old information= new information; age_month --> This is not changing properly the data, it creates a new column to have the age in month, some for logged_bmi
# As we have created age_month before, we can reuse it in age_weeks
# if_else--> if it is true do the first option otherwise do the other one
# Do not forget the coma between the argument in the mutate fonction


# Exercise 7.12 : Piping, filtering and mutating --------------------------


# 1. BMI between 20 and 40 with diabetes
nhanes_small %>%
  # Format should follow: variable >= number or character
  filter(bmi >= 20 & bmi <= 40 & diabetes == "Yes")

# Pipe the data into mutate function and:
nhanes_modified <- nhanes_small %>% # Specifying dataset
  mutate(
    # 2. Calculate mean arterial pressure
    mean_arterial_pressure = ((2 * bp_dia_ave) + bp_sys_ave) / 3,
    # 3. Create young_child variable using a condition
    young_child = if_else(age < 6, "Yes", "No")
  )

nhanes_modified


# Summarizing -------------------------------------------------------------

nhanes_small %>%
  filter(!is.na(diabetes)) %>%
  group_by(diabetes, phys_active) %>%
  summarize(
    max_bmi = max(bmi, na.rm = TRUE),
    min_bmi = min(bmi, na.rm = TRUE)
  )
# Mutate give you the same number of row, summarize will give you back one row or if we add a group by, the number of row possible in the condition we are grouping by. na.rm=TRUE will allow us to calculate even with the missing datas
# The filter(!is.na(diabetes)) is to keep the values that are not missing
