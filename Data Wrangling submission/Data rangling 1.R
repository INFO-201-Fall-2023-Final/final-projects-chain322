library(dplyr)
library(stringr)
library(ggplot2)

income_df <- read.csv("Household income 1967 to 2022.csv")
inflation_df <- read.csv("CPI Dollar purchasing power.csv")

# for converting the year dates in income_df
income_df$year <- substr(income_df$year, 1, 4)
income_df$year <- as.numeric(income_df$year)

inflation_df$year <- substr(inflation_df$DATE, 1, 4)
inflation_df$year <- as.numeric(inflation_df$year)


yr_infl_df <- summarize(
  group_by(inflation_df, year),
  CPP = mean(CPP, na.rm = TRUE)
  )

df <- right_join(income_df,yr_infl_df, by = "year")
# df <- merge(income_df, yr_infl_df, all.x = TRUE)