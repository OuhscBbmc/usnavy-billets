



This report was automatically generated with the R package **knitr**
(version 1.12.3).


```r
# knitr::stitch_rmd(script="./analysis/select.R", output="./analysis/stitched-output/select.md")
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.
```


```r
# Attach these packages so their functions don't need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
library(magrittr, quietly=TRUE)

# Verify these packages are available on the machine, but their functions need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
requireNamespace("matchingMarkets")
requireNamespace("readr")
requireNamespace("tidyr")
requireNamespace("dplyr") #Avoid attaching dplyr, b/c its function names conflict with a lot of packages (esp base, stats, and plyr).
```

```r
path_in_hospital   <- "./data-phi-free/derived/hospital.csv"
path_in_officer    <- "./data-phi-free/derived/officer.csv"
```

```r
# Read the CSVs
ds_hospital_long   <- readr::read_csv(path_in_hospital)
ds_officer_long    <- readr::read_csv(path_in_officer)

ds_hospital_roster <- readr::read_csv("./data-phi-free/raw/hospital-roster.csv")
ds_officer_roster  <- readr::read_csv("./data-phi-free/raw/officer-roster.csv")
```

```r
ds_hospital_roster$hospital_index <- seq_len(nrow(ds_hospital_roster))
ds_officer_roster$officer_index   <- seq_len(nrow(ds_officer_roster))

ds_hospital <- ds_hospital_long %>%
  dplyr::mutate(
    hospital_id  = sprintf("b_%03d", hospital_id),
    officer_id   = sprintf("o_%03d", officer_id)
  ) %>%
  tidyr::spread(key=hospital_id, value=preference)

hospital <- ds_hospital %>%
  dplyr::select(-officer_id) %>%
  as.matrix()
row.names(hospital) <- ds_hospital$officer_id

ds_officer <- ds_officer_long %>%
  dplyr::mutate(
    hospital_id  = sprintf("b_%03d", hospital_id),
    officer_id   = sprintf("o_%03d", officer_id)
  ) %>%
  tidyr::spread(key=officer_id, value=preference)

officer <- ds_officer %>%
  dplyr::select(-hospital_id) %>%
  as.matrix()
row.names(officer) <- ds_officer$hospital_id
```

```r
m <- matchingMarkets::daa(
  c.prefs = hospital, #College/hospital preferences (each student  is a row)
  s.prefs = officer#, #Student/officer  preferences (each hospital is a row)
  # nSlots  = ds_hospital_roster$billet_count
)
print(m)
```

