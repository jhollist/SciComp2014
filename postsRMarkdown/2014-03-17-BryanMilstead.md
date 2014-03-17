---
layout: post
title: Template
author: Your Name
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
## 1    8.70990  7.1993  Low
## 2    0.09533  0.8331  Low
## 3   15.80147 17.0996 High
## 4    4.19741  2.7664  Low
## 5   11.03033 10.6355 High
## 6   14.13013 15.8379 High
## 7    7.97839  9.0260  Low
## 8   10.96577 10.2542 High
## 9    8.37726  8.0835  Low
## 10  17.78995 19.1114 High
## 11  12.88248 14.6124 High
## 12  11.31893 11.3804 High
## 13  10.62292  9.9529 High
## 14  21.57645 20.2237 High
## 15  10.90417  9.0353 High
## 16  11.99958 12.7615 High
## 17  11.59432 12.6227 High
## 18  11.87293 10.3530 High
## 19   6.63247  7.1765  Low
## 20  19.11135 19.3304 High
## 21   8.72840  7.4756  Low
## 22  13.31003 14.7049 High
## 23   7.88879  8.4403  Low
## 24  10.04807 10.1287 High
## 25  12.88949 12.2693 High
## 26  11.10404 10.7628 High
## 27  12.40753 11.4997 High
## 28  -1.34224 -1.0672  Low
## 29  11.31479 11.5304 High
## 30  -0.26198 -0.6634  Low
## 31  13.41923 14.8349 High
## 32  13.70764 14.2784 High
## 33  16.25316 17.4514 High
## 34  18.19661 20.1067 High
## 35  13.06155 11.6750 High
## 36   7.65262  9.1740  Low
## 37   8.54458  7.4592  Low
## 38   5.51925  4.5462  Low
## 39   8.06514  9.3108  Low
## 40   7.62921  8.7111  Low
## 41  13.82529 14.9579 High
## 42   9.00061  9.1352  Low
## 43   4.87723  4.1091  Low
## 44   9.52951  8.9034  Low
## 45   8.76991 10.6553  Low
## 46   9.64637 10.8197  Low
## 47   7.44103  5.4589  Low
## 48  14.53694 14.9227 High
## 49   4.32208  3.6205  Low
## 50  12.30605 12.4327 High
## 51   9.79804 11.5689  Low
## 52  10.82664 10.4438 High
## 53  19.48115 17.8064 High
## 54   2.12645  2.6615  Low
## 55   7.94434  8.3203  Low
## 56  14.14511 14.0517 High
## 57   7.84302  8.3681  Low
## 58  14.89053 14.3433 High
## 59   9.43247  8.3417  Low
## 60  10.49522 11.6736 High
## 61   1.91910  2.6132  Low
## 62   6.39064  5.6886  Low
## 63  13.36186 11.6916 High
## 64  20.22514 18.7078 High
## 65  13.27143 12.7590 High
## 66  -0.84375 -0.7157  Low
## 67  16.47575 18.4173 High
## 68  12.80745 11.3477 High
## 69  -3.06529 -3.2562  Low
## 70  10.45729  9.8919 High
## 71   4.88264  5.3212  Low
## 72   2.21800  2.9728  Low
## 73  11.38635 12.5703 High
## 74   6.84894  7.9371  Low
## 75   3.02271  3.7320  Low
## 76   9.75937  9.0806  Low
## 77   8.31768  9.2074  Low
## 78   7.74611  7.3175  Low
## 79  14.04458 13.2791 High
## 80   3.10569  4.3806  Low
## 81   8.15555  8.3857  Low
## 82  11.35495 12.4428 High
## 83  22.97869 21.7763 High
## 84   7.04228  7.6121  Low
## 85  14.97015 14.7225 High
## 86  10.53568  9.0404 High
## 87   7.51014  8.5128  Low
## 88  13.43399 12.7342 High
## 89   7.20512  9.1023  Low
## 90  17.72277 18.3503 High
## 91  17.12614 15.3293 High
## 92   7.01674  5.0699  Low
## 93  12.57485 12.9292 High
## 94   8.89721 10.7831  Low
## 95  14.97496 16.7608 High
## 96  14.94558 15.5773 High
## 97   2.54692  0.6439  Low
## 98   9.40160  9.9471  Low
## 99  12.05258 12.6418 High
## 100  9.64184  8.9455  Low
```


And an example that just echo's the code without evaluation:


```r
# This is what a comment looks like
print("Some stuff to print (but not really, becuase this isn't evaluated!")
```


Here's a plot, without echoing :

![plot of chunk myPlot](figure/myPlot.png) 


And to get more on this, check out [the first class blog post](http://scicomp2014.edc.uri.edu/posts/2014-01-27-Hollister.html)

