
#simple script for Mannkedall trend analysis by and samuel
rm(list=ls())
#load the Kendall library, if you don't have it. Install as follows: install.packages(Kendall))
library(Kendall)

#Kendall for more info about the Mannkendall test
aa  <- read.csv("F:/Folder_2022/Research/temporal_Analysis/Analysis_trend-temporal/Hotspell_Tmean_JK.csv", header = T)
aaa <- aa[2:20] #select only the station columns

names <- colnames(aa[2:20]) #extracts the column names

p_value <- NULL
Tau <- NULL
Score <- NULL
denominator<-NULL

for (i in 1:ncol(aaa)) {
  #The MK trend is considered significant if the p_value < 0.05
  
  Tau[[i]]   <- MannKendall(aaa[,i])$tau
  p_value[[i]] <- MannKendall(aaa[,i])$sl
  Score[[i]] <- MannKendall(aaa[,i])$S
  denominator[[i]] <-MannKendall(aaa[,i])$D
 
  
  }

#create a dataframe to store the Trend & P values for each station
df <- data.frame(cbind(Tau,p_value,Score,denominator))
row.names(df) <- names 

#write out the data to a csv file
write.csv(df, file = paste("F:/Folder_2022/Research/temporal_Analysis/Analysis_trend-temporal/", "MannKendall_Hot_Spell-Average.csv", sep = ""), row.names = T)
