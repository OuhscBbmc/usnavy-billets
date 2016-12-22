



This report was automatically generated with the R package **knitr**
(version 1.15.1).


```r
# knitr::stitch_rmd(script="./sandbox/sandbox-2.R", output="./stitched-output/sandbox/sandbox-2.md")
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.
```


```r
# Run this line if necessary: install.packages(c("magrittr", "ggplot2", "matchingMarkets", "readr", "tidyr", "dplyr"))

# Attach these packages so their functions don't need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
library(magrittr, quietly=TRUE)
library(ggplot2, quietly=TRUE)

# Verify these packages are available on the machine, but their functions need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
requireNamespace("matchingR")  # devtools::install_version("jtilly/matchingR")
```

```
## Loading required namespace: matchingR
```

```r
# requireNamespace("matchingMarkets")  # devtools::install_version("matchingMarkets", version = "0.2-1", repos = "http://cran.us.r-project.org")
requireNamespace("readr")
```

```
## Loading required namespace: readr
```

```r
requireNamespace("tidyr")
```

```
## Loading required namespace: tidyr
```

```r
requireNamespace("dplyr") #Avoid attaching dplyr, b/c its function names conflict with a lot of packages (esp base, stats, and plyr).
```

```
## Loading required namespace: dplyr
```

```r
# Constant values that won't change.

convert_utility_to_preference <- function( utility ) {
  p <- apply(utility, 2, function( x ) {
    # Determine the order of (negative) values within a row.
    s <- sort.list(x, decreasing=T)

    # Re-establish the missing values.
    missing_indices <- which(is.na(x))
    ifelse(s %in% missing_indices, NA_integer_, s)
  })

  # Return the preference matrix to the caller.
  return( p )
}

# Each element is the rank (1 is the command's top choice).
commmand_utility <- -matrix(as.integer(c(
  # 3, 3, 2,  # Officer 1
  # 2, 2, 1,  # Officer 2
  # 1, 4, 3,  # Officer 3
  # 4, 1, 4   # Officer 4
#C1, C2, C3   # The 3 commands --each column represents a command's 4 preferences.
  1,  3,  2,  # Officer 1
  2,  1, NA,  # Officer 2
  3,  2,  1,  # Officer 3
  4,  4, NA   # Officer 4
)), ncol=3, byrow=TRUE)

# convert_utility_to_preference(commmand_utility)

# Each element is the rank (1 is the officer's top choice).
officer_utility <- -matrix(as.integer(c(
#O1, O2, O3, O4   # The 4 officers --each column represents an officer's 3 preferences
  1,  3,  2,  2,  # Command 1
  2,  1,  3, NA,  # Command 2
  3,  2,  1,  1   # Command 3
)), ncol=4, byrow=TRUE)


# Each element is the officer index/id
command_preference <- matrix(as.integer(c(
#C1,C2,C3   # The 3 commands --each column represents a command's 4 preferences.
  1, 2, 3,  # Preference 1
  2, 3, 1,  # Preference 2
  3, 1,NA,  # Preference 3
  4, 4,NA   # Preference 4
)), ncol=3, byrow=TRUE)

# Each element is the command index/id
officer_preference <- matrix(as.integer(c(
#O1, O2, O3, O4   # The 4 officers --each column represents an officer's 3 preferences
  1, 2, 3, 3,  # Preference 1
  2, 3, 1, 1,  # Preference 2
  3, 1, 2,NA   # Preference 3
)), ncol=4, byrow=TRUE)

convert_utility_to_preference(commmand_utility)
```

```
##      [,1] [,2] [,3]
## [1,]    1    2    3
## [2,]    2    3    1
## [3,]    3    1   NA
## [4,]    4    4   NA
```

```r
command_preference
```

```
##      [,1] [,2] [,3]
## [1,]    1    2    3
## [2,]    2    3    1
## [3,]    3    1   NA
## [4,]    4    4   NA
```

```r
testit::assert(
  "Command's conversion from utility to preference should be correct.",
  all.equal(
    target  = convert_utility_to_preference(commmand_utility),
    current = command_preference
  )
)

testit::assert(
  "Officer's conversion from utility to preference should be correct.",
  all.equal(
    target  = convert_utility_to_preference(officer_utility),
    current = officer_preference
  )
)
```



```r
m <- matchingMarkets::hri(
  c.prefs = command_preference, #College/command preferences (each officer is a row)
  s.prefs = officer_preference, #Student/officer preferences (each command is a row)
  nSlots  =c(2,1,1)
)
print(m)
```

```
## $s.prefs.smi
##      [,1] [,2] [,3] [,4]
## [1,]    1    3    4    1
## [2,]    2    1    1    2
## [3,]    3    2    2   NA
## [4,]    4   NA    3   NA
## 
## $c.prefs.smi
##      [,1] [,2] [,3] [,4]
## [1,]    1    1    2    3
## [2,]    2    2    3    1
## [3,]    3    3    1   NA
## [4,]    4    4   NA   NA
## 
## $s.prefs.hri
##      [,1] [,2] [,3] [,4]
## [1,]    1    2    3    1
## [2,]    2    1    1   NA
## [3,]    3   NA    2   NA
## 
## $c.prefs.hri
##      [,1] [,2] [,3]
## [1,]    1    2    3
## [2,]    2    3    1
## [3,]    3    1   NA
## [4,]    4   NA   NA
## 
## $matchings
##   matching college slots student sOptimal cOptimal
## 1        1       1     1       1        1        1
## 2        1       1     2       4        1        1
## 3        1       2     3       2        1        1
## 4        1       3     4       3        1        1
```

```r
#
```

The R session information (including the OS info, R version and all
packages used):


```r
sessionInfo()
```

```
## R version 3.3.2 Patched (2016-11-07 r71639)
## Platform: x86_64-w64-mingw32/x64 (64-bit)
## Running under: Windows 7 x64 (build 7601) Service Pack 1
## 
## locale:
## [1] LC_COLLATE=English_United States.1252 
## [2] LC_CTYPE=English_United States.1252   
## [3] LC_MONETARY=English_United States.1252
## [4] LC_NUMERIC=C                          
## [5] LC_TIME=English_United States.1252    
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
## [1] ggplot2_2.2.0 magrittr_1.5 
## 
## loaded via a namespace (and not attached):
##  [1] Rcpp_0.12.8           knitr_1.15.1          partitions_1.9-18    
##  [4] munsell_0.4.3         testit_0.6            colorspace_1.3-2     
##  [7] R6_2.2.0              matchingR_1.2.1       stringr_1.1.0        
## [10] plyr_1.8.4            dplyr_0.5.0.9000      tools_3.3.2          
## [13] grid_3.3.2            gtable_0.2.0          DBI_0.5-1            
## [16] matchingMarkets_0.3-2 lazyeval_0.2.0        assertthat_0.1       
## [19] tibble_1.2            gmp_0.5-12            rJava_0.9-8          
## [22] readr_1.0.0           tidyr_0.6.0           evaluate_0.10        
## [25] stringi_1.1.2         scales_0.4.1          polynom_1.3-9
```

```r
Sys.time()
```

```
## [1] "2016-12-22 01:25:07 CST"
```

