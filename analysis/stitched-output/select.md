



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
path_in_hospital  <- "./data-phi-free/derived/hospital.csv"
path_in_officer <- "./data-phi-free/derived/officer.csv"
```

```r
# Read the CSVs
ds_hospital_long   <- readr::read_csv(path_in_hospital)
ds_officer_long  <- readr::read_csv(path_in_officer)

ds_hospital_roster   <- readr::read_csv("./data-phi-free/raw/hospital-roster.csv")
ds_officer_roster  <- readr::read_csv("./data-phi-free/raw/officer-roster.csv")
```

```r
ds_hospital <- ds_hospital_long %>%
  dplyr::mutate(
    hospital_id  = sprintf("b_%03d", hospital_id),
    officer_id = sprintf("o_%03d", officer_id)
  ) %>%
  tidyr::spread(key=officer_id, value=preference) %>%
  dplyr::mutate(hospital_index = seq_len(n()))

hospital <- ds_hospital %>%
  dplyr::select(-hospital_id, -hospital_index) %>%
  as.matrix()
row.names(hospital) <- ds_hospital$hospital_id

ds_officer <- ds_officer_long %>%
  dplyr::mutate(
    hospital_id = sprintf("b_%03d", hospital_id),
    officer_id = sprintf("o_%03d", officer_id)
  ) %>%
  tidyr::spread(key=hospital_id, value=preference) %>%
  dplyr::mutate(officer_index = seq_len(n()))

officer <- ds_officer %>%
  dplyr::select(-officer_id, -officer_index) %>%
  as.matrix()
