# INFO-201-Group-Final
INFO 201 B final - Repo

Shiny app published link:
https://thmcdan.shinyapps.io/final-projects-chain322/


TO DO:
- [ ] App.R
    - [ ] Introduction
        - [ ] Blurb
        - [ ] Context
    - [ ] Page one
        - [ ] Short introduction of graph
        - [ ] Line graph:
            - [ ] Median income and CPP lines
        - [ ] Conclusion/explaination of data
    - [ ] Page two
        - [ ] Short introduction of graph
        - [ ] Histogram
            - [ ] Median income
            - [ ] Checkbox that multiplies all values by CPP represented as percent.
        - [ ] Conclusion/explanation of data
    - [ ] Page three
        - [ ] Short introduction of graph
        - [ ] Line graph:
            - [ ] White medium income and POC median income
            - [ ] Checkbox that multiplies all values by CPP represented as percent.
        - [ ] Conclusion/explanation of data
- [ ] Project.R
    - [ ] Add column to df:
        - [ ] Median income * (CPP / 100)
        - [ ] e.g. 1983 median income would stay at 55,120 - 2022 med income would shrink from 74,580 to 25,357 showing that the median income for 2022 is less than half the wealth then the average in 1983 despite us technically making almost 20k more.
    - [ ] Create data field:
        - [ ] With all columns but only rows where race = all
        - [ ] With just year, median income, and CPP columns. Median income should be an average of all medians for that year for every group with “white” in the race column
        - [ ] With just year, median income, and CPP columns. Median income should be an average of all medians for that year for every group that doesn’t have “white” or “all” in the race column
