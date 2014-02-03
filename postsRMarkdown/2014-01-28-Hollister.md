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
```

```
## Loading required package: shapefiles
## Loading required package: foreign
## 
## Attaching package: 'shapefiles'
## 
## The following objects are masked from 'package:foreign':
## 
##     read.dbf, write.dbf
## 
## Loading required package: RSAGA
## Loading required package: gstat
## Loading required package: plyr
```

```r
# Files availbfrom from figshare at
# http://dx.doi.org/10.6084/m9.figshare.796429
rpygeo.geoprocessor("Buffer_analysis", args = list("sampleLoc.shp", "sampleLocB.shp", 
    "1000 meters"))
```

```
## NULL
```


Two downsides to this are it requires ArcGIS (and its associated cost) and for every geoprocessing step it creates a python script, fires up Arc, runs the command, and closes down Arc.  This is a bit resource heavy and slows down the analysis considerably.  Not much of an issue with smaller tasks, but for those analyses that are operating on many features idependently and/or have many steps, this can be a hinderance.

# Packages for Using R as a GIS

While the above options provide the full functionality of a GIS, they do require additional software, licenses, maintanenace, resources, etc.  Another, more streamlined solution for integrating R and GIS is to use several packages that prove a pure R solution to many of the same problems


# Getting Help

Aside from the normal places for getting help with R related issues (e.g. Stackoverflow, etc.).  Three additional and related sources of help are:
1. [CRAN Analysis of Spatial Data Task View](http://cran.r-project.org/web/views/Spatial.html) 
2. [r-sig-geo](https://stat.ethz.ch/mailman/listinfo/R-SIG-Geo/)
3. []()