row.names(officer) <- ds_officer$officer_id
```

```r
m <- matchingMarkets::daa(c.prefs=hospital, s.prefs=officer)
print(m)
```

```
## $s.prefs
##       b_201 b_202 b_203 b_204 b_205 b_206 b_207 b_208 b_209 b_210 b_211
## o_401    16     7    20    21    17    19     5     8     3    13    15
## o_402     4    21     3    16     7    11     1     9     8     5    15
## o_403    22    15    19    16    10     6     8    20    13     4     5
## o_404     9     2     3    14    10     6    22    12     5    13    15
## o_405     2    20     5     9     1     8    21     7    19    13    22
## o_406    15     2    12    22     8    17    18    13    16     7     6
## o_407     8     3     9    10    12     5    17    14    22    13     2
## o_408     9     2     6     7    17    14    12     8     5    22    13
## o_409     9    13     2    16     4    19    12     5    14     8     7
## o_410    10    22    14     1    13    18     8     4    16     5     7
## o_411    11    15     9     5    12    14     8     7     3     4    20
## o_412    20    18     5    17     1     4    14    16    22     7     3
## o_413    10     2     8    19    13    16    17     3     6     1    21
## o_414    21     9    18     8     5    14     4     3    15    19     1
## o_415     8     3    22    11    15    12    20    17     6    21    18
## o_416     4    17     1     6     8    18    19    10    12     3    20
## o_417    22     4    14    20     8     5    19    11    12    13    15
## o_418     5    10    17    11    19    18    13    14     1     3     6
## o_419     1    11     3    17     2    10     4     9    12     5    22
## o_420    19     4     1     7    10     8    20    16    22    14     3
## o_421     9     7     3     2    20    11     4    21    12    14     8
## o_422     8     5    13    11    12    22    17    18    19     4    14
## o_423     7    17    19     5     3    20     2    18     6    21    14
## o_424    21    22    11    15     8    16     1     6    20    13     9
## o_425     5    17    15     6    18     1     3    11    22    10    21
## o_426    18     4    14    16    20     8     7     1    12     6    19
##       b_212 b_213 b_214 b_215 b_216 b_217 b_218 b_219 b_220 b_221 b_222
## o_401    12     2    18    22    11     4    10     1    14     6     9
## o_402    12    10    18    19    20    17     2    13    14    22     6
## o_403    12    18    17     1     9    21     2     3     7    11    14
## o_404     8    18     7     4    16     1    11    17    19    20    21
## o_405    10     3    12     4    16    17    14    11    15    18     6
## o_406     5    19    21    20     9    10     4    11     3     1    14
## o_407    16    20     1    18    19    11    15     6     7     4    21
## o_408    11     4    20    21    10     3     1    16    19    18    15
## o_409     6    18     1    22    20    11     3    10    15    21    17
## o_410     6     3    12    17     9    21    20    11    15     2    19
## o_411    16    21    17    22    10    18     6    19    13     1     2
## o_412    11     8     6    13    10    21     2     9    12    15    19
## o_413    22     9    18    14     5     7    12    20    15    11     4
## o_414    16     6    10    22    12     7    11    20    13    17     2
## o_415    13     7     5     1    14     4     9    16     2    10    19
## o_416     5    11    14    16     7    15    13     2     9    21    22
## o_417     6     1    18     3    17    21     2     9    16    10     7
## o_418     4     7    22     2    20     9    15    21    12     8    16
## o_419    16     7    13    18    19    20    14    21    15     6     8
## o_420     2    15    12     5    13    17     9    18    21     6    11
## o_421    10     1    18    13    16     6    15    22     5    17    19
## o_422    15    21     6     1    20     9     3     2    16    10     7
## o_423     8     1    13    15     4    22     9    10    12    16    11
## o_424     2    19    10    17     4     3    18     5     7    14    12
## o_425     8     9     2     4     7    19    12    14    13    20    16
## o_426    22    21    10     9    13    15    17     5     2    11     3
## 
## $c.prefs
##       o_401 o_402 o_403 o_404 o_405 o_406 o_407 o_408 o_409 o_410 o_411
## b_201    25    13     6    16     1     7    19    14     2     5     8
## b_202     2     9    23    12     1     5    20    16    11    10    25
## b_203     3    12    13     5     6    14    20    17    21    25     2
## b_204    20    10    16     2    24    21     8    22    26    25    18
## b_205     2    17    10    13    14     5    19     6     9    11    24
## b_206     2    10    23     6     8    16     4    18    17     1    22
## b_207    16    22    14     6    21     1    13    19    20    26     9
## b_208    16    15    26     8    12    18     9    14     3     5     2
## b_209     8    12    10     5     1     9     4    20     3    16    21
## b_210    23     1     3    15    20    22    25     9    18     8    13
## b_211    10     6    20    16     5     3    15     4    14     7     1
## b_212     3    13    17    19     2    15    20     5    22     8    12
## b_213    26     4    20    13    21    15     5    11     6    22     7
## b_214    10    14    21    16    23    25     2     3    19    18    17
## b_215    25    21     6     8     3     4    18    13    12    14     5
## b_216     4    11     6     3    15    18    12    24    20    26     7
## b_217     1     3     7     9    12     4    16    14    24    20    10
## b_218     8    15    23    16    11    19    13    20    18     7     5
## b_219     4    20    26    19    11    16    18    24     9     5     7
## b_220     9     8    13    20    18     6    24     3    19     1    23
## b_221    24    17     5    16     6     3    22    26     7    12    23
## b_222    17    14     9    22     4    19     3     5     8    12    15
##       o_412 o_413 o_414 o_415 o_416 o_417 o_418 o_419 o_420 o_421 o_422
## b_201    20    18    22    12    23     4    26    10    17     9    11
## b_202     8    17    21    14    15    24     6     4    19    18    22
## b_203    18    19     4    16    24    11    15    10    26     7    23
## b_204     4    15    13     5     1    17    12     6    23    11     7
## b_205    21    12    26    16     1     4    22    25    18    15    20
## b_206     3    13    24    19    26     9    21     7    15    14    20
## b_207    25    10    12    17     8    24     2    15    11     5     4
## b_208    13     6     4    22    21     7    11    23    10    20    25
## b_209    26    19    13    14    23     7     6    17     2    15    22
## b_210    12    11    16     2     5    21    10     6     7    19     4
## b_211     8    17    18    22     2    19    12    26    24    21    11
## b_212    10    21    16     1    14    25    11     7    24    18    23
## b_213     9    19    14    16    23    18    24    17     2     3    10
## b_214     7     6     9     1     4    11    20    13    22     8     5
## b_215    16    10    17    20     1     7    15     2    26    23    19
## b_216     9     1    22     8     5    19    23    14    16    25     2
## b_217     8    26    21    18     5    17    22    11    15     6    25
## b_218    17     3     6     1    22     4    25    24    14    12    26
## b_219     2     6    22     8    10    25     3    23    14    12    13
## b_220    11    26    14     5    17    25    22    12    10    21     4
## b_221    21     9    11     8     2    19     4    25    20    18    10
## b_222     2    25    11     7     6    23    21    16    24     1    20
##       o_423 o_424 o_425 o_426
## b_201     3    15    24    21
## b_202    13     7     3    26
## b_203     9     1    22     8
## b_204    19     3    14     9
## b_205     8    23     7     3
## b_206    12    25     5    11
## b_207     7     3    18    23
## b_208    24    17     1    19
## b_209    25    11    18    24
## b_210    17    24    14    26
## b_211    23    25     9    13
## b_212     6     9     4    26
## b_213    12     1    25     8
## b_214    12    24    15    26
## b_215     9    22    24    11
## b_216    13    10    21    17
## b_217    19    23     2    13
## b_218    21     9    10     2
## b_219    15     1    17    21
## b_220     7     2    16    15
## b_221     1    13    15    14
## b_222    26    10    13    18
## 
## $iterations
## [1] 1
## 
## $matches
## $matches[[1]]
## [1] 19
## 
## $matches[[2]]
## [1] 13
## 
## $matches[[3]]
## [1] 9
## 
## $matches[[4]]
## [1] 17
## 
## $matches[[5]]
## [1] 7
## 
## $matches[[6]]
## [1] 21
## 
## $matches[[7]]
## [1] 2
## 
## $matches[[8]]
## [1] 8
## 
## $matches[[9]]
## [1] 22
## 
## $matches[[10]]
## [1] 18
## 
## $matches[[11]]
## [1] 16
## 
## $matches[[12]]
## [1] 12
## 
## $matches[[13]]
## [1] 10
## 
## $matches[[14]]
## [1] 20
## 
## $matches[[15]]
## [1] 11
## 
## $matches[[16]]
## [1] 1
## 
## $matches[[17]]
## [1] 5
## 
## $matches[[18]]
## [1] 14
## 
## $matches[[19]]
## [1] 6
## 
## $matches[[20]]
## [1] 3
## 
## $matches[[21]]
## [1] 4
## 
## $matches[[22]]
## [1] 15
## 
## $matches[[23]]
## [1] 0
## 
## $matches[[24]]
## [1] 0
## 
## $matches[[25]]
## [1] 0
## 
## $matches[[26]]
## [1] 0
## 
## 
## $match.mat
##        [,1]  [,2]  [,3]  [,4]  [,5]  [,6]  [,7]  [,8]  [,9] [,10] [,11]
##  [1,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [2,] FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE
##  [3,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [4,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [5,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [6,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [7,] FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE
##  [8,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
##  [9,] FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [10,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [11,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [12,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [13,] FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [14,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [15,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [16,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE
## [17,] FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [18,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE
## [19,]  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [20,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [21,] FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE
## [22,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE
##       [,12] [,13] [,14] [,15] [,16] [,17] [,18] [,19] [,20] [,21] [,22]
##  [1,] FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE
##  [2,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [3,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE
##  [4,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE
##  [5,] FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE
##  [6,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
##  [7,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [8,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [9,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [10,] FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [11,] FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [12,]  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [13,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [14,] FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE
## [15,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE
## [16,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [17,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [18,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [19,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [20,] FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [21,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [22,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##       [,23] [,24] [,25] [,26]
##  [1,] FALSE FALSE FALSE FALSE
##  [2,] FALSE FALSE FALSE FALSE
##  [3,] FALSE FALSE FALSE FALSE
##  [4,] FALSE FALSE FALSE FALSE
##  [5,] FALSE FALSE FALSE FALSE
##  [6,] FALSE FALSE FALSE FALSE
##  [7,] FALSE FALSE FALSE FALSE
##  [8,] FALSE FALSE FALSE FALSE
##  [9,] FALSE FALSE FALSE FALSE
## [10,] FALSE FALSE FALSE FALSE
## [11,] FALSE FALSE FALSE FALSE
## [12,] FALSE FALSE FALSE FALSE
## [13,] FALSE FALSE FALSE FALSE
## [14,] FALSE FALSE FALSE FALSE
## [15,] FALSE FALSE FALSE FALSE
## [16,] FALSE FALSE FALSE FALSE
## [17,] FALSE FALSE FALSE FALSE
## [18,] FALSE FALSE FALSE FALSE
## [19,] FALSE FALSE FALSE FALSE
## [20,] FALSE FALSE FALSE FALSE
## [21,] FALSE FALSE FALSE FALSE
## [22,] FALSE FALSE FALSE FALSE
## 
## $singles
## integer(0)
## 
## $edgelist
##    colleges students
## 1         1       19
## 2         2       13
## 3         3        9
## 4         4       17
## 5         5        7
## 6         6       21
## 7         7        2
## 8         8        8
## 9         9       22
## 10       10       18
## 11       11       16
## 12       12       12
## 13       13       10
## 14       14       20
## 15       15       11
## 16       16        1
## 17       17        5
## 18       18       14
## 19       19        6
## 20       20        3
## 21       21        4
## 22       22       15
## 23       23        0
## 24       24        0
## 25       25        0
## 26       26        0
```

```r
ds_edge <-m$edgelist %>%
  dplyr::rename(
    hospital_index  = colleges,
    officer_index = students
  ) %>%
  dplyr::left_join(ds_hospital[, c("hospital_id", "hospital_index")], by="hospital_index") %>%
  dplyr::left_join(ds_officer[, c("officer_id", "officer_index")], by="officer_index") %>%
  dplyr::mutate(
    hospital_id   = as.integer(gsub("^b_(\\d+)$", "\\1", hospital_id, perl=T)),
    officer_id  = as.integer(gsub("^o_(\\d+)$", "\\1", officer_id, perl=T))
  ) %>%
  dplyr::left_join(ds_hospital_roster, by="hospital_id") %>%
  dplyr::left_join(ds_officer_roster, by="officer_id")

