



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

col_types_command_roster <- readr::cols_only(
  command_id          = readr::col_integer(),
  command_name        = readr::col_character(),
  billet_count_max    = readr::col_integer()
)
col_types_officer_roster <- readr::cols_only(
  officer_id          = readr::col_integer(),
  officer_tag         = readr::col_character(),
  officer_name_last   = readr::col_character()
)

col_types_wide <- readr::cols(
  .default = readr::col_integer()
)
```

```r
# Read the CSVs
ds_command_roster      <- readr::read_csv(path_in_command_roster, col_types=col_types_command_roster)
ds_command_wide        <- readr::read_csv(path_in_command_wide,   col_types=col_types_wide)

ds_officer_roster      <- readr::read_csv(path_in_officer_roster, col_types=col_types_officer_roster)
ds_officer_wide        <- readr::read_csv(path_in_officer_wide,   col_types=col_types_wide)
```

```
## Warning: 1 parsing failure.
## row     col   expected actual
##  41 2nd MEU an integer      .
```

```r
rm(path_in_command_roster, col_types_command_roster)
rm( path_in_command_wide)
rm(path_in_officer_roster, col_types_officer_roster)
rm(path_in_officer_wide, col_types_wide)

# Print the first few rows of each table, especially if you're stitching with knitr (see first line of this file).
#   If you print, make sure that the datasets don't contain any PHI.
ds_command_roster
```

```
## # A tibble: 20 × 3
##    command_id command_name billet_count_max
##         <int>        <chr>            <int>
## 1         201         Guam                0
## 2         202       NH Oki                1
## 3         203      Oki MEU                2
## 4         204      3rd MLG                3
## 5         205      NH Yoko                2
## 6         206         Rota                1
## 7         207         Napl                2
## 8         208          Sig                1
## 9         209         NMCP                5
## 10        210          Jax                4
## 11        211        Gitmo                1
## 12        212         NHCL                5
## 13        213      2nd MLG                2
## 14        214      2nd MEU                2
## 15        215        CBIRF                1
## 16        216        NMCSD                4
## 17        217       NH 29P                3
## 18        218      NH Pend                1
## 19        219      1st MLG                3
## 20        220      1st MEU                3
```

```r
ds_command_wide
```

```
## # A tibble: 46 × 21
##     Code  Guam `NH Oki` `Oki MEU` `3rd MLG` `NH Yoko`  Rota  Napl   Sig
##    <int> <int>    <int>     <int>     <int>     <int> <int> <int> <int>
## 1    401     1       10        NA        NA        NA    NA    NA    NA
## 2    402    NA       18        NA        NA        NA     2     6     1
## 3    403    NA        5        NA        NA        NA    NA    NA    NA
## 4    404    NA        7        NA        NA        NA    NA    NA    NA
## 5    405    NA        8        NA        NA        NA    NA    NA    NA
## 6    406    NA       19        NA        NA        NA    NA    NA    NA
## 7    407    NA       16        NA        NA        NA    NA    NA    NA
## 8    408    NA       NA        NA        NA        NA    NA    NA    NA
## 9    409    NA       12        NA        NA        NA    NA    NA    NA
## 10   410    NA       NA        NA        NA        NA    NA    NA    NA
## # ... with 36 more rows, and 12 more variables: NMCP <int>, Jax <int>,
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
## # A tibble: 46 × 21
##     Code  Guam `NH Oki` `Oki MEU` `3rd MLG` `NH Yoko`  Rota  Napl   Sig
##    <int> <int>    <int>     <int>     <int>     <int> <int> <int> <int>
## 1    401    NA       NA        NA        NA        NA    NA    NA    NA
## 2    402     4       NA        NA        NA        NA     2     1     3
## 3    403    NA        5        NA        NA        NA    NA    NA    NA
## 4    404     9       NA        NA        NA         5     6     7     8
## 5    405    NA       NA        NA        NA        NA    NA    NA    NA
## 6    406    NA       NA        NA        NA        NA     2     1     3
## 7    407    NA        8        NA        NA         4     5     6     7
## 8    408    NA       NA        NA        NA        NA    NA    NA    NA
## 9    409    NA       NA        NA        NA        NA     3     4     5
## 10   410    NA       NA        NA        NA        NA    NA    NA    NA
## # ... with 36 more rows, and 12 more variables: NMCP <int>, Jax <int>,
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
  tidyr::gather(key=command_name, value=rank, -officer_id) %>%
  dplyr::left_join(ds_command_roster, by="command_name") %>%
  dplyr::arrange(command_id, officer_id)

