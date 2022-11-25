#SCRIPT BY JK
rm(list=ls(all=TRUE))

library(ncdf4)
setwd("F:/Folder_2022/Research/Tmean_Anomaly_JRA55")
temp<-nc_open("tmean_anomaly_2021.nc")
#print(temp)

Tmx<-ncvar_get(temp, varid = 'anom')

xx <- temp$dim[1]$lon$vals
yy <- temp$dim[2]$lat$vals
tt <- temp$dim[3]$time$vals
tt.units<- temp$dim[3]$time$units

xxA <- xx 
yyA <- yy 
ttA <- tt

nlon <- length(xxA)
nlat <- length(yyA)


#computing for the number of hot days for which the Tmx anomaly >= 1.2deg for atleast 5 consecutive days per grid point
HSP <- array(NA, dim=c(nlon,nlat))

for (i in 1:nlon) {
  for (j in 1:nlat){
    Tmx[i,j,][Tmx[i,j,]>=1.5] <- 1
    HSP[i,j] <- sum(rle(Tmx[i,j,])$lengths[rle(Tmx[i,j,])$values==1]>=5)
  } 
}         

#wite out the number of hotspells(HSP) to a netcdf file
xxlon <- xxA
yylat <- yyA
ttt   <- ttA[1] 

dim1 <- ncdim_def("lon","degreesE",xxlon,unlim=FALSE,create_dimvar=TRUE,longname="longitude") 
dim2 <- ncdim_def("lat","degreesN",yylat,unlim=FALSE,create_dimvar=TRUE,longname="latitude") 
dimT <- ncdim_def("time",tt.units,ttt,unlim=FALSE,create_dimvar=TRUE,longname="time")

var   <- ncvar_def("hsp","days",list(dim1,dim2,dimT),-9999,longname="number of hotspells")  
nc.ex <- nc_create("F:/Folder_2022/Research/Hotspells_spatial/Hotspell_tmean-15/EA_hotspells-tmean_2021.nc",var) 
ncvar_put(nc.ex,var,HSP)  
nc_close(nc.ex)