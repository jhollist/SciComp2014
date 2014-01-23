---
layout: post
title: Course Introduction and Blog Posts with R Markdown
author: Jeff Hollister
---

This course is a follow up to the Software Carpentry R Bootcamp hosted by the US EPA and URI Coastal Institute on Jan 13-15, 2014 at the URI Coastal Institute.  The main idea behind having a separate, semester long course was to provide pariticpants of the bootcamp an opportunity to continue practicing the skills they were introduced to and also delve more deeply into some specific applications of R.  While we intend to have a few classes led by the instructors, our hope is that most of the classes and topics will be chosen, prepared, and presented by the students in the class.  The current list of topics and date of presentation is listed on our [course calendar](http://scicomp2014.edc.uri.edu/calendar.html) 

As we said, most of the course content is to be provided by the course participants. Instead of using traditional means of turning in and presenting this content, we are going to adopt a "practice what we preach" approach.  The rest of this post will layout what is expected in this regard.

### Blogging your homework

The first thing that will be a bit different about this class is that homework and presentations will be dealt with via the course blog.  All assignements are to be turned in as blog posts.  During the class, the blog post will serve as the basis for the discussion (much like the way material was presented during the bootcamp).  After class, the material will live on in the blog so that you may go back to it and try the reproducible examples included in these posts.  

To help faciliate the building of the blog, please use the following naming convention: `YEAR-MO-DY-LastName.Rmd`

If you are interested, the blogging platform we are using is the same platform that supports much of the Github website.  It is [Jekyll](http://jekyllrb.com/).  [Github pages](http://pages.github.com/) are Jekyll aware and automatically parse all appropriately formated pages.

### Using Git and Github to turn in assignments

The second thing we are trying with this course is to reinforce your understanding of Git and Github.  As such, to create your blog posts you will need to do the following:

1. Fork the [course repository](https://github.com/jhollist/SciComp2014) to your own repository on Github.
2. In RStudio, create a new project from version control.  The link for this is your newly forked repository on Github
3. In this new RStudio project, author your post in R Markdown and save the `.Rmd` in the `postsRMarkdown` folder.  
4. Commit as necessary.  When your post is complete, push it up to your forked repository on Github, and submit a pull request to have the `.Rmd` merged into the repository.  Adam, Pete, or Jeff will take care of getting the `.Rmd` into the blog.

### Writing up your work with R Markdown

Lastly, since R Markdown is new to many of you, the following provides some of the basics of R flavored Markdown and YAML (i.e. "YAML Aint Markup Language") to help you create your own posts.

Some basics to get your started are below, expect more soon.

This is an R Markdown document. Markdown is a simple formatting syntax for authoring web pages (click the **Help** toolbar button for more details on using R Markdown).

When you click the **Knit HTML** button a web page will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:


```r
summary(cars)
```

```
##      speed           dist    
##  Min.   : 4.0   Min.   :  2  
##  1st Qu.:12.0   1st Qu.: 26  
##  Median :15.0   Median : 36  
##  Mean   :15.4   Mean   : 43  
##  3rd Qu.:19.0   3rd Qu.: 56  
##  Max.   :25.0   Max.   :120
```


You can also embed plots, for example:



```r
plot(cars)
```

![plot of chunk unnamed-chunk-2](/figure/unnamed-chunk-2.png) 





