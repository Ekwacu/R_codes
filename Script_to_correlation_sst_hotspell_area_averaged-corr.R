#Script created by JK
rm(list=ls())

library(ncdf4)

sst.nc<- nc_open("F:/Folder_2022/Research/sst/ERSSTv5_1971-2021.nc") 
#print(sst.nc)
lon  <- ncvar_get(sst.nc,'X')
lat  <- ncvar_get(sst.nc,'Y')
sst  <- ncvar_get(sst.nc,'sst')

sst.dat <- array(as.vector(sst),c(181,89,12,51)) #split the time dimension (t=612) to months(12) & years(51)
sst_yrmn<- apply(sst.dat, c(1,2,4), mean, na.rm=TRUE) # take the annual mean of the SSTs

## read csv file country area averaged hotspells
hsp_reg <- read.csv("F:/Folder_2022/Research/Hotspells_spatial/extracted/Hotspell_tmax-12/Uganda_hotspell_tmax_1971_2021_12.csv", sep=",")
hsp_reg <- hsp_reg$Hotspells

# perform a gridpoint correlation of country area averaged hotspells against the annual SSTs 

nlon <- length(lon)
nlat <- length(lat)

cor_value <- array(NA, c(nlon,nlat))
p_value   <- array(NA, c(nlon,nlat))
sig_value <- array(NA, c(nlon,nlat))

for (i in 1:nlon) {
  for (j in 1:nlat){
    
    if(unique(!is.na(sst_yrmn[i,j,])) == TRUE){
      
      cor_value[i,j] <- cor.test(sst_yrmn[i,j,], hsp_reg,  alternative = "two.sided", method = "pearson", conf.level = 0.95, exact=FALSE)$estimate
      p_value[i,j]   <- cor.test(sst_yrmn[i,j,], hsp_reg,  alternative = "two.sided", method = "pearson", conf.level = 0.95, exact=FALSE)$p.value
      
    }
    
    if(p_value[i,j] <= 0.05 & !is.na(p_value[i,j]) == TRUE) {
      # sig_value[i,j] <- cor_value[i,j] 
      sig_value[i,j] <- 1  ## I have chosen to use 1 to maskout grid points (these are shown as NAs) that aren't significant
    } else {
      sig_value[i,j] <- NA	
    }  
  }
}    

#saving the data to a netcdf file

dim1 <- ncdim_def("lon","degreesE",lon)
dim2 <- ncdim_def("lat","degreesN",lat)

var1 <- ncvar_def("cor","unitless",list(dim1,dim2),-1,longname="correlation btn area averaged hotspells and annual SSTs")
var2 <- ncvar_def("cor_sig","unitless",list(dim1,dim2),-1,longname="significant correlation")

nc.ex <- nc_create("F:/Folder_2022/Research/Hotspells_spatial/cor_ssts_hotspells/Hotspell_tmax-12-cor/Uganda_cor_sst_hotspell_tmax_12.nc",list(var1,var2))
ncvar_put(nc.ex,var1,cor_value)
ncvar_put(nc.ex,var2,sig_value)
nc_close(nc.ex)