knitr::kable(ds_edge)
```



| hospital_index| officer_index| hospital_id| officer_id|hospital_name | billet_count|office_name_last |
|--------------:|-------------:|-----------:|----------:|:-------------|------------:|:----------------|
|              1|            19|         201|        419|NH Guam       |            2|Sutherland       |
|              2|            13|         202|        413|WRNMMC        |            0|Murray           |
|              3|             9|         203|        409|Lejeune MEU   |            2|Ince             |
|              4|            17|         204|        417|Lejeune MLG   |            2|Quinn            |
|              5|             7|         205|        407|NHCL          |            3|Glover           |
|              6|            21|         206|        421|NH Oki        |            0|Underwood        |
|              7|             2|         207|        402|Oki MLG       |            2|Bailey           |
|              8|             8|         208|        408|Oki MEU       |            1|Harris           |
|              9|            22|         209|        422|NHCP          |            3|Vaughan          |
|             10|            18|         210|        418|Ft Belv       |            1|Rampling         |
|             11|            16|         211|        416|Guant         |            1|Paige            |
|             12|            12|         212|        412|CBIRF         |            1|Lambert          |
|             13|            10|         213|        410|NH Jax        |            2|Jones            |
|             14|            20|         214|        420|NTTC          |            0|Taylor           |
|             15|            11|         215|        411|NH Napl       |            3|Knox             |
|             16|             1|         216|        401|NMCP          |            6|Abraham          |
|             17|             5|         217|        405|NH Rota       |            2|Ellison          |
|             18|            14|         218|        414|NMCSD         |            2|Nash             |
|             19|             6|         219|        406|NH Sig        |            1|Forsyth          |
|             20|             3|         220|        403|NHTP          |            1|Carr             |
|             21|             4|         221|        404|WHMP          |            1|Davidson         |
|             22|            15|         222|        415|NH Yoko       |            3|Oliver           |
|             23|             0|          NA|         NA|NA            |           NA|NA               |
|             24|             0|          NA|         NA|NA            |           NA|NA               |
|             25|             0|          NA|         NA|NA            |           NA|NA               |
|             26|             0|          NA|         NA|NA            |           NA|NA               |

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
## [1] "2016-02-04 23:35:01 CST"
```

