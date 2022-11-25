
#simple script for plotting two graphs on same plot created by Samuel
rm(list = ls())
#set path to the file
setwd("F:/Folder_2022/Bryan_Muk")
#load library 
#library(readr)
# read the csv file
SHT<-read.csv("sht_plot.csv")
colnames(SHT)

#Defining the plot color
#Spell=Hot_spell$Hotspell
#newcol=Spell

#outputting a png plot
png("SHT_plot.png",res=270,width=1500,height=1000)

#Graphical plot type and its attributes
plot(SHT$date,SHT$tsht_1, type="l", lwd=0.8,col="blue", xlab='Date', ylab="Temp (0c)", 
las = 1.0, main="5 minute temp for Kampala (2021-2022)", ylim=c(19.0,24.0),cex.main=0.8, 
     cex.lab=1.0, cex.axis=1.0) 
#second plot
lines(SHT$date, SHT$tsht_2, type="l",lwd=0.8,col="red")
lines(SHT$date, SHT$tsht_3, type="l",lwd=0.8,col="green")
lines(SHT$date, SHT$Temp_TH, type="l",lwd=0.8,col="black")
#defining the legend
legend("topleft",c("tsht_1","tsht_2", "tsht_3", "Tahmo"),
       col=c("blue", "red", "green", "black"),bty="n",lwd=1,cex=0.8)
dev.off()