```
## $s.prefs
##       o_401 o_402 o_403 o_404 o_405 o_406 o_407 o_408 o_409 o_410 o_411
## b_201    16     4    22     9     2    15     8     9     9    10    11
## b_202     7    21    15     2    20     2     3     2    13    22    15
## b_203    20     3    19     3     5    12     9     6     2    14     9
## b_204    21    16    16    14     9    22    10     7    16     1     5
## b_205    17     7    10    10     1     8    12    17     4    13    12
## b_206    19    11     6     6     8    17     5    14    19    18    14
## b_207     5     1     8    22    21    18    17    12    12     8     8
## b_208     8     9    20    12     7    13    14     8     5     4     7
## b_209     3     8    13     5    19    16    22     5    14    16     3
## b_210    13     5     4    13    13     7    13    22     8     5     4
## b_211    15    15     5    15    22     6     2    13     7     7    20
## b_212    12    12    12     8    10     5    16    11     6     6    16
## b_213     2    10    18    18     3    19    20     4    18     3    21
## b_214    18    18    17     7    12    21     1    20     1    12    17
## b_215    22    19     1     4     4    20    18    21    22    17    22
## b_216    11    20     9    16    16     9    19    10    20     9    10
## b_217     4    17    21     1    17    10    11     3    11    21    18
## b_218    10     2     2    11    14     4    15     1     3    20     6
## b_219     1    13     3    17    11    11     6    16    10    11    19
## b_220    14    14     7    19    15     3     7    19    15    15    13
## b_221     6    22    11    20    18     1     4    18    21     2     1
## b_222     9     6    14    21     6    14    21    15    17    19     2
##       o_412 o_413 o_414 o_415 o_416 o_417 o_418 o_419 o_420 o_421 o_422
## b_201    20    10    21     8     4    22     5     1    19     9     8
## b_202    18     2     9     3    17     4    10    11     4     7     5
## b_203     5     8    18    22     1    14    17     3     1     3    13
## b_204    17    19     8    11     6    20    11    17     7     2    11
## b_205     1    13     5    15     8     8    19     2    10    20    12
## b_206     4    16    14    12    18     5    18    10     8    11    22
## b_207    14    17     4    20    19    19    13     4    20     4    17
## b_208    16     3     3    17    10    11    14     9    16    21    18
## b_209    22     6    15     6    12    12     1    12    22    12    19
## b_210     7     1    19    21     3    13     3     5    14    14     4
## b_211     3    21     1    18    20    15     6    22     3     8    14
## b_212    11    22    16    13     5     6     4    16     2    10    15
## b_213     8     9     6     7    11     1     7     7    15     1    21
## b_214     6    18    10     5    14    18    22    13    12    18     6
## b_215    13    14    22     1    16     3     2    18     5    13     1
## b_216    10     5    12    14     7    17    20    19    13    16    20
## b_217    21     7     7     4    15    21     9    20    17     6     9
## b_218     2    12    11     9    13     2    15    14     9    15     3
## b_219     9    20    20    16     2     9    21    21    18    22     2
## b_220    12    15    13     2     9    16    12    15    21     5    16
## b_221    15    11    17    10    21    10     8     6     6    17    10
## b_222    19     4     2    19    22     7    16     8    11    19     7
##       o_423 o_424 o_425 o_426
## b_201     7    21     5    18
## b_202    17    22    17     4
## b_203    19    11    15    14
## b_204     5    15     6    16
## b_205     3     8    18    20
## b_206    20    16     1     8
## b_207     2     1     3     7
## b_208    18     6    11     1
## b_209     6    20    22    12
## b_210    21    13    10     6
## b_211    14     9    21    19
## b_212     8     2     8    22
## b_213     1    19     9    21
## b_214    13    10     2    10
## b_215    15    17     4     9
## b_216     4     4     7    13
## b_217    22     3    19    15
## b_218     9    18    12    17
## b_219    10     5    14     5
## b_220    12     7    13     2
## b_221    16    14    20    11
## b_222    11    12    16     3
## 
## $c.prefs
##       b_201 b_202 b_203 b_204 b_205 b_206 b_207 b_208 b_209 b_210 b_211
## o_401    25     2     3    20     2     2    16    16     8    23    10
## o_402    13     9    12    10    17    10    22    15    12     1     6
## o_403     6    23    13    16    10    23    14    26    10     3    20
## o_404    16    12     5     2    13     6     6     8     5    15    16
## o_405     1     1     6    24    14     8    21    12     1    20     5
## o_406     7     5    14    21     5    16     1    18     9    22     3
## o_407    19    20    20     8    19     4    13     9     4    25    15
## o_408    14    16    17    22     6    18    19    14    20     9     4
## o_409     2    11    21    26     9    17    20     3     3    18    14
## o_410     5    10    25    25    11     1    26     5    16     8     7
## o_411     8    25     2    18    24    22     9     2    21    13     1
## o_412    20     8    18     4    21     3    25    13    26    12     8
## o_413    18    17    19    15    12    13    10     6    19    11    17
## o_414    22    21     4    13    26    24    12     4    13    16    18
## o_415    12    14    16     5    16    19    17    22    14     2    22
## o_416    23    15    24     1     1    26     8    21    23     5     2
## o_417     4    24    11    17     4     9    24     7     7    21    19
## o_418    26     6    15    12    22    21     2    11     6    10    12
## o_419    10     4    10     6    25     7    15    23    17     6    26
## o_420    17    19    26    23    18    15    11    10     2     7    24
## o_421     9    18     7    11    15    14     5    20    15    19    21
## o_422    11    22    23     7    20    20     4    25    22     4    11
## o_423     3    13     9    19     8    12     7    24    25    17    23
## o_424    15     7     1     3    23    25     3    17    11    24    25
## o_425    24     3    22    14     7     5    18     1    18    14     9
## o_426    21    26     8     9     3    11    23    19    24    26    13
##       b_212 b_213 b_214 b_215 b_216 b_217 b_218 b_219 b_220 b_221 b_222
## o_401     3    26    10    25     4     1     8     4     9    24    17
## o_402    13     4    14    21    11     3    15    20     8    17    14
## o_403    17    20    21     6     6     7    23    26    13     5     9
## o_404    19    13    16     8     3     9    16    19    20    16    22
## o_405     2    21    23     3    15    12    11    11    18     6     4
## o_406    15    15    25     4    18     4    19    16     6     3    19
## o_407    20     5     2    18    12    16    13    18    24    22     3
## o_408     5    11     3    13    24    14    20    24     3    26     5
## o_409    22     6    19    12    20    24    18     9    19     7     8
## o_410     8    22    18    14    26    20     7     5     1    12    12
## o_411    12     7    17     5     7    10     5     7    23    23    15
## o_412    10     9     7    16     9     8    17     2    11    21     2
## o_413    21    19     6    10     1    26     3     6    26     9    25
## o_414    16    14     9    17    22    21     6    22    14    11    11
## o_415     1    16     1    20     8    18     1     8     5     8     7
## o_416    14    23     4     1     5     5    22    10    17     2     6
## o_417    25    18    11     7    19    17     4    25    25    19    23
## o_418    11    24    20    15    23    22    25     3    22     4    21
## o_419     7    17    13     2    14    11    24    23    12    25    16
## o_420    24     2    22    26    16    15    14    14    10    20    24
## o_421    18     3     8    23    25     6    12    12    21    18     1
## o_422    23    10     5    19     2    25    26    13     4    10    20
## o_423     6    12    12     9    13    19    21    15     7     1    26
## o_424     9     1    24    22    10    23     9     1     2    13    10
## o_425     4    25    15    24    21     2    10    17    16    15    13
## o_426    26     8    26    11    17    13     2    21    15    14    18
## 
## $iterations
## [1] 67
## 
## $matches
## $matches[[1]]
## [1] 13
## 
## $matches[[2]]
## [1] 9
## 
## $matches[[3]]
## [1] 12
## 
## $matches[[4]]
## [1] 16
## 
## $matches[[5]]
## [1] 2
## 
## $matches[[6]]
## [1] 6
## 
## $matches[[7]]
## [1] 22
## 
## $matches[[8]]
## [1] 15
## 
## $matches[[9]]
## [1] 8
## 
## $matches[[10]]
## [1] 3
## 
## $matches[[11]]
## [1] 5
## 
## $matches[[12]]
## [1] 19
## 
## $matches[[13]]
## [1] 26
## 
## $matches[[14]]
## [1] 10
## 
## $matches[[15]]
## [1] 25
## 
## $matches[[16]]
## [1] 4
## 
## $matches[[17]]
## [1] 1
## 
## $matches[[18]]
## [1] 23
## 
## $matches[[19]]
## [1] 20
## 
## $matches[[20]]
## [1] 18
## 
## $matches[[21]]
## [1] 24
## 
## $matches[[22]]
## [1] 17
## 
## 
## $match.mat
##        [,1]  [,2]  [,3]  [,4]  [,5]  [,6]  [,7]  [,8]  [,9] [,10] [,11]
##  [1,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [2,] FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE
##  [3,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE
##  [4,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [5,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE
##  [6,] FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE
##  [7,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [8,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE
##  [9,] FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [10,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [11,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [12,] FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [13,]  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [14,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [15,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
## [16,] FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [17,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [18,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [19,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [20,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [21,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [22,] FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE
## [23,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [24,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [25,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [26,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##       [,12] [,13] [,14] [,15] [,16] [,17] [,18] [,19] [,20] [,21] [,22]
##  [1,] FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE
##  [2,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [3,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [4,] FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE
##  [5,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [6,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [7,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [8,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [9,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [10,] FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [11,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [12,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [13,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [14,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [15,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [16,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [17,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE
## [18,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE
## [19,]  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [20,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
## [21,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [22,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [23,] FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE
## [24,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE
## [25,] FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [26,] FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## 
## $singles
## [1]  7 11 14 21
## 
## $edgelist
##    colleges students
## 1         1       13
## 2         2        9
## 3         3       12
## 4         4       16
## 5         5        2
## 6         6        6
## 7         7       22
## 8         8       15
## 9         9        8
## 10       10        3
## 11       11        5
## 12       12       19
## 13       13       26
## 14       14       10
## 15       15       25
## 16       16        4
## 17       17        1
## 18       18       23
## 19       19       20
## 20       20       18
## 21       21       24
## 22       22       17
```

