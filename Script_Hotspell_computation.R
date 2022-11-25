
#Simple script created by Jesse
# Goal: This script calculates the number of Hotspells based on the Hotspell definition, which is as follows:
#at least 5 consecutive days where the daily anomaly maximum temperatures are greater than zero by 1.2degC.

setwd("F:/Folder_2022/research")
rm(list=ls(all=TRUE))

Data<-read.csv(file="daily_Anomaly_Tmean.csv",stringsAsFactors = FALSE)
Data<-Data[,38:39] #select a station of interest (in this example, for Arua Station)

#Calculate the real number of days in each year to double check the availability of data FOR EACH DAY in .csv file
yearLength <- function(year) 365 + (year %% 4 == 0)
Begin=1971
End=2021
Duration=End-Begin+1
attach(Data)
Dates <- as.POSIXlt(Date, format="%m/%d/%Y")
Year<-Dates$year+1900
Days_Real<-yearLength(Begin:End)

#Counting number of available days in data for each year duration "Days"
YearC<-matrix(nrow=Duration, ncol=2,0)
YearC[,1]<-c(Begin:End)
for (N in 1:Duration) {        
  for (i in 1:length(Year)) {
    if (Year[i]==Begin-1+N) 
    { (YearC[N,2]<-YearC[N,2]+1)}
    
  }
}
Days<-YearC[,2]
#Calculation of Hotspells
HWC<-matrix(nrow=Duration, ncol=15,0)
HWC[,1]<-c(Begin:End)
HWC[,2]<-Days
HWC[,13]<-Days_Real
HWC[1,11]<-1
HWC[1,12]<-Days[1]

#First and last days for each matrix is the cumulative number of days (of first and last days) for years in row
#Counter the first day of year N in the raw = (HWC[N,11])
#Counter the last day of year N in the raw = (HWC[N,12])

for (N in 2:Duration) {
  (HWC[N,12]<-HWC[N-1,12]+Days[N])
}
for (N in 2:Duration) {
  (HWC[N,11]<-HWC[N-1,12]+1)
}
#setting the condition where temperature anomaly is > 0
CC<-0

#Number of Hotspells = (HWC[N,6])
for (N in 1:Duration) { 
  
  HD<-numeric(HWC[N,12]-HWC[N,11]+1)     
  for (i in HWC[N,11]:HWC[N,12]) {
#Daily anomaly max temperature values >= 0 by 1.2 or 1.5degC
        if ((Data[i,2]>= CC+1.5)) { 
      (HD[i-HWC[N,11]+1]<-1) 
    }
    
    HD<-c(HD)
    D<-rle(HD)$lengths[rle(HD)$values==1]
#Number of Hot spells = (HWC[N,6])
        HWC[N,6]<-sum (rle(HD)$lengths[rle(HD)$values==1]>=5) #consecutive 5 days
     }
}
#Creating output file
Output_HW<-data.frame(HWC[,1],HWC[,6])
colnames(Output_HW) <- c("Year","Hotspells1.5")
print(Output_HW)

#Writing table. This code will create an output matrix. 
write.csv(Output_HW,file="JKIA_Hotspells_Tmean_1.5.csv",row.names=FALSE)
