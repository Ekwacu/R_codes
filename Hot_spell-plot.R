
#simple script for plotting graphs created by Samuel
rm(list = ls())
setwd("E:/DADCS_UNMA/Folder_2022/research")

#library(readr)
Hot_spell<-read.csv("Arua_Hotspells_Tmax.csv")

colnames(Hot_spell)

####Defining the plot color#####
Spell=Hot_spell$Hotspell
newcol=Spell

       #####outputting a png plot#####
png("Hot_spell-Arua.png",res=270,width=1500,height=1000)

       #####Graphical plot type and its attributes######
plot(Hot_spell$Year, Hot_spell$Hotspells,type="l",col="red",lwd=0.8, xlim=c(1971,2021),
ylim=c(0.0,12.0),xlab='Years', ylab="Hot spell events", las = 1.0, main="Annual Number of Hot spell Events for Arua (1971-2021)",
  cex.main=1.0, cex.lab=1.2, cex.axis=0.8)

dev.off()
