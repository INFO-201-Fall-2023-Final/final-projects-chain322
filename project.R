library(dplyr)
library(stringr)
library(ggplot2)
library(shiny)
library(plotly)

inflation_df <- read.csv("income_inflation.csv")

# convert the median income column to numeric value
inflation_df$Median_income_est <- as.numeric(gsub(",", "", inflation_df$Median_income_est))

# create a variable with the value of the minimum median income for all races called "min_inc_all"
min_inc_all <- min(inflation_df$Median_income_est[inflation_df$Race == "all"], na.rm = TRUE)

# create another variable called "max_inc_all" with the maximum median income for all races
max_inc_all <- max(inflation_df$Median_income_est[inflation_df$Race == "all"], na.rm = TRUE)

# add column for median income multiplied by CPP (with cpp converted to a single digit ratio (e.g. 100.03 = 1, 39.4 = .39)) to our inflation_df

inflation_df$median_income_cpp <- inflation_df$Median_income_est * (inflation_df$CPP * .01)


# create df that filters out the rows where Race != all
filtered_df <- subset(inflation_df, Race == "all")

# create df that just includes rows where Race includes the word "white". You will need to average the median income for all matching years. 
# For instance, there are two rows for the year 2022 where Race has the word "white". The only columns we need for this are "year", 
# "median income"(averaged), and "CPP".
# We used grep here to find the indices of the rows where the race column has white.
white_df <- inflation_df[grep("white", inflation_df$Race, ignore.case = TRUE), ]
avg_median_inc <- tapply(white_df$Median_income_est, white_df$year, mean)
white_result_df <- data.frame(year = as.numeric(names(avg_median_inc)), median_income = as.numeric(avg_median_inc), 
                             CPP = white_df$CPP[match(names(avg_median_inc), as.character(white_df$year))])

# create df for all rows that do not include "white" or "all" in the race column. You will need to average the median income for all matching years.
# the only columns we need are "year", "median income" (averaged), and "CPP".

other_race_rows <- !grepl("white|all", inflation_df$Race, ignore.case = TRUE)
other_races_df <- inflation_df[other_race_rows & !is.na(inflation_df$Median_income_est), ]
avg_med_inc_other <- tapply(other_races_df$Median_income_est, other_races_df$year, mean)
other_result_df <- data.frame(
  year = as.numeric(names(avg_med_inc_other)),
  median_income = as.numeric(avg_med_inc_other),
  CPP = other_races_df$CPP[match(names(avg_med_inc_other), as.character(other_races_df$year))] )



### GRAPH STUFF from app.r file:

generate_selected_graph <- function(choice) {

  if (choice == "Median income VS. CPP") {
    return(
      ggplot(filtered_df, aes(x = year)) +
        geom_line(aes(y = Median_income_est), color = "blue", linetype = "solid", linewidth = 1) +
        geom_line(aes(y = CPP * 300), color = "red", linetype = "dashed", linewidth = 1) +
        labs(title = "Median Income VS. CPP", x = "Year", y = "Comparitive Value", color = "Variable")
    )
  } else if (choice == "Median Income Affected by CPP") {
    return(
      ggplot(filtered_df, aes(x = year, y = CPP)) +
        geom_line() +
        labs(title = "CPP Affected Income Over Time", x = "Year", y = "CPP Affected Income")
    )
  } else if (choice == "Racial disparity in income") {
    return(
      ggplot(filtered_df, aes(x = year, y = Median_income_est, color = Race)) +
        geom_line() +
        labs(title = "Racial Disparity in Income Over Time", x = "Year", y = "Median Income")
    )
  } else {
    stop("Invalid choice. Please select a valid option.")
  }
}



# generate_median_income_graph <- function(data) {
#   # Your code to generate the median income graph
#   # Example: ggplot(data, aes(x = ..., y = ...)) + ...
# 
#     ggplot(data, aes(x = Year, y = df$Median_income_est)) +
#     geom_line() +
#     labs(title = "Median Income Over Time", x = "Year", y = "Median Income")
# }
# 
# 
# # Function to generate the CPP-affected income graph
# generate_cpp_affected_income_graph <- function(data) {
#   # Your code to generate the CPP-affected income graph
#   # Example: ggplot(data, aes(x = ..., y = ...)) + ...
#   ggplot(data, aes(x = Year, y = CPP)) +
#     geom_line() +
#     labs(title = "CPP-Affected Income Over Time", x = "Year", y = "CPP Affected Income")
# }
# 
# # Function to generate the racial income graph
# generate_racial_income_graph <- function(data) {
#   # Your code to generate the racial income graph
#   # Example: ggplot(data, aes(x = ..., y = ..., color = ...)) + ...
#   ggplot(data, aes(x = Year, y = df$Median_income_est, color = Race)) +
#     geom_line() +
#     labs(title = "Racial Disparity in Income Over Time", x = "Year", y = "Median Income")
# }
# 
# 
# generate_selected_graph <- function(data, choice) {
#   if (choice == "Median income VS. CPP") {
#     return(generate_median_income_graph(data))
#   } else if (choice == "Median Income Affected by CPP") {
#     return(generate_cpp_affected_income_graph(data))
#   } else {
#     return(generate_racial_income_graph(data))
#   }
# }
                             