```r
ds_edge <- m$edgelist %>%
  dplyr::rename(
    hospital_index  = colleges,
    officer_index   = students
  ) %>%
  dplyr::left_join(ds_hospital_roster, by="hospital_index") %>%
  dplyr::left_join(ds_officer_roster , by="officer_index" )

knitr::kable(ds_edge)
```



| hospital_index| officer_index| hospital_id|hospital_name | billet_count_max| officer_id|office_name_last |
|--------------:|-------------:|-----------:|:-------------|----------------:|----------:|:----------------|
|              1|            13|         201|NH Guam       |                2|        413|Murray           |
|              2|             9|         202|WRNMMC        |                0|        409|Ince             |
|              3|            12|         203|Lejeune MEU   |                2|        412|Lambert          |
|              4|            16|         204|Lejeune MLG   |                2|        416|Paige            |
|              5|             2|         205|NHCL          |                3|        402|Bailey           |
|              6|             6|         206|NH Oki        |                0|        406|Forsyth          |
|              7|            22|         207|Oki MLG       |                2|        422|Vaughan          |
|              8|            15|         208|Oki MEU       |                1|        415|Oliver           |
|              9|             8|         209|NHCP          |                3|        408|Harris           |
|             10|             3|         210|Ft Belv       |                1|        403|Carr             |
|             11|             5|         211|Guant         |                1|        405|Ellison          |
|             12|            19|         212|CBIRF         |                1|        419|Sutherland       |
|             13|            26|         213|NH Jax        |                2|        426|Zimmer           |
|             14|            10|         214|NTTC          |                0|        410|Jones            |
|             15|            25|         215|NH Napl       |                3|        425|Young            |
|             16|             4|         216|NMCP          |                6|        404|Davidson         |
|             17|             1|         217|NH Rota       |                2|        401|Abraham          |
|             18|            23|         218|NMCSD         |                2|        423|Walker           |
|             19|            20|         219|NH Sig        |                1|        420|Taylor           |
|             20|            18|         220|NHTP          |                1|        418|Rampling         |
|             21|            24|         221|WHMP          |                1|        424|Xiong            |
|             22|            17|         222|NH Yoko       |                3|        417|Quinn            |

The R session information (including the OS info, R version and all
packages used):


```r
sessionInfo()
```

```
## R version 3.2.3 (2015-12-10)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 14.04.3 LTS
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
## [1] magrittr_1.5
## 
## loaded via a namespace (and not attached):
##  [1] Rcpp_0.12.3           tidyr_0.4.0           dplyr_0.4.3.9000     
##  [4] gmp_0.5-12            assertthat_0.1        R6_2.1.2             
##  [7] DBI_0.3.1.9008        formatR_1.2.1         evaluate_0.8         
## [10] highr_0.5.1           stringi_1.0-1         lazyeval_0.1.10      
## [13] partitions_1.9-18     polynom_1.3-8         tools_3.2.3          
## [16] stringr_1.0.0.9000    readr_0.2.2           matchingMarkets_0.2-1
## [19] markdown_0.7.7        parallel_3.2.3        rsconnect_0.4.1.4    
## [22] knitr_1.12.3          lpSolve_5.6.13
```

```r
Sys.time()
```

```
## [1] "2016-02-05 00:34:22 CST"
```

