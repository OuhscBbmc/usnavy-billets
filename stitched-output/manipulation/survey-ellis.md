



This report was automatically generated with the R package **knitr**
(version 1.16).


```r
# knitr::stitch_rmd(script="./manipulation/survey-ellis.R", output="./stitched-output/manipulation/survey-ellis.md") # dir.create(output="./stitched-output/manipulation/", recursive=T)
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.
```

```r
# Call `base::source()` on any repo file that defines functions needed below.  Ideally, no real operations are performed.
```

```r
# Attach these package(s) so their functions don't need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
library(magrittr            , quietly=TRUE)

# Verify these packages are available on the machine, but their functions need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
requireNamespace("readr"        )
requireNamespace("tidyr"        )
requireNamespace("dplyr"        ) # void attaching dplyr, b/c its function names conflict with a lot of packages (esp base, stats, and plyr).
requireNamespace("testit"       ) # or asserting conditions meet expected patterns.
requireNamespace("checkmate"    ) # or asserting conditions meet expected patterns. # devtools::install_github("mllg/checkmate")
```

```r
# Constant values that won't change.
path_raw                        <- "data-unshared/raw/Raw DM Survey 1 Results.csv"
# path_raw                         <- "data-unshared/raw/ascii.csv"
path_derived                    <- "data-unshared/derived/survey-dm-1.csv"

col_types <- readr::cols_only(
    `Response ID` = readr::col_integer(),
  # `Date submitted` = readr::col_datetime(format = ""),
  # `Last page` = readr::col_integer(),
  # `Start language` = readr::col_character(),
  # `Date started` = readr::col_datetime(format = ""),
  # `Date last action` = readr::col_datetime(format = ""),
  # `What is your primary??specialty-` = readr::col_character(),
  # `What is your primary??specialty- [Other]` = readr::col_character(),
  # `What is your rank-` = readr::col_character(),
  # `What year did you??execute orders for your current billet-?? (Consider retour orders the same as a PCS set of orders.)` = readr::col_character(),
  # `What year did you??execute orders for your current billet-?? (Consider retour orders the same as a PCS set of orders.) [Other]` = readr::col_character(),
  # `How would you describe your current billet-` = readr::col_character(),
  # `How would you describe your current billet- [Other]` = readr::col_character(),
  # `For your last set of orders, how many months prior to your move were your orders released-?? That is, how many months did you have to prepare for your PCS-` = readr::col_character(),
  # `For your last set of orders, how many months prior to your move were your orders released-?? That is, how many months did you have to prepare for your PCS- [Other]` = readr::col_character(),
  `On a scale of 1 to 5, with 1 being not transparent and 5 being very transparent, how would you rate the transparency of your detailing experience for your last set of orders-` = readr::col_integer(),
  `On a scale of 1 to 5, with 1 being unsatisfied and 5 being very satisfied, how would you rate your overall??detailing experience for your last set of orders-` = readr::col_integer(),
  `On a scale of 1 to 5, with 1 representing a significant problem and 5 being not a problem at all, how would you rank the problem of favoritism in the billet assignment process-` = readr::col_integer(),
  `Describe your current assignment:` = readr::col_character()
  # `Describe your current assignment: [Other]` = readr::col_character()
  # `Please rank your desired billet locations with the top level being the most desireable, and the bottom being the least desireable. [Ranking 1]` = readr::col_character(),
  # `Please rank your desired billet locations with the top level being the most desireable, and the bottom being the least desireable. [Ranking 2]` = readr::col_character(),
  # `Please rank your desired billet locations with the top level being the most desireable, and the bottom being the least desireable. [Ranking 3]` = readr::col_character(),
  # `Please rank your desired billet locations with the top level being the most desireable, and the bottom being the least desireable. [Ranking 4]` = readr::col_character(),
  # `Please rank your desired billet locations with the top level being the most desireable, and the bottom being the least desireable. [Ranking 5]` = readr::col_character(),
  # `Please rank your desired billet locations with the top level being the most desireable, and the bottom being the least desireable. [Ranking 6]` = readr::col_character(),
  # `Please rank your desired billet locations with the top level being the most desireable, and the bottom being the least desireable. [Ranking 7]` = readr::col_character(),
  # `Please rank your desired billet locations with the top level being the most desireable, and the bottom being the least desireable. [Ranking 8]` = readr::col_character(),
  # `Please rank your desired billet locations with the top level being the most desireable, and the bottom being the least desireable. [Ranking 9]` = readr::col_character(),
  # `Which career path do you want to pursue in the next 5-10?? years-` = readr::col_character(),
  # `Which career path do you want to pursue in the next 5-10?? years- [Other]` = readr::col_character(),
  # `Neither the Army nor the Air Force have physicians in the detailer role.?? Instead, they have nurses or medical administrators work with specialty leaders to determine assigments.?? This is different from the current Navy Medical Corps billet assignment process where the detailer??is a physician*.?? Would you??approve if the detailer position was filled by a non-physician-` = readr::col_character(),
  # `Neither the Army nor the Air Force have physicians in the detailer role.?? Instead, they have nurses or medical administrators work with specialty leaders to determine assigments.?? This is different from the current Navy Medical Corps billet assignment process where the detailer??is a physician*.?? Would you??approve if the detailer position was filled by a non-physician- [Other]` = readr::col_character(),
  # `How long should an individual be allowed to remain at one command-` = readr::col_character(),
  # `How long should an individual be allowed to remain at one command- [Other]` = readr::col_character(),
  # `Do you think that there is a problem in the Medical Corps with members not moving-?? That is, are there too many physicians who get to stay in one place too long-` = readr::col_character(),
  # `Do you think that there is a problem in the Medical Corps with members not moving-?? That is, are there too many physicians who get to stay in one place too long- [Other]` = readr::col_character(),
  # `Civilian medical residency positions are assigned using the National Residency Match Program where members submit a preference list, residency directors submit a preference list, and a computer algorithm optimizes a match.?? This is different from the current Navy Medical Corps billet assignment process where the detailer and specialty leader take input from medical officers and then make a decision.?? Of these two options, which would you prefer for your military billet assignment-` = readr::col_character(),
  # `Civilian medical residency positions are assigned using the National Residency Match Program where members submit a preference list, residency directors submit a preference list, and a computer algorithm optimizes a match.?? This is different from the current Navy Medical Corps billet assignment process where the detailer and specialty leader take input from medical officers and then make a decision.?? Of these two options, which would you prefer for your military billet assignment- [Other]` = readr::col_character(),
  # `The later the match day, the more information one has before creating their rank list.?? The earlier the match day, the sooner one can have certainty and prepare.?? Assuming your were scheduled to??execute new orders in July of 2017, what month would you want the match to occur in-` = readr::col_character(),
  # `The later the match day, the more information one has before creating their rank list.?? The earlier the match day, the sooner one can have certainty and prepare.?? Assuming your were scheduled to??execute new orders in July of 2017, what month would you want the match to occur in- [Other]` = readr::col_character(),
  # `Do you think members who are coming from operational or OCONUS assignments should be given preference in billet assignment-` = readr::col_character(),
  # `Do you think members with more seniority (as defined by time in service or rank)??should be given preference in billet assignment-` = readr::col_character(),
  # `Any last thoughts or input regarding the billet assignment process-` = readr::col_character()
)
```

