# SpatialDataWorkshopUSIALE1.R
# Script to show basic steps for pulling in raster and vector data
# Do some basic spatial analysis and output data
# Author: Jeff. W. Hollister
# Version: 1.0 3/29/2013
 
# Load the required packages.  Would be best to check that packages have 
# been installed already, but for simplicity I am not including that here
# We can assume that this has been done.
library(sp)
library(rgdal)
library(rgeos)
library(raster)

#We will need to change this so it points to the correct directory
setwd("C:\\Documents and Settings\\JHollist\\Desktop\\GoogleDrive\\Google Drive\\USIALE2013StudentWorkshop\\SpatialDataMandAwithR")

# Using rgdal command - readOGR - we now read in the shapefile of the counties and sample locations
county<-readOGR("county","counties")
sampleLoc<-readOGR(".","sampleLoc")
# Look at the details
summary(county)
county
summary(sampleLoc)
sampleLoc
plot(county,lwd=2,border="red")
plot(sampleLoc,add=T,pch=19)
# Pull out Travis County
travisBool<-county[["COUNTY"]]=="TRAVIS"
travisCounty<-county[travisBool,]
# Pull out just points that are inside Travis County
travisSampleLocBool<-is.na(overlay(sampleLoc,travisCounty))
travisSampleLoc<-sampleLoc[!travisSampleLocBool,]
plot(travisCounty,lwd=2,border="red")
plot(travisSampleLoc,add=T,pch=19)

# Using raster command - raster - we now read in the NLCD
austinNLCD<-raster("nlcd.tif")
austinNLCD
plot(austinNLCD,add=T)

# As is, these datasets don't line up...  Need to reproject to a common projection.  
# My default is usually to reproject vector into the raster projection
travisCountyAlb<-spTransform(travisCounty,CRS=CRS(proj4string(austinNLCD)))
travisSampleLocAlb<-spTransform(travisSampleLoc,CRS=CRS(proj4string(austinNLCD)))
plot(austinNLCD)
plot(travisCountyAlb,lwd=3,add=T)
plot(travisSampleLocAlb,add=T,pch=19)7

# Now some simple GISy stuff.  Select, buffer, clip and save
# First select the first sample location
travisSampleLocAlb1<-travisSampleLocAlb[1,]
travisSampleLocAlb1Buffer<-gBuffer(travisSampleLocAlb1,quadsegs=100,width=2500,id=travisSampleLocAlb1[["ID"]])
#Convert to Spatial Polygons Data Frame so we can save data to it later.
travisSampleLocAlb1Buffer<-SpatialPolygonsDataFrame(travisSampleLocAlb1Buffer,travisSampleLocAlb1@data)
travisSampleLocAlb1NLCD<-mask(crop(austinNLCD,travisSampleLocAlb1Buffer),travisSampleLocAlb1Buffer)
# For the sake of making this all look pretty, we need to do some stuff with the color table
# This step is not neccessary...
travisSampleLocAlb1NLCD@legend@colortable<-austinNLCD@legend@colortable
plot(travisSampleLocAlb1NLCD)
plot(travisSampleLocAlb1,add=T,pch=19)
plot(travisSampleLocAlb1Buffer,lwd=3,border="red",add=T)

#Now calcualte total proportion of each LULC and save to a data.frame
lulcFreqTable<-freq(travisSampleLocAlb1NLCD)
lulcFreqTable<-lulcFreqTable[!is.na(lulcFreqTable[,1]),]
lulcProportions<-data.frame(t(data.frame(lulcFreqTable[,2]/sum(lulcFreqTable[,2]))),row.names=travisSampleLocAlb1Buffer[["ID"]])
names(lulcProportions)<-lulcFreqTable[,1]
travisSampleLocAlb1Buffer<-SpatialPolygonsDataFrame(travisSampleLocAlb1Buffer,lulcProportions)

# Now that we have these things, we should save to disk: Shapefile for vector and GTiff for raster
dir.create("output")
setwd("output")
writeOGR(travisSampleLocAlb,".","travisSampleLocAlb",driver="ESRI Shapefile",check_exists=T,overwrite_layer=T)
writeOGR(travisSampleLocAlb1,".","travisSampleLocAlb1",driver="ESRI Shapefile",check_exists=T,overwrite_layer=T)
writeOGR(xx,".","travisSampleLocAlb1Buffer",driver="ESRI Shapefile",check_exists=T,overwrite_layer=T)
writeGDAL(as(travisSampleLocAlb1NLCD, "SpatialGridDataFrame"),"travisSampleLocAlb1NLCD.tif", 
          drivername="GTiff", type="Byte", colorTable=list(travisSampleLocAlb1NLCD@legend@colortable))
          


