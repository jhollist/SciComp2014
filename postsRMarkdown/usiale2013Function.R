# SpatialDataWorkshopUSIALE1.R
# Function to take input sample locations,
# input landcover, and input buffer distance and
# calculate lulc proportion.  Options to save output
# shapefiles and rasters.
# returns: dataframe of ID's and LULC proportions
# 
# Author: Jeff. W. Hollister
# Version: 1.0 3/29/2013

usiale2013Function<-function(locations,lulc,bufferDistance,outputSpatial=FALSE,outputName="usiale2013")
{
   # check for required packages and install if necessary
   if(!"sp"%in%installed.packages()){install.packages("sp", repos="http://cran.revolutionanalytics.com")}
   if(!"rgdal"%in%installed.packages()){install.packages("rgdal", repos="http://cran.revolutionanalytics.com")}
   if(!"rgeos"%in%installed.packages()){install.packages("rgeos", repos="http://cran.revolutionanalytics.com")}
   if(!"raster"%in%installed.packages()){install.packages("raster", repos="http://cran.revolutionanalytics.com")}
   require(sp)
   require(rgdal)
   require(rgeos)
   require(raster)
  
   # check for outputPath
   if(!file.exists(dirname(outputName))) {dir.create(dirname(outputName))} 
  
   # read in data/check projections, etc.
   myLoc<-readOGR(".",locations)
   myLULC<-raster(lulc)
   if(proj4string(myLoc)!=proj4string(myLULC)){myLocTrans<-spTransform(myLoc,CRS=CRS(proj4string(myLULC)))}
   # set up data.frame to store output and temp df to hold lulc proportions
   xdf<-data.frame()
   lulcdf<-freq(myLULC)
   # loop through sample locations
   for(i in 1:length(myLocTrans))
   {
      # buffer, mask, calculate
      myBuff<-gBuffer(myLocTrans[i,],quadsegs=100,width=bufferDistance,id=myLocTrans[i,][["ID"]])
      #Convert to Spatial Polygons Data Frame so we can save data to it later.
      myBuff<-SpatialPolygonsDataFrame(myBuff,myLocTrans[i,]@data)
      myNLCD<-mask(crop(myLULC,myBuff),myBuff)
      # For the sake of making this all look pretty, we need to do some stuff with the color table
      # This step is not neccessary...
      myNLCD@legend@colortable<-myLULC@legend@colortable
      # Calculate proportions
      lulcFreqTable<-freq(myNLCD)
      lulcFreqTable<-lulcFreqTable[!is.na(lulcFreqTable[,1]),]
      lulcFreqTable<-merge(data.frame(lulcdf),lulcFreqTable,by="value",all.x=T)[,c(1,3)]
      lulcProportions<-data.frame(t(data.frame(lulcFreqTable[,2]/sum(lulcFreqTable[,2],na.rm=T))),row.names=myBuff[["ID"]])
      names(lulcProportions)<-lulcFreqTable[,1]
      myBuff<-SpatialPolygonsDataFrame(myBuff,lulcProportions)
      xdf<-rbind(xdf,data.frame(ID=row.names(lulcProportions),lulcProportions))
      # output SpatialData for each sample
      if(outputSpatial)
      {
         writeOGR(myBuff,".",paste(outputName,xdf[i,]["ID"],sep=""),driver="ESRI Shapefile",check_exists=T,overwrite_layer=T)
         writeGDAL(as(myNLCD, "SpatialGridDataFrame"),paste(outputName,xdf[i,]["ID"],".tif",sep=""), 
                  drivername="GTiff", type="Byte", mvFlag=255, colorTable=list(myNLCD@legend@colortable))
      }
   }
   # return dataframe
   names(xdf)[2:dim(xdf)[2]]<-names(lulcProportions)
   return(xdf)
}

# Separate stuff to demo the script
setwd("C:\\Documents and Settings\\JHollist\\Desktop\\GoogleDrive\\Google Drive\\USIALE2013StudentWorkshop\\SpatialDataMandAwithR")
usiale2013Function("sampleLoc","nlcd.tif",1000,T,"newoutput/myTestRun")
