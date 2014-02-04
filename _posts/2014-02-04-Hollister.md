---
layout: post
title: Spatial Data Analysis with R
author: Jeff Hollister
---


I could have entitled this post "How to Ditch ArcGIS", but that is probably a bit over the top.  Thus the more pedestrian title.  Which is OK, becuase either title would be accurate.

So, my plans with the post are to introduce you to the concept of using R as a GIS.  This idea would have seemed a bit silly not too long ago and most R gurus would have suggested you simply transfer data between R and your GIS of choice (e.g. [ArcGIS](http://www.esri.com/software/arcgis), [GRASS](http://grass.osgeo.org/), [QGIS](http://www.qgis.org/en/site/), etc.).   But over the last several years there has been a suite of packages released that provide nearly all the analytical functionality of a full bore GIS.  I will provide details on a number of packages that either allow R to connect to a GIS or allow R to serve as a GIS.  The later is how I work these days.  

# Packages for Connecting R with a GIS

This section shows two packages that allow you to connect to an external GIS and run processes.  These work well if you have familiarity with and access to an existing GIS.  

First is`spgrass6`.  This allows for either the running of R from within a GRASS session, or access to GRASS commands from within an R session.  As I don't currently have GRASS running on my machine, I am not going to show examples.  If you have interest, I encourage you to dig through the help (e.g. `??spgrass6`).

The second option is `RPyGeo`, which is a package that provides access to ArcGIS geoprocessing tools via an intermediate Python script.  File I/0 still needs to be handeled (see below), but `RPyGeo` allows consolidation of the workflow to a single language. As an example, here is an example that buffers a shapefile.


```r
# Installs if not already
if (!"RPyGeo" %in% installed.packages()) {
    install.packages("RPyGeo")
}
library(RPyGeo)
# Files availbfrom from figshare at http://dx.doi.org/10.6084/m9.figshare.796429
rpygeo.geoprocessor("Buffer_analysis", args = list("sampleLoc.shp", "sampleLocB.shp", 
    "1000 meters"))

```


Two downsides to this are it requires ArcGIS (and its associated cost) and for every geoprocessing step it creates a python script, fires up Arc, runs the command, and closes down Arc.  This is a bit resource heavy and slows down the analysis considerably.  Not much of an issue with smaller tasks, but for those analyses that are operating on many features idependently and/or have many steps, this can be a hinderance.

# Packages for Using R as a GIS

While the above options provide the full functionality of a GIS (e.g. ArcGIS), they do require additional software, licenses, maintanenace, resources, etc.  Another, more streamlined solution for integrating R and GIS is to use several packages that prove a (mostly) pure R solution. As I said, this is a recently (e.g. last 2-3 years) added functionality to R.

The standard packages that most use to imbed GIS functionality to R are listed below with a bit of annotation on each.

1. `sp`: This is one of the foundational packages for dealing with spatial data in R.  It sets up the spatial data classes (e.g. `SpatialLines`, `SpatialPolygonsDataFrame`, etc.) that are used (or at least recognized) by all of the other packages. Some analysis also included in `sp`. 
2. `rgdal`: This is another of the foundational packages, that is built of the [Geospatial Data Abstraction Library](http://www.gdal.org/).  This provides most of the utilities you will need to read and write a variety of geospatial data formats.
3. `rgeos`: This package provides an R interface to [GEOS (Geometry Engine, Open Source)](http://trac.osgeo.org/geos/).  This gives you most of what you typically think of as "GISy" analysis.
4. `raster`: Allows processing and analysis of raster data and also provides capability to deal with large rasters by being able to read data from disk.

And, some other useful additional packages:

1. `gdistance`: Provides tools for doing a variety of cost surface based analyses
2. `geosphere`: Calculates Great Circle distances and provides a variety of tools for dealing with distances, bearings, etc.
3. `landsat`: Provides processing and correction tools multi-spectral imagery (and shout out to co-maintaner of r-sig-ecology, [Sarah Goslee](http://www.ars.usda.gov/pandp/people/people.htm?personid=31752)).
4. `maptools`: Another widely used package to faciliate reading and writing spatial data.
5. `SDMTools`: Provides species distribution modelling tools in R.  Biggest thing (at least for me) is the implementation of most of FRAGSTATS in and R package.  Those tools are a bit hidden here, but allows you to calculate most landscape metrics without having to rewrite those tools in R.

# Examples

In this section, I provide some basic examples of spatial data analysis in R.  These examples are mostly taken from a workshop I did at the 2013 USIALE Annual meeting in Austin.  This info in another format is also available as a [presentation](http://dx.doi.org/10.6084/m9.figshare.796398) and [fileset](http://dx.doi.org/10.6084/m9.figshare.796429) via [figshare](http://figshare.com).

### Reading in Data

I rely mostly on `rgdal` for  basic reading of vector spatial data. I find `raster` to be easier than the using the SpatialGrid objects in `sp`. There are other ways. This is just how I learned.  For these examples I am reading in an esri shapefile and a `.tif`. 


```r
# Load up packages, will install if not already
rGIS <- c("sp", "rgeos", "raster", "rgdal")
for (i in rGIS) {
    if (!require(i, character.only = TRUE)) {
        install.packages(i)
        require(i, character.only = TRUE)
    }
}

# Using rgdal command - readOGR - we now read in the shapefile of the counties
# and sample locations
county <- readOGR(".", "counties")
```

```
## OGR data source with driver: ESRI Shapefile 
## Source: ".", layer: "counties"
## with 10 features and 11 fields
## Feature type: wkbPolygon with 2 dimensions
```

```r
sampleLoc <- readOGR(".", "sampleLoc")
```

```
## OGR data source with driver: ESRI Shapefile 
## Source: ".", layer: "sampleLoc"
## with 50 features and 1 fields
## Feature type: wkbPoint with 2 dimensions
```

```r
# Using raster command - raster - we now read in the NLCD
austinNLCD <- raster("nlcd.tif")
```


### Exploring the Data

Now that these are read in we can start look at what we've got


```r
# Use Default Method to print info on spatial objects to screen
county
```

```
## class       : SpatialPolygonsDataFrame 
## features    : 10 
## extent      : 2725746, 3488389, 9840147, 10348417  (xmin, xmax, ymin, ymax)
## coord. ref. : +proj=lcc +lat_1=30.11666666666667 +lat_2=31.88333333333333 +lat_0
## =29.66666666666667 +lon_0=-100.3333333333333 +x_0=699999.9999999999 +y_0=3000000 
## +datum=NAD83 +units=us-ft +no_defs +ellps=GRS80 +towgs84=0,0,0 
## variables   : 11
## names       : SDE_COUNTI, PERIMETER, COUNTIES_, COUNTIES_I,     COUNTY, CODE, 
## ACRES, HECTARES, SQ_MILES, SHAPE_AREA, SHAPE_LEN 
## min values  :          0,    577664,         2,          1,    BASTROP,   21,     
## 0,        0,        0,  1.524e+10,    577664 
## max values  :          0,    837252,        11,         10, WILLIAMSON,  491,     
## 0,        0,        0,  3.166e+10,    837251
```

```r
sampleLoc
```

```
## class       : SpatialPointsDataFrame 
## features    : 50 
## extent      : 2988502, 3217487, 9993281, 10189397  (xmin, xmax, ymin, ymax)
## coord. ref. : +proj=lcc +lat_1=30.11666666666667 +lat_2=31.88333333333333 +lat_0
## =29.66666666666667 +lon_0=-100.3333333333333 +x_0=700000.0000000002 +y_0=3000000
## .000000001 +datum=NAD83 +units=us-ft +no_defs +ellps=GRS80 +towgs84=0,0,0 
## variables   : 1
## names       : ID 
## min values  :  1 
## max values  : 50
```

```r
austinNLCD
```

```
## class       : RasterLayer 
## dimensions  : 2254, 2572, 5797288  (nrow, ncol, ncell)
## resolution  : 30, 30  (x, y)
## extent      : -208515, -131355, 773445, 841065  (xmin, xmax, ymin, ymax)
## coord. ref. : +proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=23 +lon_0=-96 +x_0=0 +y_0
## =0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs 
## data source : D:\DATA\DataInformatics\SciComp2014\postsRMarkdown\nlcd.tif 
## names       : nlcd 
## values      : 0, 255  (min, max)
```


### Spatial Data Viz (with Base Graphics) and Spatial Data Manipulation

Plotting the data is easy and accomplisehd by:


```r
# plot out counties and sample locations using Base Graphics
plot(county, lwd = 2, border = "red")
plot(sampleLoc, pch = 19, add = TRUE)
```

![plot of chunk plot1](/figure/plot1.png) 


That may be a bit more than we want, so with some subsetting of the original data we can refine our data.


```r
# Pull out Travis County
travisBool <- county[["COUNTY"]] == "TRAVIS"
travisCounty <- county[travisBool, ]
# Pull out just points that are inside Travis County
travisSampleLocBool <- is.na(overlay(sampleLoc, travisCounty))
travisSampleLoc <- sampleLoc[!travisSampleLocBool, ]
travisCounty
```

```
## class       : SpatialPolygonsDataFrame 
## features    : 1 
## extent      : 2977897, 3230591, 9981999, 10200101  (xmin, xmax, ymin, ymax)
## coord. ref. : +proj=lcc +lat_1=30.11666666666667 +lat_2=31.88333333333333 +lat_0
## =29.66666666666667 +lon_0=-100.3333333333333 +x_0=699999.9999999999 +y_0=3000000 
## +datum=NAD83 +units=us-ft +no_defs +ellps=GRS80 +towgs84=0,0,0 
## variables   : 11
## names       : SDE_COUNTI, PERIMETER, COUNTIES_, COUNTIES_I, COUNTY, CODE, ACRES, 
## HECTARES, SQ_MILES, SHAPE_AREA, SHAPE_LEN 
## min values  :          0,    831561,         5,          4, TRAVIS,  453,     0,        
## 0,        0,  2.857e+10,    831561 
## max values  :          0,    831561,         5,          4, TRAVIS,  453,     0,        
## 0,        0,  2.857e+10,    831561
```

```r
travisSampleLoc
```

```
## class       : SpatialPointsDataFrame 
## features    : 30 
## extent      : 2992872, 3194084, 9998803, 10189397  (xmin, xmax, ymin, ymax)
## coord. ref. : +proj=lcc +lat_1=30.11666666666667 +lat_2=31.88333333333333 +lat_0
## =29.66666666666667 +lon_0=-100.3333333333333 +x_0=700000.0000000002 +y_0=3000000
## .000000001 +datum=NAD83 +units=us-ft +no_defs +ellps=GRS80 +towgs84=0,0,0 
## variables   : 1
## names       : ID 
## min values  :  1 
## max values  : 50
```


Now that we have a more focused selection of data, we can replot it.


```r
# Plot subset
plot(travisCounty, lwd = 2, border = "red")
plot(travisSampleLoc, add = T, pch = 19)
# Add NLCD
plot(austinNLCD, add = T)
```

![plot of chunk plot2](/figure/plot2.png) 


So, obviously we have some issues as not everything is plotting as we expect (i.e. where's the NLCD?).  If we look more closely at our data we notice that we've got two different projections.  Let's get them all into Albers and re-plot them.


```r
# Return PROJ4 strings.  PROJ.4 is a projections library mainted by same folks
# that maintain GEOS and GDAL.
proj4string(travisCounty)
```

```
## [1] "+proj=lcc +lat_1=30.11666666666667 +lat_2=31.88333333333333 +lat_0=29
## .66666666666667 +lon_0=-100.3333333333333 +x_0=699999.9999999999 +y_0=3000000 
## +datum=NAD83 +units=us-ft +no_defs +ellps=GRS80 +towgs84=0,0,0"
```

```r
proj4string(travisSampleLoc)
```

```
## [1] "+proj=lcc +lat_1=30.11666666666667 +lat_2=31.88333333333333 +lat_0=29
## .66666666666667 +lon_0=-100.3333333333333 +x_0=700000.0000000002 +y_0=3000000
## .000000001 +datum=NAD83 +units=us-ft +no_defs +ellps=GRS80 +towgs84=0,0,0"
```

```r
proj4string(austinNLCD)
```

```
## [1] "+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=23 +lon_0=-96 +x_0=0 +y_0=0 +ellps
## =GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"
```

```r
# Re-project
travisCountyAlb <- spTransform(travisCounty, CRS = CRS(proj4string(austinNLCD)))
travisSampleLocAlb <- spTransform(travisSampleLoc, CRS = CRS(proj4string(austinNLCD)))
# Re-plot everything
plot(austinNLCD)
plot(travisCountyAlb, lwd = 3, add = T)
plot(travisSampleLocAlb, add = T, pch = 19)
```

![plot of chunk reprojectReplot](/figure/reprojectReplot2.png) 


### Some Analysis!

So now that everything is looking good (good projections, got data, etc.), let's work on some simple GIS analysis.  For this example we will do the equivalent of a buffer, clip, and caluclate Land Use/Land Cover proportions within that buffer.


```r
# Now some simple GISy stuff.  Select, buffer, clip and save First select the
# first sample location
travisSampleLocAlb1 <- travisSampleLocAlb[1, ]
travisSampleLocAlb1Buffer <- gBuffer(travisSampleLocAlb1, quadsegs = 100, width = 2500, 
    id = travisSampleLocAlb1[["ID"]])
# Convert to Spatial Polygons Data Frame so we can save data to it later.
travisSampleLocAlb1Buffer <- SpatialPolygonsDataFrame(travisSampleLocAlb1Buffer, 
    travisSampleLocAlb1@data)
travisSampleLocAlb1NLCD <- mask(crop(austinNLCD, travisSampleLocAlb1Buffer), travisSampleLocAlb1Buffer)
```

```
## Found 1 region(s) and 1 polygon(s)
```

```r
# For the sake of making this all look pretty, we need to do some stuff with the
# color table This step is not neccessary...
travisSampleLocAlb1NLCD@legend@colortable <- austinNLCD@legend@colortable
plot(travisSampleLocAlb1NLCD)
plot(travisSampleLocAlb1, add = T, pch = 19)
plot(travisSampleLocAlb1Buffer, lwd = 3, border = "red", add = T)
```

![plot of chunk analysis](/figure/analysis2.png) 

```r

# Now calcualte total proportion of each LULC and save to a data.frame
lulcFreqTable <- freq(travisSampleLocAlb1NLCD)
lulcFreqTable <- lulcFreqTable[!is.na(lulcFreqTable[, 1]), ]
lulcProportions <- data.frame(t(data.frame(lulcFreqTable[, 2]/sum(lulcFreqTable[, 
    2]))), row.names = travisSampleLocAlb1Buffer[["ID"]])
names(lulcProportions) <- lulcFreqTable[, 1]
travisSampleLocAlb1Buffer <- SpatialPolygonsDataFrame(travisSampleLocAlb1Buffer, 
    lulcProportions)
travisSampleLocAlb1Buffer
```

```
## class       : SpatialPolygonsDataFrame 
## features    : 1 
## extent      : -158641, -153641, 804463, 809463  (xmin, xmax, ymin, ymax)
## coord. ref. : +proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=23 +lon_0=-96 +x_0=0 +y_0
## =0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs 
## variables   : 14
## names       :                 11,                21,                 22,                
## 23,                24,                 31,                 41,                 
## 42,                 43,                52,                71,                  
## 81,                 82,                 90 
## min values  : 0.0157238470706885, 0.122902723021913, 0.0623911249656184, 0
## .060649124415513, 0.027276061245072, 0.0261758503713212, 0.0668836527001009, 0
## .0791693407903181, 0.0013752635921885, 0.318511047950857, 0.107224718070964, 0
## .00976437150453837, 0.0682130741725497, 0.0337398001283579 
## max values  : 0.0157238470706885, 0.122902723021913, 0.0623911249656184, 0
## .060649124415513, 0.027276061245072, 0.0261758503713212, 0.0668836527001009, 0
## .0791693407903181, 0.0013752635921885, 0.318511047950857, 0.107224718070964, 0 
## .00976437150453837, 0.0682130741725497, 0.0337398001283579
```


# What's missing?

The primary function that is missing from R is interactive visualization such as zooming, panning, and identifying.  There are some ways to get closer to this (i.e. ggplot2::coord_cartesian) and the package `zoom` seems promising.

# Getting Help

Aside from the normal places for getting help with R related issues (e.g. Stackoverflow, etc.).  Three additional and related sources of help are:
1. [CRAN Analysis of Spatial Data Task View](http://cran.r-project.org/web/views/Spatial.html) 
2. [r-sig-geo](https://stat.ethz.ch/mailman/listinfo/R-SIG-Geo/)
3. [Applied Spatial Data Analysis with R](http://www.asdar-book.org/)


