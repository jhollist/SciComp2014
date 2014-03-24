---
layout: post
title: Nutrient Totals in R (Or leaving MS Excel behind)
author: Rahat Sharif
---

### Background:
I’m part of a group at the bay campus, including Dr. Veronica Berounsky and Dr. Lucie  Maranda that studies the Narrow River. 
![sitemap](https://dl.dropboxusercontent.com/sh/raw4hjjak4lseao/8fATBgnXDQ/Screen%20Shot%202014-03-23%20at%206.08.06%20PM.png?dl=1&token_hash=AAEq2ih9CinuRuXDSOfYfspN5YzlA83BQmh0ZUFfC4rIPQ)

I take datasets like this:

![exdata](https://dl.dropboxusercontent.com/s/50j57r6zfy9d3zg/exampledata.png)

Try to turn them into something visually and quantitatively meaningful for analysis, like this:

![DOex](https://dl.dropboxusercontent.com/s/j7ibt6mpnwwdwi3/DOtime.png)

One of the Study sites we’re interested is the Northern Basin in the Narrow River. It’s a 13 meter deep basin with an hypoxic bottom, overlain with oxygenated waters. We’re currently looking at an overturn that occurred in 2007. Our question is, what is happening to the nutrients right after the overturn?

![upperpond](https://dl.dropboxusercontent.com/s/a0gv1s29ys4d19y/sitemap.png)

At first we used a program called Ocean Data View to look at nutrients the way I had  above.

This however, while visually effective, is not very meaningful from a quantitative view. 

It is pretty obvious that oxygen is increasing, but is there a definitive way to quantify this? This is a more important question to answer where looking at graphs that may not be so telling, such as:

![amexamp](https://dl.dropboxusercontent.com/s/e2kpvnmwu4joj6w/AM.png)

There does seem to be a large amount of Ammonium before October 30, but in order to definitively say that, the concentration needs to be put into a larger context: 


![3d](https://dl.dropboxusercontent.com/s/hqeq5w7lwwwzkcx/383259_10200994441160210_822413854_n.jpg)

Since the pond is shaped like a bowl, a reading at the bottom (gray area), while high, may not contribute that much to the rest of the basin given its small volume.




In order to account for the size of the basin, we decided to multiply the volumes at each depth with the corresponding concentration, then get a sum, and graph the change overtime, calculating would be done in excel like this: 

![calc](https://dl.dropboxusercontent.com/s/3rlei49o2scqc8h/Calc.png)

The end result should be a nice graph like this:

![AMquan](https://dl.dropboxusercontent.com/s/z4ax4fq7aje9jub/amquan2.png)


### So what’s the problem?:

In order to employ this method, points need to be interpolated for each graph.
For example, if nutrient samples were taken at 0.5, 3, and 5, interpolations will need to be done to find the concentrations for 1, 2, and 4; for each profile. This cannot be automated because there is no set pattern for how nutrients change in the water column (the slope of the line will change between different known points).

Interpolations will have to be done for each profile, between every pair of known points, in excel.

### Why use R?:
This method may be repeated for future studies on the Narrow River, and should be repeatable using the same reliable method, as well as well-organized and easy to document.  Not so easy with excel. 
A computer is much more reliable at calculating things than a human being. 
 
Using R (with the kinks figured out) should be a lot less time consuming than using excel.



### My Plan:

Design a program that is user friendly, takes minimal user inputs, and gives out a nice graph. 


### Attempt one:

```r
#This is for Upper Pond only
#Column names cannot start with numbers, or R will append an x to the label
#Slashes will be turned into "."
#I added a few notes for the user so that they wouldn’t run into of the caveats that I had

Nutrient_Interpolation<-function(fileloc,filename,depthfield,nutrientfield,volumefield)
{

#The inputs were the relevant variables to run the function
```

  #Set workspace
		setwd(fileloc)
		D<-read.csv(filename) #load data
		n<- D[[depthfield]]
	for (i in nutrientfield){
			predict<-	approx(D[[depthfield]],D[[i]],xout=c(0.5,1,2,3,4,5,6,7,8,9,10,11)) #Does the interpolation
			#print(predict$y)
			#print(i)
			#print(predict$x*-1)# debugging
			plot(predict$y,predict$x*-1, xlab="nutrient_value",ylab="depth", col="blue") 
      # a nice graph, as well as a check to see if it’s working
			points(D[[i]],D[[depthfield]]*-1,col="yellow",pch=11)
			plottitle<-colnames(D)
			title(main=plottitle[i], sub="Upper Pond")
			print(colnames(predict))
			colnames(predict)<-c("depth",plottitle[3])
			n<-table(n,predict$y)
						print(n)
						}
						n<-D[[volumefield]]
		write.csv(n,file="interpolated_values.csv")#getting the data

	}
```

#### Issues with attempt one

* Too many user inputs
*	Only writes to one column
*	Depths are hard wired into the function (which won’t work if another site is being studied with the same method)
*	Doesn’t give the output needed
*	Need something 
  * More complete
  * Less complicated for the user


### Attempt two:


```r
Rahatcalc <- function() {
    fileloc <- readline("Where is the file?: ")
    setwd(fileloc)
    filename <- readline("What is the name of your file?: ")
    ds <- paste(filename, ".csv", sep = "")
    x <- read.csv(ds)
    profile <- readline("What are the depths of your profile?: ")
    volume <- readline("What are the volumes of your profile?: ")
    variable <- readline("Name of variable of interest: ")
    
    # User is prompted for inputs instead of needing to remember what to input
    
    for (z in x[["Date"]]) {
        for (i in x[[variable]]) {
            predict <- approx(x[["Depth"]], x[[variable]], xout = profile)
            interp <- append(interp, predict * volume)
            totals <- append(totals, sum(interp))
            history <- append(history, z)
        }
        results <- data.frame(totals, history)
    }
    # title<-readline('What is the name of your study site?: ')
    # answer<-readline('Do you want a graph? Y/N') if (answer== Y){
    # library(ggplot2) ggplot(results,aes(x=history,y=total)}
    # else(){answer2<-readline('Do you want to save your file? Y/N')) if
    # answer2==Y(){ write.table(results,file==''} }
}
```

#### About attempt two
* Prompts the user
* R does the rest automatically
* Needs more debugging
* Needs to be more user friendly
* Work in progress
