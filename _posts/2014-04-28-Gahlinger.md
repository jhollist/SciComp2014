---
layout: post
title: Using R to extract ZIP codes from Excel text field
Author: Greg Gahlinger
---

## Extracting Shipping Container Destination ZIP Code Data
Object is to use an available Excel file (.csv) with imported shipping container data for the Port of New York and extract ZIP code destination as a text field.

![Container](/figure/containers.png)

### Load required packages

```r
# Make sure these are installed first (e.g., install.packages('plyr',
# dependencies = TRUE))
toLoad = c("plyr", "stringr", "choroplethr", "zipcode")
sapply(toLoad, require, character.only = TRUE)
```

```
## Loading required package: choroplethr
## Loading required package: zipcode
```

```
##        plyr     stringr choroplethr     zipcode 
##        TRUE        TRUE        TRUE        TRUE
```

```r
rm(toLoad)

# Set option to make sure data columns are read as character strings, not
# factors
options(stringsAsFactors = FALSE)
```


### Load .csv file (with container consignee data) into R object called 'dat'

```r
dat <- read.csv("C:/temp/NYCSV.csv", header = TRUE)
# str(dat)
```


### Calculate two new columns in the data set
1.  'zip' contains the attempt to extract the zip code from the Consignee.Address column
2.  'misszip' is a logical column indicating whether no potential zip code was found

```r
dat <-  mutate(dat,
               # Looks for a 5 digit number
               zip = str_extract(Consignee.Address, "[0-9]{5}"), 
               # Look for a 4 digit number with preceding uppercase O 
               zip = ifelse(nchar(zip) == 5, zip, str_extract(Consignee.Address, "O[0-9]{4}")),
               # Look for a 4 digit number with preceding lowercase O 
               zip = ifelse(nchar(zip) == 5, zip, str_extract(Consignee.Address, "o[0-9]{4}")),
               # If no matches are found, record it as a missing zip code
               misszip = ifelse(nchar(zip) == 5, FALSE, TRUE),
               # Replace any Os or os with zeros(0)
               zip = gsub("o", "0", zip, ignore.case = TRUE))
```


### Calculate percentage of record with missing zip code

```r
round(100 * sum(dat$misszip)/nrow(dat), 1)
```

```
## [1] 36.4
```


### Plot at zip code level

```r
# Summarize by zip code
zipsum <- ddply(dat, .(zip), summarize, value = length(zip))
# Modify to work with choroplethr function
zipsum <- mutate(zipsum, region = zip)
# Plot number by zip
choroplethr(zipsum, "zip", title = "Container destination by zip code")
```

![plot of chunk unnamed-chunk-5](/figure/zip.png) 


### Aggregate to and plot at the state level

```r
data(zipcode)
# Associate zip code with it's state
statesum <- join(zipsum, zipcode, by = "zip")
# Count containers going to each state
statesum <- ddply(statesum, .(state), summarize, value = sum(value))
# Modify to work with choroplethr function
statesum <- mutate(statesum, region = state)
# Plot state level data
choroplethr(statesum, "state", title = "Container destination by state")
```

![plot of chunk unnamed-chunk-6](/figure/state.png) 

