



This report was automatically generated with the R package **knitr**
(version 1.15.1).


```r
# knitr::stitch_rmd(script="./manipulation/selection-munge.R", output="./stitched-output/manipulation/selection-munge.md")
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.
```

```r
# Call `base::source()` on any repo file that defines functions needed below.  Ideally, no real operations are performed.
```

```r
# Attach these package(s) so their functions don't need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
library(magrittr, quietly=TRUE)

# Verify these packages are available on the machine, but their functions need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
requireNamespace("readr"         , quietly=TRUE)
requireNamespace("tidyr"         , quietly=TRUE)
requireNamespace("dplyr"         , quietly=TRUE) #Avoid attaching dplyr, b/c its function names conflict with a lot of packages (esp base, stats, and plyr).
requireNamespace("testit"        , quietly=TRUE) #For asserting conditions meet expected patterns.
```

```r
# Constant values that won't change.
set.seed(43) #So the random sampling won't change.
path_in_command_roster              <- "data-phi-free/raw/command-roster.csv"
path_in_command_wide                <- "data-phi-free/raw/command-wide.csv"
path_out_command_wide               <- "data-phi-free/derived/command.csv"

path_in_officer_roster              <- "data-phi-free/raw/officer-roster.csv"
path_in_officer_wide                <- "data-phi-free/raw/officer-wide.csv"
path_out_officer_wide               <- "data-phi-free/derived/officer.csv"
```

```r
# Read the CSVs
ds_command_roster      <- readr::read_csv(path_in_command_roster)
```

```
## Parsed with column specification:
## cols(
##   command_id = col_integer(),
##   command_name = col_character(),
##   billet_count_max = col_integer()
## )
```

```r
ds_command_wide        <- readr::read_csv(path_in_command_wide)
```

```
## Parsed with column specification:
## cols(
##   .default = col_integer()
## )
```

```
## See spec(...) for full column specifications.
```

```r
ds_officer_roster      <- readr::read_csv(path_in_officer_roster)
```

```
## Parsed with column specification:
## cols(
##   officer_id = col_integer(),
##   officer_tag = col_character(),
##   officer_name_last = col_character()
## )
```

```r
ds_officer_wide        <- readr::read_csv(path_in_officer_wide)
```

```
## Parsed with column specification:
## cols(
##   .default = col_integer()
## )
## See spec(...) for full column specifications.
```

```r
rm(path_in_command_roster, path_in_command_wide)
rm(path_in_officer_roster, path_in_officer_wide)

# Print the first few rows of each table, especially if you're stitching with knitr (see first line of this file).
#   If you print, make sure that the datasets don't contain any PHI.
ds_command_roster
```

```
## # A tibble: 20 × 3
##    command_id command_name billet_count_max
##         <int>        <chr>            <int>
## 1         201         Guam                1
## 2         202       NH Oki                2
## 3         203      Oki MEU                2
## 4         204      3rd MLG                4
## 5         205      NH Yoko                2
## 6         206         Rota                1
## 7         207         Napl                2
## 8         208          Sig                1
## 9         209         NMCP                6
## 10        210          Jax                4
## 11        211        Gitmo                1
## 12        212         NHCL                5
## 13        213      2nd MLG                2
## 14        214      2nd MEU                2
## 15        215        CBIRF                1
## 16        216        NMCSD                4
## 17        217       NH 29P                3
## 18        218      NH Pend                1
## 19        219      1st MLG                6
## 20        220      1st MEU                4
```

```r
ds_command_wide
```