```r
# Read the CSVs
ds <- readr::read_csv(path_raw, col_types=col_types)

rm(path_raw, col_types)

dim(ds)
```

```
## [1] 1298    5
```

```r
# OuhscMunge::column_rename_headstart(ds) #Spit out columns to help write call ato `dplyr::rename()`.
ds <- ds %>%
  dplyr::select_( #`select()` implicitly drops the other columns not mentioned.
    "response_id"                  = "`Response ID`"
    , "transparent"                = "`On a scale of 1 to 5, with 1 being not transparent and 5 being very transparent, how would you rate the transparency of your detailing experience for your last set of orders-`"
    , "satisfaction"               = "`On a scale of 1 to 5, with 1 being unsatisfied and 5 being very satisfied, how would you rate your overall??detailing experience for your last set of orders-`"
    , "favoritism"                 = "`On a scale of 1 to 5, with 1 representing a significant problem and 5 being not a problem at all, how would you rank the problem of favoritism in the billet assignment process-`"
    , "assignment_current_rank"    = "`Describe your current assignment:`"
    # , "assignment_current_rank2" = "`Describe your current assignment: [Other]`"
  )  %>%
  dplyr::mutate(
    response_index        = sample.int(n(), replace=F),
    missing_item_count    = is.na(transparent) + is.na(satisfaction) + is.na(favoritism) + is.na(assignment_current_rank)
  ) %>%
  dplyr::mutate(
    assignment_current_rank = dplyr::recode(
      assignment_current_rank,
      "1st choice"        = "1st",
      "2nd choice"        = "2nd",
      "3rd choice"        = "3rd",
      "4th choice"        = "4th",
      "> 4th choice"      = "5th+",
      "Other"             = "Other",
      .missing            = "Unknown"
    )
  ) %>%
  dplyr::arrange(response_index)

table(ds$missing_item_count)
```

