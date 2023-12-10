library(dplyr)
library(stringr)
library(ggplot2)
library(shiny)
library(plotly)

inflation_df <- read.csv("income_inflation.csv")

# create a variable with the value of the minimum median income for all races called "min_inc_all"


# create another variable called "max_inc_all" with the maximum median income for all races


# add column for median income multiplied by CPP (with cpp converted to a single digit ratio (e.g. 100.03 = 1, 39.4 = .39)) to our inflation_df


# create df that filters out the rows where Race != all


# create df that just includes rows where Race includes the word "white". You will need to average the median income for all matching years. 
# For instance, there are two rows for the year 2022 where Race has the word "white". The only columns we need for this are "year", 
# "median income"(averaged), and "CPP".



# create df for all rows that do not include "white" or "all" in the race column. You will need to average the median income for all matching years.
# the only columns we need are "year", "median income" (averaged), and "CPP".