```
## # A tibble: 51 × 21
##     Code  Guam `NH Oki` `Oki MEU` `3rd MLG` `NH Yoko`  Rota  Napl   Sig
##    <int> <int>    <int>     <int>     <int>     <int> <int> <int> <int>
## 1    401     6        5         2         3         4     7     9     9
## 2    402     1        6         3         4         5     3     7     1
## 3    403     7        7         4         5         6     8    10    11
## 4    404     8        8         5         6         7     9    11    12
## 5    405     9        9         6         7         8    10    12    13
## 6    406    10       10         7         8         9    11    13     4
## 7    407    11       11         8         9        10    12    14    14
## 8    408    12       12         9        10        11    13    15    15
## 9    409    13       13        10        11        12    14    16    16
## 10   410    14       14        11        12        13    15    17     5
## # ... with 41 more rows, and 12 more variables: NMCP <int>, Jax <int>,
## #   Gitmo <int>, NHCL <int>, `2nd MLG` <int>, `2nd MEU` <int>,
## #   CBIRF <int>, NMCSD <int>, `NH 29P` <int>, `NH Pend` <int>, `1st
## #   MLG` <int>, `1st MEU` <int>
```

```r
ds_officer_roster
```

```
## # A tibble: 62 × 3
##    officer_id officer_tag officer_name_last
##         <int>       <chr>             <chr>
## 1         401        xvxe           Abraham
## 2         402        kobl            Bailey
## 3         403        x0qi              Carr
## 4         404        pd7n          Davidson
## 5         405        87cl           Ellison
## 6         406        m8w6           Forsyth
## 7         407        wnaf            Glover
## 8         408        as5q            Harris
## 9         409        pb8x              Ince
## 10        410        5t8r             Jones
## # ... with 52 more rows
```

```r
ds_officer_wide
```

```
## # A tibble: 51 × 21
##     Code  Guam `NH Oki` `Oki MEU` `3rd MLG` `NH Yoko`  Rota  Napl   Sig
##    <int> <int>    <int>     <int>     <int>     <int> <int> <int> <int>
## 1    401     1        2         3         4         5     6     7     8
## 2    402     4        2         3         4         5     2     1     3
## 3    403     3        4         3         4         5     6     7     8
## 4    404     6        2         3         4         5     4     7     8
## 5    405     1        2         3         4         5     6     7     8
## 6    406     1        2         3         4         5     6     1     8
## 7    407     1        5         6         7         4     8     9     8
## 8    408     1        2         3         4         5     6     7     8
## 9    409     1        2         3         4         5     6     7     8
## 10   410     1        2         3         4         5     6     7     8
## # ... with 41 more rows, and 12 more variables: NMCP <int>, Jax <int>,
## #   Gitmo <int>, NHCL <int>, `2nd MLG` <int>, `2nd MEU` <int>,
## #   CBIRF <int>, NMCSD <int>, `NH 29P` <int>, `NH Pend` <int>, `1st
## #   MLG` <int>, `1st MEU` <int>
```

```r
# OuhscMunge::column_rename_headstart(ds_county) #Spit out columns to help write call ato `dplyr::rename()`.
# colnames(ds_command_wide)  <- make.names(colnames(ds_command_wide))

ds_command_long <- ds_command_wide %>%
  dplyr::rename_(
    "officer_id"     = "Code"
  ) %>%
  tidyr::gather(key=command_name, value=preference, -officer_id) %>%
  dplyr::group_by(command_name) %>%
  dplyr::mutate(
    # missing_ranks  = setdiff(seq_len(n()), preference)
    preference    = sample(dplyr::n_distinct(officer_id))
  ) %>%
  dplyr::ungroup() %>%
  # dplyr::mutate(
  #   preference    = dplyr::coalesce(preference, dplyr::n_distinct(officer_id))
  # ) %>%
  dplyr::left_join(ds_command_roster, by="command_name") %>%
  dplyr::arrange(command_id, officer_id)

