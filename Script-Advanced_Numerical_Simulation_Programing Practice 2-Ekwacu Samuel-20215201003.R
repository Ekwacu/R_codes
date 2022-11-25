
#R Script to compute and plot Saturation vapor pressure over (a) liquid water and
#(b) water over ice, versus temperature.
#Student No: 20215201003
#Student Name: Ekwacu Samuel
#Advanced Atmospheric Numerical Modeling
#Master of Science in Meteorology- NUIST
# Date: 28th -04 - 2022.
# "#" operator is used for commenting in the script for such a line not to be executed.
# "<- or =" operators are used for assigning.

rm(list=ls(all=TRUE)) #removes items in the environment console
setwd("F:/Folder_2022/Research") #set to the directory where plots will be.

#--------------------------------------------------------------------------------------------------------------------
#(a)Saturation vapor pressure over liquid Water PV,S; to generate Figure 2.8a 
Temp <- seq(-50, 50, by = 1.0) # Temp is temperature in (0C) of water over a liquid surface
#from -50°C to 50°C increasing by 1°C
print(Temp)    #helps prints results of Temp
T = 273.15 + Temp # converting temp degrees Celsius to Kelvin
print(T)
f1= 6816* ((1/273.15) - 1/T)
print(f1)
f2 = 273.15/T
print(f2)
f3= 5.1309* (log(f2, base = exp(1))) #Note; ln(x) = log(x, base =exp(1))
print(f3)
PVS = 6.112* (exp(f1 + f3)) #PVS is the equivalent of pv,s as used in the assignment. 
print(PVS) # prints the results of PVS

#outputting a png plot of PVS versus Temperature (Temp)
png("Plot-a-Saturation Vapor Pressure Over a liquid water PVS .png",res=270,width=2000,height=1500)
plot(Temp, PVS,xlab = "Temperature(°C)", ylab = "Vapor pressure (hPa)", type = "l",
     lwd=1.4,col="red", main ="Saturation vapor pressure over liquid water versus temperature",
     cex.main=1.0,cex.lab=1.2, cex.axis=1.2, xaxp = c(-50, 50, 10))
legend("center",c("Over liquid water"),col=c("red"), bty="n",lwd=1, cex=1.0) #legend of the line plot PVS versus Temp.
dev.off() #the plot isn't actually written to the file until you call dev.off()

#---------------------------------------------------------------------------------------------------------------------
#(b)Saturation vapor pressure over liquid water PV,S and over ice PV,I; to generate Figure 2.8b
Temp1 <- seq(-50, 0, by = 1.0) # Temp1 is temperature in (°C) of water over ice surface 
#from -50°C to 0°C increasing by 1°C
print(Temp1) #helps prints results of Temp1
T1 = 273.15 + Temp1 # converting temp1 degrees Celsius to Kelvin
print(T1)
h1 = 4648* ((1/273.15) - 1/T1)
print(h1)
h2 = 273.15/T1
print(h2)
h3 = 11.64* (log(h2, base = exp(1))) # Note; ln(x) = log(x, base =exp(1))
print(h3)
h4 = 0.02265* (273.15 - T1)
print(h4)
PVI = 6.112* (exp(h1 - h3 + h4)) #PVI is the equivalent of PV,I as used in the assignment.
print(PVI) # prints the results of PVI

#---------------------------------------------------------------------------------------------------------------------
#(c) Computing PV,S for temperature increment of -50°C to 0°C by 1°C 
n1= 6816* ((1/273.15) - 1/T1)
print(n1)
n2 = 273.15/T1
print(n2)
n3= 5.1309* (log(n2, base = exp(1))) #Note; ln(x) = log(x, base =exp(1))
print(n3)
PVS1 = 6.112* (exp(n1 + n3)) #PVS is the equivalent of pv,s as used in the assignment. 
print(PVS1) # prints the results of PVS

#outputting a png plot of PVI and PVS1 versus Temperature (Temp1).
png("Plot-b-Saturation Vapor Pressure Over liquid water PVS and Ice PVI .png",res=270,width=2000,height=1500)
plot(Temp1, PVI, xlab = "Temperature(°C)", ylab = "Vapor pressure (hPa)", type = "l",
     lwd=1.4,col="blue", main ="Saturation vapor pressure over liquid water and ice versus temperature",
     cex.main=1.0,cex.lab=1.2, cex.axis=1.2)
legend("bottomright",c("Over ice"),col=c("blue"), bty="n",lwd=1, cex=1.0)#legend of the line plot PVI versus Temp1
lines(Temp1, PVS1, type="l",lwd=1.2, col="red") #Second line plot for PVS1 versus Temp1
legend("center",c("Over liquid water"),col=c("red"), bty="n",lwd=1, cex=1.0) #legend of second line plot
dev.off() #the plot isn't actually written to the file until you call dev.off()
#--------------------------------------------------------------------------------------------------------------------
#God is great