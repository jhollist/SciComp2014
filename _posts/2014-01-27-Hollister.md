---
layout: post
title: Course Introduction and Blog Posts with R Markdown
author: Jeff Hollister
---

This course is a follow up to the Software Carpentry R Bootcamp hosted by the US EPA and URI Coastal Institute on Jan 13-15, 2014 at the URI Coastal Institute.  The main idea behind having a separate, semester long course was to provide pariticpants of the bootcamp an opportunity to continue practicing the skills they were introduced to and also delve more deeply into some specific applications of R.  While we intend to have a few classes led by the instructors, our hope is that most of the classes and topics will be chosen, prepared, and presented by the students in the class.  The current list of topics and date of presentation is listed on our [course calendar](http://scicomp2014.edc.uri.edu/calendar.html) 

As we said, most of the course content is to be provided by the course participants. Instead of using traditional means of turning in and presenting this content, we are going to adopt a "practice what we preach" approach.  The rest of this post will layout what is expected in this regard.

# Blogging your homework

The first thing that will be a bit different about this class is that homework and presentations will be dealt with via the course [blog](http://scicomp2014.edc.uri.edu/posts.html).  All assignements are to be turned in as blog posts.  During the class, the blog post will serve as the basis for the discussion (much like the way material was presented during the bootcamp).  After class, the material will live on in the blog so that you may go back to it and try the reproducible examples included in these posts.  

To help faciliate the building of the blog, please use the following naming convention: 

`YEAR-MO-DY-LastName.Rmd`

If you are interested, the blogging platform we are using is the same platform that supports much of the Github website.  It is [Jekyll](http://jekyllrb.com/).  And to get completely Githuby, the course website is hosted on [Github pages](http://pages.github.com/) which are Jekyll aware.

# Using Git and Github to turn in assignments

The second thing we are trying with this course is to reinforce your understanding of Git and Github.  As such, to create your blog posts you will need to do the following:

1. Fork the [course repository](https://github.com/jhollist/SciComp2014) to your own repository on Github.
2. In RStudio, create a new project from version control.  The link for this is your newly forked repository on Github
3. In this new RStudio project, author your post in R Markdown and save the `.Rmd` in the `postsRMarkdown` folder.  
4. Commit as necessary.  When your post is complete, push it up to your forked repository on Github, and submit a pull request to have the `.Rmd` merged into the repository.  Adam, Pete, or Jeff will take care of getting the `.Rmd` into the blog.

# Writing up your work with R Markdown

Lastly, since R Markdown is new to many of you, the following provides some of the basics of R flavored Markdown and just enough YAML (i.e. "YAML Aint Markup Language") to help you create your own posts.

## YAML (YAML Ain't Markup Language)
First, let's start with YAML.  You won't really need to mess with this too much, but it needs to be included.  All you will need to do is include something like the following at the very top of the `.Rmd` document (e.g this is the YAML for this post).

```
---
layout: post
title: Course Introduction and Blog Posts with R Markdown
author: Jeff Hollister
---
```

So, for you own posts, include this same material (don't forget the `---` before and after).  Only difference will of course be the title and the author.

## Code Chunks
The main information in your posts will likely be R code.  To include R Code in your `.Rmd` you would do something like:

    ```{r}
    x<-rnorm(100)
    x
    ```
This identifies what is known as a code chunk.  When written like it is above, it will echo the code to your final document, evalute the code with R and echo the results to the final document.  There are some cases where you might not want all of this to happen.  You may want just the code returned and not have it evalutated by R.  This is accomplished with:

    ```{r eval=FALSE}
    x<-rnorm(100)
    ```

Alternatively, you might just want the output returned, as would be the case when using R Markdown to produce a figure in a presenation or paper:


    ```{r echo=FALSE}
    x<-rnorm(100)
    y<-jitter(x,1000)
    plot(x,y)
    ```
For the blog posts in this class, you will very likely use `eval=FALSE` on occassion, but not `echo=FALSE` as it will usually be the code you want to show.

Lastly, each of your code chunks can have a label.  That would be accomplished with something like:
 
    ```{r myFigure, echo=FALSE}
    x<-rnorm(100)
    y<-jitter(x,1000)
    plot(x,y)
    ```
    
For this class, please use informative labels for all of your code chunks.  

## Basic Markdown

Markdown is a tool that allows you to write simply formated text that is converted to HTML/XHTML.  Primary goal of markdown is readibility of the raw file.  For the basics of markdown look at [Daring Fireball](http://daringfireball.net/projects/markdown/basics).  To try it out [Dingus](http://daringfireball.net/projects/markdown/dingus) works well.  And for another view, the RStudio crew has some great information specifically on [R Markdown](http://www.rstudio.com/ide/docs/authoring/using_markdown).

To get you started, here is some of that same information on the most common markdown you will use in your posts: Text, Headers, Lists, Links, and Images.

### Text

So, for basic text... Just type it!

### Headers

In pure markdown, there are two ways to do headers; however in R Markdown with `knitr` those two get parsed a bit differently.  The first way looks like:

```
Header1
=======
```
In the ouput HTML created by Knitting your `.Rmd`, this creates both an H1 header as well as a title tag.  This is useful when creating R Presentations, but less so with blog posts with Jekyll.  For the blog posts, you will use the following for headers:

```
# Header 1
## Header 2
...
###### Header 6
```

### List

Lists can be done many ways in markdown.  For this tutorial we will focus on unordered and ordered lists. An unordered list is simply done with a `-`.  For example

- this list
- is produced with
- the following 
- markdown.

```
- this list
- is produced with
- the following 
- code
```
Notice the space after the `-`.  With most markdown interpreters, you can nest lists.  These are not currently getting parsed correctly on the course website.  Not sure why...

To create an ordered list, simple use numbers.  So to produce:

1. this list
2. is produced with
3. the following
4. markdown.

```
1. this list
2. is produced with
3. the following
4. markdown.
```

Note that the actual numbers you use to create the ordered list do not matter.  When you start a list with a number of a letter, the HTML that gets created sees it as an ordered lists and will order and label to item appropriately.

### Links and Images

Last type of formatting that you will likely want to accomplish with R markdown is including links and images.  While these two might seem dissimilar, I am including them together as their syntax is nearly identical.

So, to create a link you would use the following:

```
[Course Website](http://scicomp2014.edc.uri.edu)
```

The text you want linked goes in the `[]` and the link itself goes in the `()`.  That's it! Now to show an image, you simply do this:

```
![CI Logo](http://www.edc.uri.edu/nrs/classes/nrs592/CI.jpg?s=150)
```

The only difference is the use of the `!` at the beginning.  When parsed, the image itself will be included, and not just linked text.  As these will be on the web, the images need to also be available via the web.  You can link to local files, but will need to use a relative path and you will need to make sure the image gets moved to the class Github repoitory.  If you want to do that, talk to [Jeff](mailto:hollister.jeff@epa.gov).  It's easy, but beyond the scope of this tutorial.

# Summary

So, with the basics listed here, you should now be able to fork the repo, clone it locally, create your post in markdown and submit it via a pull request!
