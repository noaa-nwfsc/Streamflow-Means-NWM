##Download and compile National Water Model 3.0 data from retrospective analysis
#Available: February 1979 through January 2023 (https://registry.opendata.aws/nwm-archive/)

library(ncdf4)
library(sf)
library(dplyr)

##set directory
setwd("D:/FS/sat_temp/NWM download/nwm_3_0_WR_18")

#load shapefile with COMIDs or other file with needed COMIDS.
bankDat <- "D:/FS/sat_temp/NWM download/WR_18_hydro/WR_18_NHD.shp"  ##COMIDS for Water Region 18 (~California)
crb_segs <- st_read(bankDat)
crb_segs<-st_drop_geometry(crb_segs)
##Keep only the COMIDS from the NHD data
crb_id<-subset(crb_segs, select=c("COMID"))

###Use NetCDF4 to open and extract NetCDF files

for (j in 1990:2022){
  strdate <- as.Date(paste0("01-01-",j),format="%d-%m-%Y")
  enddate <- as.Date(paste0("31-12-",j),format="%d-%m-%Y")
  theDate <- strdate
  days <- seq(from=strdate, to=enddate,by='days' )
  for ( i in seq_along(days) )
    tryCatch(
{
   #note that the URL contains the UTC time "1200" (so UTC noon, not EST noon), but change that as necessary
  url <- paste0("https://noaa-nwm-retrospective-3-0-pds.s3.amazonaws.com/CONUS/netcdf/CHRTOUT/",format(theDate,"%Y"),"/",format(theDate,"%Y%m%d"),"1200.CHRTOUT_DOMAIN1")
  print(url)
  file <- paste0("temp", ".comp")
  try(download.file(url, file, mode="wb"))

  ncpath <- "D:/FS/sat_temp/NWM download/nwm_3_0_WR_18/" #pick a location for the netcdf temp file
  ncname <- "temp"
  ncfname <- paste(ncpath, ncname, ".comp", sep="")
  dname <- "feature_id"
  ncin <- nc_open(ncfname)


  reach_id <- ncvar_get(ncin,"feature_id") ##in NWM parlance "feature_id" is akin to COMID
  flow <- ncvar_get(ncin,"streamflow", raw_datavals = FALSE) #This is the flow in m/s3

  tmp_df01 <- data.frame(cbind(reach_id,flow)) #put feature_id and flow together
  names(tmp_df01) <- c("feature_id",paste0("day_",i))
  cleanedA <-merge(x = crb_id, y = tmp_df01, by.x="COMID", by.y = "feature_id", all.x = TRUE)
  crb_id<-cleanedA
  nc_close( ncin )
  print(theDate)
  theDate=theDate+1
})

write.csv(crb_id, paste0("CRB_WR18_flow_V3_",j,".csv")) ##.csv is a terrible format for this
}






