---
layout: post
title: My First Blog Post
author: Nana LaRue
---

This is simply a template for the NRS529 Blog Posts.  

When you start you post all you need to do is:

1. Open the template file
2. Save this with the following naming convention: `YEAR-MO-DY-LastName.Rmd`
3. Edit the `YAML`.
4. Write your post
5. Save the `.Rmd` in postsRMarkdown
6. Commit changes (you can use the `Git` tab in RStudio).
7. Push those changes back up to your repository on GitHub.
8. Submit a pull request.

To make it a bit easier, here are some of the things mentioned on the first day of class.

This example with echo and evaluate.


```r
x <- rnorm(100, 10, 5)
y <- jitter(x, 1000)
z <- vector("character", 100)
z[x > 10] <- "High"
z[x < 10] <- "Low"
df <- data.frame(x, y, z)
df
```

```
##            x       y    z
## 1    9.52080  8.9117  Low
## 2    6.16287  5.0884  Low
## 3   11.98127 11.5089 High
## 4   12.86336 12.5593 High
## 5   15.40990 14.7359 High
## 6   10.07027  8.6361 High
## 7    7.00281  8.5849  Low
## 8    3.07573  2.3489  Low
## 9   10.23054  9.2476 High
## 10   9.93746 10.4809  Low
## 11   6.87055  8.5158  Low
## 12  13.42141 14.7023 High
## 13  12.86742 13.7237 High
## 14   9.00847  7.2508  Low
## 15   8.70327 10.3472  Low
## 16  20.29944 19.1052 High
## 17  12.32783 14.2101 High
## 18  11.02198  9.4349 High
## 19  13.39836 11.5157 High
## 20   5.05418  5.2017  Low
## 21  10.25400 10.7153 High
## 22  13.80454 13.8475 High
## 23   3.82563  5.7208  Low
## 24  19.96961 20.0371 High
## 25  11.00943 11.4073 High
## 26   5.66948  7.6607  Low
## 27  19.69666 21.5118 High
## 28   0.08457  0.9433  Low
## 29   5.42734  4.7959  Low
## 30   3.01197  1.3195  Low
## 31  20.55598 21.1462 High
## 32  14.07798 12.1679 High
## 33  11.18454 10.6558 High
## 34  10.17968  8.8398 High
## 35  16.96029 17.9406 High
## 36  12.07619 11.3910 High
## 37   5.48379  4.6599  Low
## 38   5.84222  4.6346  Low
## 39   4.68886  6.6638  Low
## 40  11.37296 11.2442 High
## 41   8.41744  8.1062  Low
## 42  12.50867 11.0209 High
## 43  16.01453 15.5639 High
## 44   6.31844  5.6158  Low
## 45  20.38600 20.1678 High
## 46   8.29586 10.1652  Low
## 47   4.13609  2.2171  Low
## 48   6.29621  5.9428  Low
## 49  13.15181 11.2397 High
## 50  18.45158 17.5070 High
## 51   7.24149  6.1911  Low
## 52  10.66265 12.6100 High
## 53  11.87401 11.9125 High
## 54   1.27169  1.0921  Low
## 55   7.80469  8.5708  Low
## 56  12.92293 14.1024 High
## 57  16.17248 15.3943 High
## 58  12.97100 11.5499 High
## 59  11.76647 13.5852 High
## 60   7.35435  7.9253  Low
## 61  10.80605  9.8378 High
## 62   4.32533  3.2860  Low
## 63   2.17248  3.8289  Low
## 64   9.61442  9.3848  Low
## 65  15.38595 16.5334 High
## 66  15.90398 17.3757 High
## 67  12.42209 11.3009 High
## 68   0.70164 -0.2916  Low
## 69  10.85863  8.9017 High
## 70  18.29959 20.2582 High
## 71  11.47739 12.4168 High
## 72  19.70757 20.9516 High
## 73   6.65503  7.7851  Low
## 74  13.00651 12.0558 High
## 75   7.95328  8.3468  Low
## 76  17.09943 16.8428 High
## 77  20.88006 20.6919 High
## 78  16.00297 14.7021 High
## 79   9.69637  8.5006  Low
## 80  -0.21538 -1.0006  Low
## 81  10.77942 11.1622 High
## 82   8.16827  6.6487  Low
## 83   7.30255  5.7815  Low
## 84   8.24362  9.1876  Low
## 85   9.63825  8.4873  Low
## 86   6.38721  5.1856  Low
## 87  18.29153 17.1404 High
## 88  13.64800 14.1530 High
## 89  20.72228 21.3146 High
## 90   3.02167  3.5551  Low
## 91   8.79943  9.5321  Low
## 92  15.85122 15.7945 High
## 93   2.42224  0.7194  Low
## 94  10.88890 12.6582 High
## 95   7.49463  8.8430  Low
## 96  -0.57960  0.4627  Low
## 97  16.46537 18.2189 High
## 98  13.35817 12.8208 High
## 99  15.83641 14.1718 High
## 100 17.38258 16.5712 High
```


And an example that just echo's the code without evaluation:


```r
# This is what a comment looks like
print("Some stuff to print (but not really, becuase this isn't evaluated!")
```


Here's a plot, without echoing :

![plot of chunk myPlot](/figure/myPlot.png) 


And to get more on this, check out [the first class blog post](http://scicomp2014.edc.uri.edu/posts/2014-01-27-Hollister.html)

