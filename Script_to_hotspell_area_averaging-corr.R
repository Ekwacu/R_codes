#created by JK
rm(list=ls())

library(raster)
library(rgdal)
library(ncdf4)

ff <- "F:/Folder_2022/Research/Hotspells_spatial/EA_hotspells-tmean_1971-2021_12.nc"
hsp<- stack(ff, varname="hsp") ##This reads in all timesteps for the netcdf file
proj4string(hsp) <- "+proj=longlat +datum=WGS84" ##This sets the projection system

##read in the shapefile and extract the data for the different EA countries 
shp.file<- readOGR("G:/Folder_2022/Research/EA_Shp/EA.shp") 
ext.hsp <- extract(hsp,shp.file)

yrs     <- c(1971:2021)
yr.all  <- NULL
for(i in 1:length(yrs)){
  yrly   <- rep(yrs[i], 1)
  yr.all <- append(yr.all, yrly, after = length(yr.all)) 
}


for(i in 1:length(shp.file)){
  hsp.reg.avg <- round(colMeans(ext.hsp[[i]],na.rm=TRUE))
  hsp.avg     <- cbind(yr.all[1:51], hsp.reg.avg)
  hsps        <- rbind(hsp.avg)
  colnames(hsps) <- c("Years", "Hotspells")
  write.csv(hsps, file = paste("F:/Folder_2022/Research/Hotspells_spatial/extracted/Hotspell_tmean-12/", shp.file$ADM0_NAME[i], "_hotspell_tmean_1971_2021_12.csv", sep = ""), row.names = F)
}


#Now do the extract using the East Africa shapefile
EA.shp <- readOGR("F:/Folder_2022/Research/EA_Shp/East_Africa-Disolved.shp") 
EA.hsp <- extract(hsp,EA.shp)

hsp.EA.avg <- round(colMeans(EA.hsp[[1]],na.rm=TRUE))
EA.hsp.avg <- cbind(yr.all[1:51], hsp.EA.avg)
EA.hsps    <- rbind(EA.hsp.avg)
colnames(EA.hsps) <- c("Years", "Hotspells")
write.csv(EA.hsps, file = paste("F:/Folder_2022/Research/Hotspells_spatial/extracted/Hotspell_tmean-12/EastAfrica_hotspell_tmean_1971_2021_12.csv", sep = ""), row.names = F)