```
## 
##   0   1   2   3   4 
## 770 138  12  20 358
```

```r
# Sniff out problems
checkmate::assert_integer(  ds$response_id              , lower=1L                  , any.missing=F, unique=T)
checkmate::assert_integer(  ds$response_index           , lower=1L, upper=nrow(ds)  , any.missing=F, unique=T)
checkmate::assert_integer(  ds$transparent              , lower=1L, upper=5L        , any.missing=T)
checkmate::assert_integer(  ds$satisfaction             , lower=1L, upper=5L        , any.missing=T)
checkmate::assert_integer(  ds$favoritism               , lower=1L, upper=5L        , any.missing=T)
checkmate::assert_character(ds$assignment_current_rank  , min.chars=3               , any.missing=F)
checkmate::assert_integer(  ds$missing_item_count       , lower=0L, upper=4L        , any.missing=F)
```

```r
# dput(colnames(ds)) # Print colnames for line below.
columns_to_write <- c(
  "response_index",
  "transparent", "satisfaction", "favoritism",
  "assignment_current_rank", "missing_item_count"
)
ds_slim <- ds %>%
  dplyr::select_(.dots=columns_to_write) %>%
  dplyr::mutate(
    # fte_approximated <- as.integer(fte_approximated)
  )
ds_slim
```

```
## # A tibble: 1,298 x 6
##    response_index transparent satisfaction favoritism
##             <int>       <int>        <int>      <int>
##  1              1           2            4          5
##  2              2           3            5         NA
##  3              3          NA           NA         NA
##  4              4           1            1          1
##  5              5          NA           NA         NA
##  6              6          NA           NA         NA
##  7              7           5            5          5
##  8              8           1            3          2
##  9              9          NA           NA         NA
## 10             10           5            5          5
## # ... with 1,288 more rows, and 2 more variables:
## #   assignment_current_rank <chr>, missing_item_count <int>
```

```r
rm(columns_to_write)
```

```r
# If there's no PHI, a rectangular CSV is usually adequate, and it's portable to other machines and software.
readr::write_csv(ds, path_derived)
```

The R session information (including the OS info, R version and all
packages used):


```r
sessionInfo()
```

```
## R version 3.4.1 (2017-06-30)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 16.04.2 LTS
## 
## Matrix products: default
## BLAS: /usr/lib/atlas-base/atlas/libblas.so.3.0
## LAPACK: /usr/lib/atlas-base/atlas/liblapack.so.3.0
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
## [1] bindrcpp_0.2 magrittr_1.5
## 
## loaded via a namespace (and not attached):
##  [1] Rcpp_0.12.11          knitr_1.16            bindr_0.1            
##  [4] hms_0.3               bit_1.1-12            testit_0.7           
##  [7] lattice_0.20-35       R6_2.2.2              rlang_0.1.1.9000     
## [10] stringr_1.2.0         blob_1.1.0            dplyr_0.7.1          
## [13] tools_3.4.1           grid_3.4.1            checkmate_1.8.3      
## [16] DBI_0.7               digest_0.6.12         bit64_0.9-7          
## [19] assertthat_0.2.0      tibble_1.3.3          purrr_0.2.2.2        
## [22] readr_1.1.1           tidyr_0.6.3           evaluate_0.10.1      
## [25] memoise_1.1.0         glue_1.1.1            OuhscMunge_0.1.8.9002
## [28] RSQLite_2.0           stringi_1.1.5         compiler_3.4.1       
## [31] backports_1.1.0       markdown_0.8          pkgconfig_2.0.1      
## [34] zoo_1.8-0
```

```r
Sys.time()
```

```
## [1] "2017-07-03 12:34:48 CDT"
```

