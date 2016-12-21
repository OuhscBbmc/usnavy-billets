



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
set.seed(43) #So the random sampling won't change.
command_count  <- 3L
officer_count  <- 4L

ds_base <-
  tidyr::crossing(
    command_index   = seq_len(command_count),
    officer_index   = seq_len(officer_count)
  ) %>%
  dplyr::mutate(
    command_id      = sprintf("c_%03d", command_index + 200L),
    officer_id      = sprintf("o_%03d", officer_index + 400L)
  )

ds_command_long <- ds_base %>%
  dplyr::group_by(command_index) %>%
  dplyr::mutate(
    preference       = sample(n()),
    billet_count_max = 1L
  ) %>%
  dplyr::ungroup()

ds_officer_long <- ds_base %>%
  dplyr::group_by(officer_index) %>%
  dplyr::mutate(
    preference      = sample(n())
  ) %>%
  dplyr::ungroup()
```

```r
# Read the CSVs

ds_command_long
```

```
## # A tibble: 12 × 6
##    command_index officer_index command_id officer_id preference
##            <int>         <int>      <chr>      <chr>      <int>
## 1              1             1      c_201      o_401          2
## 2              1             2      c_201      o_402          3
## 3              1             3      c_201      o_403          1
## 4              1             4      c_201      o_404          4
## 5              2             1      c_202      o_401          2
## 6              2             2      c_202      o_402          4
## 7              2             3      c_202      o_403          3
## 8              2             4      c_202      o_404          1
## 9              3             1      c_203      o_401          1
## 10             3             2      c_203      o_402          3
## 11             3             3      c_203      o_403          4
## 12             3             4      c_203      o_404          2
## # ... with 1 more variables: billet_count_max <int>
```

```r
ds_officer_long
```

```
## # A tibble: 12 × 5
##    command_index officer_index command_id officer_id preference
##            <int>         <int>      <chr>      <chr>      <int>
## 1              1             1      c_201      o_401          2
## 2              1             2      c_201      o_402          3
## 3              1             3      c_201      o_403          1
## 4              1             4      c_201      o_404          3
## 5              2             1      c_202      o_401          1
## 6              2             2      c_202      o_402          1
## 7              2             3      c_202      o_403          3
## 8              2             4      c_202      o_404          1
## 9              3             1      c_203      o_401          3
## 10             3             2      c_203      o_402          2
## 11             3             3      c_203      o_403          2
## 12             3             4      c_203      o_404          2
```

```r
# OuhscMunge::column_rename_headstart(ds_county) #Spit out columns to help write call ato `dplyr::rename()`.
```

```r
# Sniff out problems
testit::assert("The officer_id must be nonmissing.", all(!is.na(ds_command_long$officer_id)))
testit::assert("The preference must be nonmissing.", all(!is.na(ds_command_long$preference)))
testit::assert("The command_id must be nonmissing.", all(!is.na(ds_command_long$command_id)))
testit::assert("The billet_count_max must be nonmissing.", all(!is.na(ds_command_long$billet_count_max)))
testit::assert("The officer_id-command_id combination should be unique.", all(!duplicated(paste(ds_command_long$officer_id, ds_command_long$command_id))))
testit::assert("The command_id-preference combination should be unique.", all(!duplicated(paste(ds_command_long$command_id, ds_command_long$preference))))
```

```r
# Sniff out problems
testit::assert("The officer_id must be nonmissing.", all(!is.na(ds_officer_long$officer_id)))
testit::assert("The preference must be nonmissing.", all(!is.na(ds_officer_long$preference)))
testit::assert("The command_id must be nonmissing.", all(!is.na(ds_officer_long$command_id)))
testit::assert("The officer_id-command_id combination should be unique.", all(!duplicated(paste(ds_officer_long$officer_id, ds_officer_long$command_id))))
testit::assert("The officer_id-preference combination should be unique.", all(!duplicated(paste(ds_officer_long$officer_id, ds_officer_long$preference))))
# as.data.frame(ds_officer_long[duplicated(paste(ds_officer_long$officer_id, ds_officer_long$preference)), ])
```

```r
command_transition <- ds_command_long %>%
  dplyr::select(command_index, officer_index, preference) %>%
  tidyr::spread(key=command_index, value=preference) %>%
  dplyr::select(-officer_index) %>%
  as.matrix() %>%
  unname()