ds_officer_long <- ds_officer_wide %>%
  dplyr::rename_(
    "officer_id"     = "Code"
  ) %>%
  tidyr::gather(key=command_name, value=preference, -officer_id) %>%
  dplyr::group_by(officer_id) %>%
  dplyr::mutate(
    preference    = sample(dplyr::n_distinct(command_name))
  ) %>%
  dplyr::ungroup() %>%
  # dplyr::mutate(
  #   preference    = dplyr::coalesce(preference, dplyr::n_distinct(command_name))
  # ) %>%
  dplyr::left_join(
    ds_command_roster %>%
      dplyr::select(command_id, command_name),
    by="command_name"
  ) %>%
  dplyr::left_join(ds_officer_roster, by="officer_id") %>%
  dplyr::arrange(command_id, officer_id)
```

```r
# Sniff out problems
testit::assert("The officer_id must be nonmissing.", all(!is.na(ds_command_long$officer_id)))
testit::assert("The command_name must be nonmissing.", all(!is.na(ds_command_long$command_name)))
testit::assert("The preference must be nonmissing.", all(!is.na(ds_command_long$preference)))
testit::assert("The command_id must be nonmissing.", all(!is.na(ds_command_long$command_id)))
testit::assert("The billet_count_max must be nonmissing.", all(!is.na(ds_command_long$billet_count_max)))
testit::assert("The officer_id-command_id combination should be unique.", all(!duplicated(paste(ds_command_long$officer_id, ds_command_long$command_id))))
testit::assert("The command_id-preference combination should be unique.", all(!duplicated(paste(ds_command_long$command_id, ds_command_long$preference))))
```

```r
# Sniff out problems
testit::assert("The officer_id must be nonmissing.", all(!is.na(ds_officer_long$officer_id)))
testit::assert("The command_name must be nonmissing.", all(!is.na(ds_officer_long$command_name)))
testit::assert("The preference must be nonmissing.", all(!is.na(ds_officer_long$preference)))
testit::assert("The command_id must be nonmissing.", all(!is.na(ds_officer_long$command_id)))
testit::assert("The officer_id-command_id combination should be unique.", all(!duplicated(paste(ds_officer_long$officer_id, ds_officer_long$command_id))))
testit::assert("The officer_id-preference combination should be unique.", all(!duplicated(paste(ds_officer_long$officer_id, ds_officer_long$preference))))
```

```r
# dput(colnames(ds_command_long)) # Print colnames for line below.
ds_command_long <- ds_command_long %>%
  dplyr::select_(.dots=c("command_id", "officer_id", "preference"))#, "command_name", "billet_count_max"))
ds_officer_long <- ds_officer_long %>%
  dplyr::select_(.dots=c("command_id", "officer_id", "preference"))#, "officer_tag" , "officer_name_last"))
```

```r
readr::write_csv(ds_command_long, path_out_command_wide)
readr::write_csv(ds_officer_long, path_out_officer_wide)
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
## [1] ggplot2_2.2.0 knitr_1.15.1  magrittr_1.5 
## 
## loaded via a namespace (and not attached):
##  [1] Rcpp_0.12.8           partitions_1.9-18     munsell_0.4.3        
##  [4] testit_0.6            colorspace_1.3-1      R6_2.2.0             
##  [7] highr_0.6             plyr_1.8.4            stringr_1.1.0        
## [10] dplyr_0.5.0           tools_3.3.2           grid_3.3.2           
## [13] gtable_0.2.0          DBI_0.5-1             matchingMarkets_0.3-2
## [16] htmltools_0.3.5       yaml_2.1.14           lazyeval_0.2.0       
## [19] assertthat_0.1        rprojroot_1.1         digest_0.6.10        
## [22] tibble_1.2            gmp_0.5-12            rJava_0.9-8          
## [25] readr_1.0.0           tidyr_0.6.0           evaluate_0.10        
## [28] rmarkdown_1.2         labeling_0.3          stringi_1.1.2        
## [31] scales_0.4.1          backports_1.0.4       polynom_1.3-8        
## [34] markdown_0.7.7
```

```r
Sys.time()
```

```
## [1] "2016-11-26 23:14:26 CST"
```

