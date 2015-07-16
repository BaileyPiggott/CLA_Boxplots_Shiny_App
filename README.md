# CLA_app_allprograms
CLA boxplots for eng, psyc, phys, dram




<b>fix</b>
4 null entries - one for each year- to make graph plot with a space for 3rd year and any other year with missing data

<b>dummy</b>
data frame that is made up of dummy_2 and/or dummy_4 which add a score for second/ fourth that is outside the range of the plot. This makes the institutional level box plot at the proper width when there is no discipline specific score. dummy is assigned a Subject value in the if/else statements and row bound to the main data frame AFTER sample sizes are calculated, so it will not affect the calculations
