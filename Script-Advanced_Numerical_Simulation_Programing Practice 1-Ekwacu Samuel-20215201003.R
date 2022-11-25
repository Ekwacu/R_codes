#R Script to compute and plot Pressure versus Altitude.
#Student No: 20215201003
#Student Name: Ekwacu Samuel
#Advanced Atmospheric Numerical Modeling
#Master of Science in Meteorology
#Nanjing University of Information Science and Technology (NUIST)
# Date: 17th/05/2022.
# "#" operator is used for commenting in the script for such a line not to be executed.
# "<- or =" operators are used for assigning.
# Note; By editing the path to the directory, this code can be copied and executed in R studio programming language.

rm(list=ls(all=TRUE)) #removes items in the environment console
setwd("F:/Folder_2022/Research") #set to the directory where the plot will be.
#-----------------------------------------------------------------------------------
# Using the equation 1 below.
# Z= Ta,s/Ks[1-(pa/pa,s)^(Ks*Rm)/g]-----------------equation 1
# Making pa the subject from equation1, leads to equation2
# pa = pas[(1-((Z*KS)/Tas)]^[(g/(KS*Rm))*1000]---------------equation2
#For;
Z<- seq(0, 10, by = 0.1) #Altitude Z in km
print(Z)
Pas = 1013.25 # Pressure at the surface in (hpa), referred as Pa,s in equation 1
Tas = 298 # Temperature at the surface in Kelvin (K), reffed as Ta,s in equation1
Ks = 6.5 # Environment lapse rate in (K/KM)
g = 9.8072 # acceleration due to gravity on the surface of the earth at sea level i.e.(Z=R)in (M/S2)
Rm = 287.04 # gas constant of dry air is dry in (M2/S2/K)
R = 6371 #Average Radius of the Earth in (Km)
#Variation of acceleration due to gravity (g1) with altitude, Consider the earth to be a sphere of radius R 
#Use the equation3 below
g1= g* (1-Z/R) #g1 decreases with altitude in (M/S2)---------------equation 3
print(g1)
#where g1 is acceleration due to gravity with altitude, g is acceleration due to gravity when Z=R

f = (g1/(Ks*Rm))*1000 #assigning f=(g1/(Ks*Rm))*1000, division by 1000 is to standardized the units
print(f)
Pa = Pas * (1-((Z*Ks)/Tas))^f # pressure decrease with altitude Z in (hpa)
print(Pa)
#----------------------------------------------------------------------------------------------------
#outputting a png plot of Pressure versus Altitude.
png("Plot-Pressure versus altitude-Assignment_20215201003 .png",res=270,width=2200,height=1600)
par (bg = "gray") #plot background color to grey
plot(Z, Pa, xlab = "Altitude (km)", ylab = "Pressure (hPa)", type = "l",lwd=1.5,col="red", 
     main ="A plot of Pressure versus Altitude",cex.main=1.8,cex.lab=1.4, cex.axis=1.4, ylim=c(200,1015))
dev.off() #the plot isn't actually written to the file until you call dev.off()
# God is great