ds_officer_long <- ds_officer_wide %>%
  dplyr::rename_(
    "officer_id"     = "Code"
  ) %>%
  tidyr::gather(key=command_name, value=rank, -officer_id) %>%
  dplyr::left_join(
    ds_command_roster %>%
      dplyr::select(command_id, command_name),
    by="command_name"
  ) %>%
  dplyr::left_join(ds_officer_roster, by="officer_id") %>%
  dplyr::arrange(command_id, officer_id)
```

```r
ds_command_missing_ranks <- ds_command_long %>%
  dplyr::group_by(command_id) %>%
  dplyr::summarize(
    nonmissing_rank_count  = sum(!is.na(rank))
  ) %>%
  dplyr::ungroup() %>%
  dplyr::filter(nonmissing_rank_count == 0L)

ds_officer_missing_ranks <- ds_officer_long %>%
  dplyr::group_by(officer_id) %>%
  dplyr::summarize(
    nonmissing_rank_count  = sum(!is.na(rank))
  ) %>%
  dplyr::ungroup() %>%
  # as.data.frame() %>%
  dplyr::filter(nonmissing_rank_count == 0L)

testit::assert("All commands should rank at least one officer.", nrow(ds_command_missing_ranks) == 0L)
testit::assert("All officers should rank at least one command.", nrow(ds_officer_missing_ranks) == 0L)
```

```r
# Sniff out problems
testit::assert("The officer_id must be nonmissing.", all(!is.na(ds_command_long$officer_id)))
testit::assert("The command_name must be nonmissing.", all(!is.na(ds_command_long$command_name)))
# testit::assert("The rank must be nonmissing.", all(!is.na(ds_command_long$rank)))
testit::assert("The command_id must be nonmissing.", all(!is.na(ds_command_long$command_id)))
testit::assert("The billet_count_max must be nonmissing.", all(!is.na(ds_command_long$billet_count_max)))
testit::assert("The officer_id-command_id combination should be unique.", all(!duplicated(paste(ds_command_long$officer_id, ds_command_long$command_id))))
# testit::assert("The command_id-rank combination should be unique.", all(!duplicated(paste(ds_command_long$command_id, ds_command_long$rank))))
```

```r
# Sniff out problems
testit::assert("The officer_id must be nonmissing.", all(!is.na(ds_officer_long$officer_id)))
testit::assert("The command_name must be nonmissing.", all(!is.na(ds_officer_long$command_name)))
# testit::assert("The rank must be nonmissing.", all(!is.na(ds_officer_long$rank)))
testit::assert("The command_id must be nonmissing.", all(!is.na(ds_officer_long$command_id)))
testit::assert("The officer_id-command_id combination should be unique.", all(!duplicated(paste(ds_officer_long$officer_id, ds_officer_long$command_id))))
# testit::assert("The officer_id-rank combination should be unique.", all(!duplicated(paste(ds_officer_long$officer_id, ds_officer_long$rank))))
as.data.frame(ds_officer_long[duplicated(paste(ds_officer_long$officer_id, ds_officer_long$rank)), ])
```

```
##     officer_id command_name rank command_id officer_tag officer_name_last
## 1          401       NH Oki   NA        202        xvxe           Abraham
## 2          405       NH Oki   NA        202        87cl           Ellison
## 3          406       NH Oki   NA        202        m8w6           Forsyth
## 4          408       NH Oki   NA        202        as5q            Harris
## 5          409       NH Oki   NA        202        pb8x              Ince
## 6          410       NH Oki   NA        202        5t8r             Jones
## 7          413       NH Oki   NA        202        5sjg            Murray
## 8          414       NH Oki   NA        202        k1lv              Nash
## 9          415       NH Oki   NA        202        cn7q            Oliver
## 10         419       NH Oki   NA        202        pt9y        Sutherland
## 11         420       NH Oki   NA        202        paed            Taylor
## 12         421       NH Oki   NA        202        zaif         Underwood
## 13         423       NH Oki   NA        202        vqdq            Walker
## 14         424       NH Oki   NA        202        d6hs             Xiong
## 15         425       NH Oki   NA        202        tb5t             Young
## 16         426       NH Oki   NA        202        d2nz            Zimmer
## 17         427       NH Oki   NA        202        9je3            Aikman
## 18         429       NH Oki   NA        202        85i6            Coolie
## 19         430       NH Oki   NA        202        zkff            Dulles
## 20         431       NH Oki   NA        202        6ust             Estes
## 21         432       NH Oki   NA        202        785o              Flag
## 22         433       NH Oki   NA        202        6zmz             Grind
## 23         435       NH Oki   NA        202        cbku          Instance
## 24         436       NH Oki   NA        202        0cot              Jack
## 25         438       NH Oki   NA        202        tun2          Laurence
## 26         439       NH Oki   NA        202        ob7u          Michaels
## 27         440       NH Oki   NA        202        27vk             Never
## 28         441       NH Oki   NA        202        ovvy            Object
## 29         443       NH Oki   NA        202        yocg            Quincy
## 30         444       NH Oki   NA        202        yk8a             Rolls
## 31         446       NH Oki   NA        202        wfv3               Tut
## 32         401      Oki MEU   NA        203        xvxe           Abraham
## 33         402      Oki MEU   NA        203        kobl            Bailey
## 34         403      Oki MEU   NA        203        x0qi              Carr
## 35         404      Oki MEU   NA        203        pd7n          Davidson
## 36         405      Oki MEU   NA        203        87cl           Ellison
## 37         406      Oki MEU   NA        203        m8w6           Forsyth
## 38         407      Oki MEU   NA        203        wnaf            Glover
## 39         408      Oki MEU   NA        203        as5q            Harris
## 40         409      Oki MEU   NA        203        pb8x              Ince
## 41         410      Oki MEU   NA        203        5t8r             Jones
## 42         414      Oki MEU   NA        203        k1lv              Nash
## 43         415      Oki MEU   NA        203        cn7q            Oliver
## 44         419      Oki MEU   NA        203        pt9y        Sutherland
## 45         420      Oki MEU   NA        203        paed            Taylor
## 46         421      Oki MEU   NA        203        zaif         Underwood
## 47         422      Oki MEU   NA        203        h8pg           Vaughan
## 48         423      Oki MEU   NA        203        vqdq            Walker
## 49         424      Oki MEU   NA        203        d6hs             Xiong
## 50         425      Oki MEU   NA        203        tb5t             Young
## 51         426      Oki MEU   NA        203        d2nz            Zimmer
## 52         427      Oki MEU   NA        203        9je3            Aikman
## 53         429      Oki MEU   NA        203        85i6            Coolie
## 54         430      Oki MEU   NA        203        zkff            Dulles
## 55         431      Oki MEU   NA        203        6ust             Estes
## 56         432      Oki MEU   NA        203        785o              Flag
## 57         433      Oki MEU   NA        203        6zmz             Grind
## 58         434      Oki MEU   NA        203        525l              Hyer
## 59         435      Oki MEU   NA        203        cbku          Instance
## 60         436      Oki MEU   NA        203        0cot              Jack
## 61         437      Oki MEU   NA        203        ojoz           Kippler
## 62         438      Oki MEU   NA        203        tun2          Laurence
## 63         439      Oki MEU   NA        203        ob7u          Michaels
## 64         440      Oki MEU   NA        203        27vk             Never
## 65         441      Oki MEU   NA        203        ovvy            Object
## 66         443      Oki MEU   NA        203        yocg            Quincy
## 67         444      Oki MEU   NA        203        yk8a             Rolls
## 68         446      Oki MEU   NA        203        wfv3               Tut
## 69         401      3rd MLG   NA        204        xvxe           Abraham
## 70         402      3rd MLG   NA        204        kobl            Bailey
## 71         403      3rd MLG   NA        204        x0qi              Carr
## 72         404      3rd MLG   NA        204        pd7n          Davidson
## 73         405      3rd MLG   NA        204        87cl           Ellison
## 74         406      3rd MLG   NA        204        m8w6           Forsyth
## 75         407      3rd MLG   NA        204        wnaf            Glover
## 76         408      3rd MLG   NA        204        as5q            Harris
## 77         409      3rd MLG   NA        204        pb8x              Ince
## 78         410      3rd MLG   NA        204        5t8r             Jones
## 79         412      3rd MLG   NA        204        9aa1           Lambert
## 80         414      3rd MLG   NA        204        k1lv              Nash
## 81         415      3rd MLG   NA        204        cn7q            Oliver
## 82         418      3rd MLG   NA        204        bakn          Rampling
## 83         419      3rd MLG   NA        204        pt9y        Sutherland
## 84         420      3rd MLG   NA        204        paed            Taylor
## 85         421      3rd MLG   NA        204        zaif         Underwood
## 86         422      3rd MLG   NA        204        h8pg           Vaughan
## 87         423      3rd MLG   NA        204        vqdq            Walker
## 88         424      3rd MLG   NA        204        d6hs             Xiong
## 89         425      3rd MLG   NA        204        tb5t             Young
## 90         426      3rd MLG   NA        204        d2nz            Zimmer
## 91         427      3rd MLG   NA        204        9je3            Aikman
## 92         429      3rd MLG   NA        204        85i6            Coolie
## 93         430      3rd MLG   NA        204        zkff            Dulles
## 94         431      3rd MLG   NA        204        6ust             Estes
## 95         432      3rd MLG   NA        204        785o              Flag
## 96         433      3rd MLG   NA        204        6zmz             Grind
## 97         434      3rd MLG   NA        204        525l              Hyer
## 98         435      3rd MLG   NA        204        cbku          Instance
## 99         436      3rd MLG   NA        204        0cot              Jack
## 100        437      3rd MLG   NA        204        ojoz           Kippler
## 101        438      3rd MLG   NA        204        tun2          Laurence
## 102        439      3rd MLG   NA        204        ob7u          Michaels
## 103        440      3rd MLG   NA        204        27vk             Never
## 104        441      3rd MLG   NA        204        ovvy            Object
## 105        443      3rd MLG   NA        204        yocg            Quincy
## 106        444      3rd MLG   NA        204        yk8a             Rolls
## 107        446      3rd MLG   NA        204        wfv3               Tut
## 108        401      NH Yoko   NA        205        xvxe           Abraham
## 109        402      NH Yoko   NA        205        kobl            Bailey
## 110        403      NH Yoko   NA        205        x0qi              Carr
## 111        405      NH Yoko   NA        205        87cl           Ellison
## 112        406      NH Yoko   NA        205        m8w6           Forsyth
## 113        408      NH Yoko   NA        205        as5q            Harris
## 114        409      NH Yoko   NA        205        pb8x              Ince
## 115        410      NH Yoko   NA        205        5t8r             Jones
## 116        412      NH Yoko   NA        205        9aa1           Lambert
## 117        413      NH Yoko   NA        205        5sjg            Murray
## 118        414      NH Yoko   NA        205        k1lv              Nash
## 119        415      NH Yoko   NA        205        cn7q            Oliver
## 120        420      NH Yoko   NA        205        paed            Taylor
## 121        421      NH Yoko   NA        205        zaif         Underwood
## 122        423      NH Yoko   NA        205        vqdq            Walker
## 123        424      NH Yoko   NA        205        d6hs             Xiong
## 124        425      NH Yoko   NA        205        tb5t             Young
## 125        426      NH Yoko   NA        205        d2nz            Zimmer
## 126        427      NH Yoko   NA        205        9je3            Aikman
## 127        429      NH Yoko   NA        205        85i6            Coolie
## 128        430      NH Yoko   NA        205        zkff            Dulles
## 129        431      NH Yoko   NA        205        6ust             Estes
## 130        432      NH Yoko   NA        205        785o              Flag
## 131        433      NH Yoko   NA        205        6zmz             Grind
## 132        435      NH Yoko   NA        205        cbku          Instance
## 133        437      NH Yoko   NA        205        ojoz           Kippler
## 134        438      NH Yoko   NA        205        tun2          Laurence
## 135        439      NH Yoko   NA        205        ob7u          Michaels
## 136        440      NH Yoko   NA        205        27vk             Never
## 137        441      NH Yoko   NA        205        ovvy            Object
## 138        442      NH Yoko   NA        205        bqrp             Power
## 139        443      NH Yoko   NA        205        yocg            Quincy
## 140        444      NH Yoko   NA        205        yk8a             Rolls
## 141        401         Rota   NA        206        xvxe           Abraham
## 142        403         Rota   NA        206        x0qi              Carr
## 143        405         Rota   NA        206        87cl           Ellison
## 144        408         Rota   NA        206        as5q            Harris
## 145        410         Rota   NA        206        5t8r             Jones
## 146        412         Rota   NA        206        9aa1           Lambert
## 147        414         Rota   NA        206        k1lv              Nash
## 148        415         Rota   NA        206        cn7q            Oliver
## 149        420         Rota   NA        206        paed            Taylor
## 150        421         Rota   NA        206        zaif         Underwood
## 151        423         Rota   NA        206        vqdq            Walker
## 152        424         Rota   NA        206        d6hs             Xiong
## 153        425         Rota   NA        206        tb5t             Young
## 154        426         Rota   NA        206        d2nz            Zimmer
## 155        427         Rota   NA        206        9je3            Aikman
## 156        429         Rota   NA        206        85i6            Coolie
## 157        430         Rota   NA        206        zkff            Dulles
## 158        431         Rota   NA        206        6ust             Estes
## 159        432         Rota   NA        206        785o              Flag
## 160        433         Rota   NA        206        6zmz             Grind
## 161        435         Rota   NA        206        cbku          Instance
## 162        437         Rota   NA        206        ojoz           Kippler
## 163        438         Rota   NA        206        tun2          Laurence
## 164        439         Rota   NA        206        ob7u          Michaels
## 165        440         Rota   NA        206        27vk             Never
## 166        441         Rota   NA        206        ovvy            Object
##  [ reached getOption("max.print") -- omitted 315 rows ]
```

```r
# dput(colnames(ds_command_long)) # Print colnames for line below.
ds_command_long <- ds_command_long %>%
  dplyr::select_(.dots=c("command_id", "officer_id", "rank"))#, "command_name", "billet_count_max"))
ds_officer_long <- ds_officer_long %>%
  dplyr::select_(.dots=c("command_id", "officer_id", "rank"))#, "officer_tag" , "officer_name_last"))
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
## R version 3.3.2 Patched (2017-01-07 r71934)
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
## [1] magrittr_1.5
## 
## loaded via a namespace (and not attached):
##  [1] readr_1.0.0      lazyeval_0.2.0   R6_2.2.0         assertthat_0.1  
##  [5] DBI_0.5-1        tools_3.3.2      dplyr_0.5.0.9000 tibble_1.2      
##  [9] Rcpp_0.12.8      stringi_1.1.2    knitr_1.15.1     stringr_1.1.0   
## [13] testit_0.6       tidyr_0.6.1      evaluate_0.10
```

```r
Sys.time()
```

```
## [1] "2017-01-17 17:33:15 CST"
```

