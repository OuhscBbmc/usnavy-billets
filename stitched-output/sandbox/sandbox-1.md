



This report was automatically generated with the R package **knitr**
(version 1.15.1).


```r
# knitr::stitch_rmd(script="./sandbox/sandbox-1.R", output="./stitched-output/sandbox/sandbox-1.md")
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.
```


```r
# Run this line if necessary: install.packages(c("magrittr", "ggplot2", "matchingMarkets", "readr", "tidyr", "dplyr"))

# Attach these packages so their functions don't need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
library(magrittr, quietly=TRUE)
library(ggplot2, quietly=TRUE)

# Verify these packages are available on the machine, but their functions need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
requireNamespace("matchingR")  # devtools::install_version("jtilly/matchingR")
# requireNamespace("matchingMarkets")  # devtools::install_version("matchingMarkets", version = "0.2-1", repos = "http://cran.us.r-project.org")
requireNamespace("readr")
requireNamespace("tidyr")
requireNamespace("dplyr") #Avoid attaching dplyr, b/c its function names conflict with a lot of packages (esp base, stats, and plyr).
```

```r
# Constant values that won't change.

command_transition <- matrix(c(
  #1,  2,  3   # The 3 commands --each column represents a command's 4 preferences.
  3L, 3L, 2L,  # Officer 1
  2L, 2L, 1L,  # Officer 2
  1L, 4L, 3L,  # Officer 3
  4L, 1L, 4L   # Officer 4
), ncol=3, byrow=TRUE)

officer_transition <- matrix(c(
  #1,  2,  3,  4   # The 4 officers --each column represents an officer's 3 preferences.
  2L, 3L, 1L, 3L,  # Command 1
  1L, 1L, 3L, 1L,  # Command 2
  3L, 2L, 2L, 2L   # Command 3
), ncol=4, byrow=TRUE)
```



```r
matchingR::galeShapley.validate(
  reviewerPref = command_transition,
  proposerPref = officer_transition
)
```

```
## $proposerPref
##      [,1] [,2] [,3] [,4]
## [1,]    1    2    0    2
## [2,]    0    0    2    0
## [3,]    2    1    1    1
## 
## $proposerUtils
##      [,1] [,2] [,3] [,4]
## [1,]   -1   -1    0   -1
## [2,]    0   -2   -2   -2
## [3,]   -2    0   -1    0
## 
## $reviewerUtils
##      [,1] [,2] [,3]
## [1,]   -2   -3   -1
## [2,]   -1   -1    0
## [3,]    0    0   -2
## [4,]   -3   -2   -3
```

```r
matchingR::galeShapley.collegeAdmissions(
  collegePref = command_transition,
  studentPref = officer_transition
)
```

```
## $unmatched.students
## [1] 1
## 
## $unmatched.colleges
## numeric(0)
## 
## $matched.colleges
##      [,1]
## [1,]    3
## [2,]    4
## [3,]    2
## 
## $matched.students
##      [,1]
## [1,]   NA
## [2,]    3
## [3,]    1
## [4,]    2
```

```r
# m <- matchingMarkets::hri(
#   c.prefs = command_transition, #College/command preferences (each officer is a row)
#   s.prefs = officer_transition, #Student/officer preferences (each command is a row)
#   nSlots  =c(1,1,1)
# )
# # print(m)
#
```

The R session information (including the OS info, R version and all
packages used):


```r
sessionInfo()
```

```
## R version 3.3.1 (2016-06-21)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 16.04.1 LTS
## 
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                 
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
## [1] ggplot2_2.2.0 magrittr_1.5 
## 
## loaded via a namespace (and not attached):
##  [1] Rcpp_0.12.8      tidyr_0.6.0      dplyr_0.5.0.9000 assertthat_0.1  
##  [5] R6_2.2.0         grid_3.3.1       plyr_1.8.4       DBI_0.5-1       
##  [9] gtable_0.2.0     evaluate_0.10    scales_0.4.1     stringi_1.1.2   
## [13] lazyeval_0.2.0   testit_0.6       tools_3.3.1      readr_1.0.0     
## [17] stringr_1.1.0    markdown_0.7.7   munsell_0.4.3    colorspace_1.3-2
## [21] matchingR_1.2.1  knitr_1.15.1     tibble_1.2
```

```r
Sys.time()
```

```
## [1] "2016-12-21 00:51:17 CST"
```