officer_transition <- ds_officer_long %>%
  dplyr::select(command_index, officer_index, preference) %>%
  tidyr::spread(key=officer_index, value=preference) %>%
  dplyr::select(-command_index) %>%
  as.matrix() %>%
  unname()
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
## [1,]   -2   -3    0
## [2,]    0    0   -3
## [3,]   -1   -2   -1
## [4,]   -3   -1   -2
```

```r
matchingR::galeShapley.collegeAdmissions(
  collegePref = command_transition,
  studentPref = officer_transition
)
```

```
## $unmatched.students
## [1] 3
## 
## $unmatched.colleges
## numeric(0)
## 
## $matched.colleges
##      [,1]
## [1,]    2
## [2,]    4
## [3,]    1
## 
## $matched.students
##      [,1]
## [1,]    3
## [2,]    1
## [3,]   NA
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
# m
#
# m$matchings %>%
#   dplyr::select(-matching, -sOptimal, -cOptimal) %>%
#   # dplyr::select(-matching, -slots, -sOptimal, -cOptimal) %>%
#   # dplyr::mutate(
#   #   student          = ifelse(student==0, "*not matched*", student),
#   #   college          = ifelse(college==0, "*not matched*", college)
#   # ) %>%
#   dplyr::arrange(college, student) %>%
#   dplyr::rename_(
#     "command<br/>index"    = "college",
#     "officer<br/>index"    = "student"
#   ) %>%
#   knitr::kable(
#     format       = "markdown"
#     , align = c("r", "l")
#   )

# # ---- display ------------------------------------------------------------------
# ds_edge <- m$matchings %>%
#   tibble::as_tibble() %>%
#   dplyr::select(-matching, -slots, -sOptimal, -cOptimal) %>%
#   dplyr::rename(
#     command_index   = college,
#     officer_index   = student
#   ) %>%
#   dplyr::right_join(ds_command_roster, by="command_index") %>%
#   dplyr::right_join(ds_officer_roster, by="officer_index" ) %>%
#   dplyr::left_join(ds_command_long, by=c("command_id", "officer_id")) %>%
#   dplyr::left_join(ds_officer_long, by=c("command_id", "officer_id")) %>%
#   dplyr::arrange(desc(billet_count_max), command_id) %>%
#   dplyr::mutate(
#     command_id   = sprintf("c_%03d", command_id),
#     officer_id   = sprintf("o_%03d", officer_id)
#   )
#
# ds_edge %>%
#   knitr::kable(
#     col.names    = gsub("_", "<br/>", colnames(ds_edge)),
#     format       = "markdown"
#   )
#
# # ---- graph-desirability ------------------------------------------------------------------
# set.seed(23) #For the sake of keeping the jittering constant between runs.
# ggplot(ds_command_long, aes(x=officer_id, y=preference_from_command))  +
#   stat_summary(fun.y="mean", geom="point", shape=23, size=5, fill="white", alpha=.3, na.rm=T) + #See Chang (2013), Recipe 6.8.
#   geom_point(shape=21, color="royalblue", fill="skyblue", alpha=.2, position=position_jitter(width=.4, height=0)) +
#   theme_light() +
#   labs(title="How the Commands Ranked the Officers", x="Officer ID", y="Preference from Command\n(lower is a more desirable officer)")
#
# last_plot() %+%
#   ds_officer_long %+%
#   aes(x=command_id, y=preference_from_officer) +
#   labs(title="How the Officers Ranked the Commands", x="command ID", y="Preference from Officer\n(lower is a more desirable command)")
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
## [1] "2016-12-20 23:38:20 CST"
```

