



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

command_transition <- matrix(as.integer(c(
  #1,  2,  3   # The 3 commands --each column represents a command's 4 preferences.
# 3, 3, 2,  # Officer 1
# 2, 2, 1,  # Officer 2
# 1, 4, 3,  # Officer 3
# 4, 1, 4   # Officer 4
  1, 3, 2,  # Officer 1
  2, 1, 3,  # Officer 2
  3, 2, 1,  # Officer 3
  4, 4, 4   # Officer 4
)), ncol=3, byrow=TRUE)

officer_transition <- matrix(as.integer(c(
  #1,  2,  3,  4   # The 4 officers --each column represents an officer's 3 preferences.
  1, 3, 2, 3,  # Command 1
  2, 1, 3, 1,  # Command 2
  3, 2, 1, 2   # Command 3
)), ncol=4, byrow=TRUE)
```



```r
matchingR::galeShapley.validate(
  reviewerPref = officer_transition,
  proposerPref = command_transition
)
```

```
## $proposerPref
##      [,1] [,2] [,3]
## [1,]    0    2    1
## [2,]    1    0    2
## [3,]    2    1    0
## [4,]    3    3    3
## 
## $proposerUtils
##      [,1] [,2] [,3]
## [1,]    0   -1   -2
## [2,]   -1   -2    0
## [3,]   -2    0   -1
## [4,]   -3   -3   -3
## 
## $reviewerUtils
##      [,1] [,2] [,3] [,4]
## [1,]    0   -1   -2   -1
## [2,]   -1   -2    0   -2
## [3,]   -2    0   -1    0
```

```r
matchingR::galeShapley.collegeAdmissions(
  collegePref = command_transition,
  studentPref = officer_transition,
  slots = 1
)
```

```
## $unmatched.students
## [1] 4
## 
## $unmatched.colleges
## numeric(0)
## 
## $matched.colleges
##      [,1]
## [1,]    1
## [2,]    3
## [3,]    2
## 
## $matched.students
##      [,1]
## [1,]    1
## [2,]    3
## [3,]    2
## [4,]   NA
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
##  [5] R6_2.2.0         grid_3.3.1       plyr_1.8.4       gtable_0.2.0    
##  [9] DBI_0.5-1        evaluate_0.10    scales_0.4.1     stringi_1.1.2   
## [13] lazyeval_0.2.0   tools_3.3.1      stringr_1.1.0    readr_1.0.0     
## [17] munsell_0.4.3    colorspace_1.3-2 matchingR_1.2.1  knitr_1.15.1    
## [21] tibble_1.2
```

```r
Sys.time()
```

```
## [1] "2016-12-21 15:12:43 CST"
```

