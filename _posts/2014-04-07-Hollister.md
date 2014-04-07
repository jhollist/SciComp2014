---
layout: post
title: Reproducible Presentations with Slidify and RStudio
author: Jeff Hollister
---

The goals for this post is to introduce the concept of using R Markdown to create reproducible presentations (aka, how to ditch Powerpoint).  I am going to show two different ways to do this one with an R package `slidify` and another with R Presentations in R Studio.  As we go through this, you should hopefully see a lot of overlap in what you have already seen with writing blog posts.  In other words, the tools are the same, just some different processing steps to get the final output.

During today's class we will cover the basics of styling, and some basic workflows for creating presentations.  If there is time, I will give a presentation, created with `slidify`, on blogging and social media for scientists just so you can see one of these in action.

# Few things to think about

As the standard for presentations for so long has been .ppt(x), using a different format requires a bit of a shift in thinking.  Some things to keep in mind:

1. Output format is html5
2. Simply display using a browser
3. Printing and pdf creation possible: Some options better than others

# Styling

Styling tends to be one of the biggest sources of dithering when it comes to creating presentations (for associated developer term see [yak shaving](http://en.wiktionary.org/wiki/yak_shaving)) .  Reproducible presentations are no different.  Only difference is you do need to know some CSS in order to customize presentations yourself.

We are not going to spend too much time on this, but if you want to see some of what is required to make changes you can (warning: shameless self-promotion ahead) read through [a blog post of mine](http://landeco2point0.wordpress.com/2013/11/07/r-studio-and-presentations-and-git-oh-my/) that includes some of this.

Also, you can look at some [custom CSS ](https://github.com/jhollist/epablogpresent/blob/gh-pages/assets/css/jwhSlidifyStyle.css) I spent way too much time modifying for some recent presentations.

# Slidify

The first method for creating presentations we will talk about is `slidify`, created by [Ramnath Vaidyanathan](https://github.com/ramnathv) who has also created some other great packages including `rCharts` and `rMaps`.  Getting a presentation up and running is quite simple.  The following code should be sufficient:


```r
# Install and load necessary packages
install.packages("devtools")
library(devtools)
install_github("slidify", "ramnathv")
install_github("slidifyLibraries", "ramnathv")
library(slidify)

# Creates the skeleton for the present
author("scicomp")
```


With this done, you can now fire up your editor of choice (we will just do this directly in RStudio) and edit `index.Rmd'

When you have your .Rmd edited to your satisfaction run the following code:


```r
slidify("index.Rmd")
```


This will create the `index.html` and that file can now be viewed in any browser (err, if that means Chrome, Firefox, or Safari).

For an live presentation, we can check out a presentation I recently gave on [Blogging, Social Media, and Science](http://jwhollister.com/epablogpresent) and for under the hood we can [look at the repo](https://github.com/jhollist/epablogpresent).

# R Presentation Workflow

Using slidify is great and does not require RStudio, but it does require a bit more work.  The next two presentation workflows are from RStudio directly and, if you don't want to edit are very easy.

## R Presentation

This first workflow is part of the stable distribution of RStudio, so you should all have it available.

1. Go to File: New File: R Presentation
2. Edit
3. In Preview Pane: More: Save as Web Page

Let's look at an example of [a customized version](http://jwhollister.com/urimesm) of this as well as the [repo for it](https://github.com/jhollist/urimesm).

## Rmd as Presentation - Preview Version of Rstudio (Version 0.98.745)

This workflow is (as of 4/7/14) only available via the [preview version](http://www.rstudio.com/ide/download/preview).

To start this do the following:

1. Go to File: New File: R Markdown.
2. Select Presentation, select an output format and click OK.
3. Edit
4. Knit HTML (or PDF if Beamer)







