

library(shiny)
library(ggplot2)
library(tidyr)
library(dplyr)
library(magrittr)# load libraries

## data
cla = read.csv("Consenting CLA+ Data.csv") # scores
cla <- cla[c("studentid", "class","score_total", "major_primary")] #keep only important columns
dram100_list = read.csv("DRAMA 100 Class List.csv")
psyc100_list = read.csv("PSYC 100 Class List.csv")
phys100_list = read.csv("PHYSICS 104 Class List.csv")
dram200_list = read.csv("DRAMA 200 Class List.csv")
psyc203_list = read.csv("PSYC 203 Class List.csv")
phys239_list = read.csv("PHYS 239 Class List.csv")


## set up data frames for each program and add column with program name
eng <- cla %>% subset(major_primary == 11) %>% mutate(Subject = "APSC") 

psyc_1 <- cla %>% semi_join(psyc100_list, by = "studentid") %>% mutate(Subject = "PSYC") #first year psyc
psyc_2 <- cla %>% semi_join(psyc203_list, by = "studentid") %>% mutate(Subject = "PSYC")#second year psyc
psyc <- rbind(psyc_1, psyc_2)

dram_1 <- cla %>% semi_join(dram100_list, by = "studentid") %>% mutate(Subject = "DRAM") #first year drama
dram_2 <- cla %>% semi_join(dram200_list, by = "studentid") %>% mutate(Subject = "DRAM")# second year drama
dram <- rbind(dram_1, dram_2) %>% filter(class == 1) #right now there is only one 2nd year sample

phys_1 <- cla %>% semi_join(phys100_list, by = "studentid") %>% mutate(Subject = "PHYS") #first year physics
phys_2 <- cla %>% semi_join(phys239_list, by = "studentid") %>% mutate(Subject = "PHYS")# second year physics
phys <- rbind(phys_1, phys_2) %>% filter(class == 1) #right now there is only three 2nd year samples

# all queens students and sample sizes
queens <- cla  %>% mutate(Subject = "QUEENS") # all students

n_q_1 <-  sum(with(queens, class == 1 & score_total > 1), na.rm = TRUE)  
n_q_2 <-  sum(with(queens, class == 2 & score_total > 1), na.rm = TRUE) 
n_q_3 <-  sum(with(queens, class == 3 & score_total > 1), na.rm = TRUE) 
n_q_4 <-  sum(with(queens, class == 4 & score_total > 1), na.rm = TRUE) 

#some programs do not have data in some years
#need to add null scores for each year so plots work properly
fix <- data.frame(c(NA,NA,NA,NA),c(1,2,3,4),c(NA,NA,NA,NA),c(NA,NA,NA,NA),c(NA,NA,NA,NA))
colnames(fix) <- colnames(queens)

# dummy entries with scores outside plot range so box widths are correct
dummy_2 <- data.frame(NA, 2, 60, NA,NA) # fake data for 2nd year
colnames(dummy_2) <- colnames(queens)

dummy_4 <- data.frame(NA, 4, 60, NA,NA) # fake data for 4th year 
colnames(dummy_4) <- colnames(queens)
