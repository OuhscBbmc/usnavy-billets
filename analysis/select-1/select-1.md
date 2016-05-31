# US Navy Billets  --Selection Demo
Date: `r Sys.Date()`  

This report demonstrates one approach to optimally match officers and ER billets.  The project is under the initial direction of [Richard C. Childers](mailto:richard.childers@navy.mil), CDR NPC, PERS-4415, with advisement from [Alvin Roth](http://web.stanford.edu/~alroth/).

<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of two directories.-->


<!-- Set the report-wide options, and point to the external code file. -->


<!-- Load the sources.  Suppress the output when loading sources. --> 


<!-- Load 'sourced' R files.  Suppress the output when loading packages. --> 


<!-- Load any global functions and variables declared in the R file.  Suppress the output. --> 


<!-- Declare any global functions specific to a Rmd output.  Suppress the output. --> 


<!-- Load the datasets.   -->


<!-- Tweak the datasets.   -->


# Summary

### Notes 
1. The current report covers 26 officers, 22 unique hospitals, 39 total possible billets.


### Unanswered Questions

### Answered Questions


# Raw Rankings


### Input from Each Hospital



|officer_id | b_201| b_202| b_203| b_204| b_205| b_206| b_207| b_208| b_209| b_210| b_211| b_212| b_213| b_214| b_215| b_216| b_217| b_218| b_219| b_220| b_221| b_222|
|:----------|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|
|o_401      |    25|     2|     3|    20|     2|     2|    16|    16|     8|    23|    10|     3|    26|    10|    25|     4|     1|     8|     4|     9|    24|    17|
|o_402      |    13|     9|    12|    10|    17|    10|    22|    15|    12|     1|     6|    13|     4|    14|    21|    11|     3|    15|    20|     8|    17|    14|
|o_403      |     6|    23|    13|    16|    10|    23|    14|    26|    10|     3|    20|    17|    20|    21|     6|     6|     7|    23|    26|    13|     5|     9|
|o_404      |    16|    12|     5|     2|    13|     6|     6|     8|     5|    15|    16|    19|    13|    16|     8|     3|     9|    16|    19|    20|    16|    22|
|o_405      |     1|     1|     6|    24|    14|     8|    21|    12|     1|    20|     5|     2|    21|    23|     3|    15|    12|    11|    11|    18|     6|     4|
|o_406      |     7|     5|    14|    21|     5|    16|     1|    18|     9|    22|     3|    15|    15|    25|     4|    18|     4|    19|    16|     6|     3|    19|
|o_407      |    19|    20|    20|     8|    19|     4|    13|     9|     4|    25|    15|    20|     5|     2|    18|    12|    16|    13|    18|    24|    22|     3|
|o_408      |    14|    16|    17|    22|     6|    18|    19|    14|    20|     9|     4|     5|    11|     3|    13|    24|    14|    20|    24|     3|    26|     5|
|o_409      |     2|    11|    21|    26|     9|    17|    20|     3|     3|    18|    14|    22|     6|    19|    12|    20|    24|    18|     9|    19|     7|     8|
|o_410      |     5|    10|    25|    25|    11|     1|    26|     5|    16|     8|     7|     8|    22|    18|    14|    26|    20|     7|     5|     1|    12|    12|
|o_411      |     8|    25|     2|    18|    24|    22|     9|     2|    21|    13|     1|    12|     7|    17|     5|     7|    10|     5|     7|    23|    23|    15|
|o_412      |    20|     8|    18|     4|    21|     3|    25|    13|    26|    12|     8|    10|     9|     7|    16|     9|     8|    17|     2|    11|    21|     2|
|o_413      |    18|    17|    19|    15|    12|    13|    10|     6|    19|    11|    17|    21|    19|     6|    10|     1|    26|     3|     6|    26|     9|    25|
|o_414      |    22|    21|     4|    13|    26|    24|    12|     4|    13|    16|    18|    16|    14|     9|    17|    22|    21|     6|    22|    14|    11|    11|
|o_415      |    12|    14|    16|     5|    16|    19|    17|    22|    14|     2|    22|     1|    16|     1|    20|     8|    18|     1|     8|     5|     8|     7|
|o_416      |    23|    15|    24|     1|     1|    26|     8|    21|    23|     5|     2|    14|    23|     4|     1|     5|     5|    22|    10|    17|     2|     6|
|o_417      |     4|    24|    11|    17|     4|     9|    24|     7|     7|    21|    19|    25|    18|    11|     7|    19|    17|     4|    25|    25|    19|    23|
|o_418      |    26|     6|    15|    12|    22|    21|     2|    11|     6|    10|    12|    11|    24|    20|    15|    23|    22|    25|     3|    22|     4|    21|
|o_419      |    10|     4|    10|     6|    25|     7|    15|    23|    17|     6|    26|     7|    17|    13|     2|    14|    11|    24|    23|    12|    25|    16|
|o_420      |    17|    19|    26|    23|    18|    15|    11|    10|     2|     7|    24|    24|     2|    22|    26|    16|    15|    14|    14|    10|    20|    24|
|o_421      |     9|    18|     7|    11|    15|    14|     5|    20|    15|    19|    21|    18|     3|     8|    23|    25|     6|    12|    12|    21|    18|     1|
|o_422      |    11|    22|    23|     7|    20|    20|     4|    25|    22|     4|    11|    23|    10|     5|    19|     2|    25|    26|    13|     4|    10|    20|
|o_423      |     3|    13|     9|    19|     8|    12|     7|    24|    25|    17|    23|     6|    12|    12|     9|    13|    19|    21|    15|     7|     1|    26|
|o_424      |    15|     7|     1|     3|    23|    25|     3|    17|    11|    24|    25|     9|     1|    24|    22|    10|    23|     9|     1|     2|    13|    10|
|o_425      |    24|     3|    22|    14|     7|     5|    18|     1|    18|    14|     9|     4|    25|    15|    24|    21|     2|    10|    17|    16|    15|    13|
|o_426      |    21|    26|     8|     9|     3|    11|    23|    19|    24|    26|    13|    26|     8|    26|    11|    17|    13|     2|    21|    15|    14|    18|



### Input from Each Officer



|hospital_id | o_401| o_402| o_403| o_404| o_405| o_406| o_407| o_408| o_409| o_410| o_411| o_412| o_413| o_414| o_415| o_416| o_417| o_418| o_419| o_420| o_421| o_422| o_423| o_424| o_425| o_426|
|:-----------|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|
|b_201       |    16|     4|    22|     9|     2|    15|     8|     9|     9|    10|    11|    20|    10|    21|     8|     4|    22|     5|     1|    19|     9|     8|     7|    21|     5|    18|
|b_202       |     7|    21|    15|     2|    20|     2|     3|     2|    13|    22|    15|    18|     2|     9|     3|    17|     4|    10|    11|     4|     7|     5|    17|    22|    17|     4|
|b_203       |    20|     3|    19|     3|     5|    12|     9|     6|     2|    14|     9|     5|     8|    18|    22|     1|    14|    17|     3|     1|     3|    13|    19|    11|    15|    14|
|b_204       |    21|    16|    16|    14|     9|    22|    10|     7|    16|     1|     5|    17|    19|     8|    11|     6|    20|    11|    17|     7|     2|    11|     5|    15|     6|    16|
|b_205       |    17|     7|    10|    10|     1|     8|    12|    17|     4|    13|    12|     1|    13|     5|    15|     8|     8|    19|     2|    10|    20|    12|     3|     8|    18|    20|
|b_206       |    19|    11|     6|     6|     8|    17|     5|    14|    19|    18|    14|     4|    16|    14|    12|    18|     5|    18|    10|     8|    11|    22|    20|    16|     1|     8|
|b_207       |     5|     1|     8|    22|    21|    18|    17|    12|    12|     8|     8|    14|    17|     4|    20|    19|    19|    13|     4|    20|     4|    17|     2|     1|     3|     7|
|b_208       |     8|     9|    20|    12|     7|    13|    14|     8|     5|     4|     7|    16|     3|     3|    17|    10|    11|    14|     9|    16|    21|    18|    18|     6|    11|     1|
|b_209       |     3|     8|    13|     5|    19|    16|    22|     5|    14|    16|     3|    22|     6|    15|     6|    12|    12|     1|    12|    22|    12|    19|     6|    20|    22|    12|
|b_210       |    13|     5|     4|    13|    13|     7|    13|    22|     8|     5|     4|     7|     1|    19|    21|     3|    13|     3|     5|    14|    14|     4|    21|    13|    10|     6|
|b_211       |    15|    15|     5|    15|    22|     6|     2|    13|     7|     7|    20|     3|    21|     1|    18|    20|    15|     6|    22|     3|     8|    14|    14|     9|    21|    19|
|b_212       |    12|    12|    12|     8|    10|     5|    16|    11|     6|     6|    16|    11|    22|    16|    13|     5|     6|     4|    16|     2|    10|    15|     8|     2|     8|    22|
|b_213       |     2|    10|    18|    18|     3|    19|    20|     4|    18|     3|    21|     8|     9|     6|     7|    11|     1|     7|     7|    15|     1|    21|     1|    19|     9|    21|
|b_214       |    18|    18|    17|     7|    12|    21|     1|    20|     1|    12|    17|     6|    18|    10|     5|    14|    18|    22|    13|    12|    18|     6|    13|    10|     2|    10|
|b_215       |    22|    19|     1|     4|     4|    20|    18|    21|    22|    17|    22|    13|    14|    22|     1|    16|     3|     2|    18|     5|    13|     1|    15|    17|     4|     9|
|b_216       |    11|    20|     9|    16|    16|     9|    19|    10|    20|     9|    10|    10|     5|    12|    14|     7|    17|    20|    19|    13|    16|    20|     4|     4|     7|    13|
|b_217       |     4|    17|    21|     1|    17|    10|    11|     3|    11|    21|    18|    21|     7|     7|     4|    15|    21|     9|    20|    17|     6|     9|    22|     3|    19|    15|
|b_218       |    10|     2|     2|    11|    14|     4|    15|     1|     3|    20|     6|     2|    12|    11|     9|    13|     2|    15|    14|     9|    15|     3|     9|    18|    12|    17|
|b_219       |     1|    13|     3|    17|    11|    11|     6|    16|    10|    11|    19|     9|    20|    20|    16|     2|     9|    21|    21|    18|    22|     2|    10|     5|    14|     5|
|b_220       |    14|    14|     7|    19|    15|     3|     7|    19|    15|    15|    13|    12|    15|    13|     2|     9|    16|    12|    15|    21|     5|    16|    12|     7|    13|     2|
|b_221       |     6|    22|    11|    20|    18|     1|     4|    18|    21|     2|     1|    15|    11|    17|    10|    21|    10|     8|     6|     6|    17|    10|    16|    14|    20|    11|
|b_222       |     9|     6|    14|    21|     6|    14|    21|    15|    17|    19|     2|    19|     4|     2|    19|    22|     7|    16|     8|    11|    19|     7|    11|    12|    16|     3|

# Select


```
$s.prefs
      o_401 o_402 o_403 o_404 o_405 o_406 o_407 o_408 o_409 o_410 o_411 o_412 o_413 o_414 o_415
b_201    16     4    22     9     2    15     8     9     9    10    11    20    10    21     8
b_202     7    21    15     2    20     2     3     2    13    22    15    18     2     9     3
b_203    20     3    19     3     5    12     9     6     2    14     9     5     8    18    22
b_204    21    16    16    14     9    22    10     7    16     1     5    17    19     8    11
b_205    17     7    10    10     1     8    12    17     4    13    12     1    13     5    15
b_206    19    11     6     6     8    17     5    14    19    18    14     4    16    14    12
b_207     5     1     8    22    21    18    17    12    12     8     8    14    17     4    20
b_208     8     9    20    12     7    13    14     8     5     4     7    16     3     3    17
b_209     3     8    13     5    19    16    22     5    14    16     3    22     6    15     6
b_210    13     5     4    13    13     7    13    22     8     5     4     7     1    19    21
b_211    15    15     5    15    22     6     2    13     7     7    20     3    21     1    18
b_212    12    12    12     8    10     5    16    11     6     6    16    11    22    16    13
b_213     2    10    18    18     3    19    20     4    18     3    21     8     9     6     7
b_214    18    18    17     7    12    21     1    20     1    12    17     6    18    10     5
b_215    22    19     1     4     4    20    18    21    22    17    22    13    14    22     1
b_216    11    20     9    16    16     9    19    10    20     9    10    10     5    12    14
b_217     4    17    21     1    17    10    11     3    11    21    18    21     7     7     4
b_218    10     2     2    11    14     4    15     1     3    20     6     2    12    11     9
b_219     1    13     3    17    11    11     6    16    10    11    19     9    20    20    16
b_220    14    14     7    19    15     3     7    19    15    15    13    12    15    13     2
b_221     6    22    11    20    18     1     4    18    21     2     1    15    11    17    10
b_222     9     6    14    21     6    14    21    15    17    19     2    19     4     2    19
      o_416 o_417 o_418 o_419 o_420 o_421 o_422 o_423 o_424 o_425 o_426
b_201     4    22     5     1    19     9     8     7    21     5    18
b_202    17     4    10    11     4     7     5    17    22    17     4
b_203     1    14    17     3     1     3    13    19    11    15    14
b_204     6    20    11    17     7     2    11     5    15     6    16
b_205     8     8    19     2    10    20    12     3     8    18    20
b_206    18     5    18    10     8    11    22    20    16     1     8
b_207    19    19    13     4    20     4    17     2     1     3     7
b_208    10    11    14     9    16    21    18    18     6    11     1
b_209    12    12     1    12    22    12    19     6    20    22    12
b_210     3    13     3     5    14    14     4    21    13    10     6
b_211    20    15     6    22     3     8    14    14     9    21    19
b_212     5     6     4    16     2    10    15     8     2     8    22
b_213    11     1     7     7    15     1    21     1    19     9    21
b_214    14    18    22    13    12    18     6    13    10     2    10
b_215    16     3     2    18     5    13     1    15    17     4     9
b_216     7    17    20    19    13    16    20     4     4     7    13
b_217    15    21     9    20    17     6     9    22     3    19    15
b_218    13     2    15    14     9    15     3     9    18    12    17
b_219     2     9    21    21    18    22     2    10     5    14     5
b_220     9    16    12    15    21     5    16    12     7    13     2
b_221    21    10     8     6     6    17    10    16    14    20    11
b_222    22     7    16     8    11    19     7    11    12    16     3

$c.prefs
      b_201 b_202 b_203 b_204 b_205 b_206 b_207 b_208 b_209 b_210 b_211 b_212 b_213 b_214 b_215
o_401    25     2     3    20     2     2    16    16     8    23    10     3    26    10    25
o_402    13     9    12    10    17    10    22    15    12     1     6    13     4    14    21
o_403     6    23    13    16    10    23    14    26    10     3    20    17    20    21     6
o_404    16    12     5     2    13     6     6     8     5    15    16    19    13    16     8
o_405     1     1     6    24    14     8    21    12     1    20     5     2    21    23     3
o_406     7     5    14    21     5    16     1    18     9    22     3    15    15    25     4
o_407    19    20    20     8    19     4    13     9     4    25    15    20     5     2    18
o_408    14    16    17    22     6    18    19    14    20     9     4     5    11     3    13
o_409     2    11    21    26     9    17    20     3     3    18    14    22     6    19    12
o_410     5    10    25    25    11     1    26     5    16     8     7     8    22    18    14
o_411     8    25     2    18    24    22     9     2    21    13     1    12     7    17     5
o_412    20     8    18     4    21     3    25    13    26    12     8    10     9     7    16
o_413    18    17    19    15    12    13    10     6    19    11    17    21    19     6    10
o_414    22    21     4    13    26    24    12     4    13    16    18    16    14     9    17
o_415    12    14    16     5    16    19    17    22    14     2    22     1    16     1    20
o_416    23    15    24     1     1    26     8    21    23     5     2    14    23     4     1
o_417     4    24    11    17     4     9    24     7     7    21    19    25    18    11     7
o_418    26     6    15    12    22    21     2    11     6    10    12    11    24    20    15
o_419    10     4    10     6    25     7    15    23    17     6    26     7    17    13     2
o_420    17    19    26    23    18    15    11    10     2     7    24    24     2    22    26
o_421     9    18     7    11    15    14     5    20    15    19    21    18     3     8    23
o_422    11    22    23     7    20    20     4    25    22     4    11    23    10     5    19
o_423     3    13     9    19     8    12     7    24    25    17    23     6    12    12     9
o_424    15     7     1     3    23    25     3    17    11    24    25     9     1    24    22
o_425    24     3    22    14     7     5    18     1    18    14     9     4    25    15    24
o_426    21    26     8     9     3    11    23    19    24    26    13    26     8    26    11
      b_216 b_217 b_218 b_219 b_220 b_221 b_222
o_401     4     1     8     4     9    24    17
o_402    11     3    15    20     8    17    14
o_403     6     7    23    26    13     5     9
o_404     3     9    16    19    20    16    22
o_405    15    12    11    11    18     6     4
o_406    18     4    19    16     6     3    19
o_407    12    16    13    18    24    22     3
o_408    24    14    20    24     3    26     5
o_409    20    24    18     9    19     7     8
o_410    26    20     7     5     1    12    12
o_411     7    10     5     7    23    23    15
o_412     9     8    17     2    11    21     2
o_413     1    26     3     6    26     9    25
o_414    22    21     6    22    14    11    11
o_415     8    18     1     8     5     8     7
o_416     5     5    22    10    17     2     6
o_417    19    17     4    25    25    19    23
o_418    23    22    25     3    22     4    21
o_419    14    11    24    23    12    25    16
o_420    16    15    14    14    10    20    24
o_421    25     6    12    12    21    18     1
o_422     2    25    26    13     4    10    20
o_423    13    19    21    15     7     1    26
o_424    10    23     9     1     2    13    10
o_425    21     2    10    17    16    15    13
o_426    17    13     2    21    15    14    18

$iterations
[1] 6

$matches
$matches[[1]]
[1] 19  0

$matches[[2]]
numeric(0)

$matches[[3]]
[1] 7 0

$matches[[4]]
[1]  2 16

$matches[[5]]
[1] 18 25 22

$matches[[6]]
numeric(0)

$matches[[7]]
[1] 23 21

$matches[[8]]
[1] 15

$matches[[9]]
[1] 4 8 9

$matches[[10]]
[1] 13

$matches[[11]]
[1] 11

$matches[[12]]
[1] 0

$matches[[13]]
[1] 0 0

$matches[[14]]
numeric(0)

$matches[[15]]
[1] 6 0 0

$matches[[16]]
[1]  1 26  0  0  0  0

$matches[[17]]
[1] 0 0

$matches[[18]]
[1] 14 12

$matches[[19]]
[1] 20

$matches[[20]]
[1] 5

$matches[[21]]
[1] 24

$matches[[22]]
[1]  3 17 10


$match.mat
       [,1]  [,2]  [,3]  [,4]  [,5]  [,6]  [,7]  [,8]  [,9] [,10] [,11] [,12] [,13] [,14] [,15]
 [1,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
 [2,] FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
 [3,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
 [4,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE
 [5,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
 [6,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE
 [7,] FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
 [8,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE
 [9,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE
[10,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[11,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE
[12,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[13,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE
[14,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[15,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[16,] FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[17,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[18,] FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[19,]  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[20,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[21,] FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[22,] FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[23,] FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[24,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[25,] FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[26,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
      [,16] [,17] [,18] [,19] [,20] [,21] [,22]
 [1,]  TRUE FALSE FALSE FALSE FALSE FALSE FALSE
 [2,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE
 [3,] FALSE FALSE FALSE FALSE FALSE FALSE  TRUE
 [4,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE
 [5,] FALSE FALSE FALSE FALSE  TRUE FALSE FALSE
 [6,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE
 [7,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE
 [8,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE
 [9,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[10,] FALSE FALSE FALSE FALSE FALSE FALSE  TRUE
[11,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[12,] FALSE FALSE  TRUE FALSE FALSE FALSE FALSE
[13,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[14,] FALSE FALSE  TRUE FALSE FALSE FALSE FALSE
[15,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[16,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[17,] FALSE FALSE FALSE FALSE FALSE FALSE  TRUE
[18,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[19,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[20,] FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
[21,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[22,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[23,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[24,] FALSE FALSE FALSE FALSE FALSE  TRUE FALSE
[25,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[26,]  TRUE FALSE FALSE FALSE FALSE FALSE FALSE

$singles
integer(0)

$edgelist
   colleges students
1         1       19
2         1        0
3         3        7
4         3        0
5         4        2
6         4       16
7         5       18
8         5       25
9         5       22
10        7       23
11        7       21
12        8       15
13        9        4
14        9        8
15        9        9
16       10       13
17       11       11
18       12        0
19       13        0
20       13        0
21       15        6
22       15        0
23       15        0
24       16        1
25       16       26
26       16        0
27       16        0
28       16        0
29       16        0
30       17        0
31       17        0
32       18       14
33       18       12
34       19       20
35       20        5
36       21       24
37       22        3
38       22       17
39       22       10
```

         o_401   o_402   o_403   o_404   o_405   o_406   o_407   o_408   o_409   o_410   o_411   o_412   o_413   o_414   o_415   o_416   o_417   o_418   o_419   o_420   o_421   o_422   o_423   o_424   o_425   o_426
------  ------  ------  ------  ------  ------  ------  ------  ------  ------  ------  ------  ------  ------  ------  ------  ------  ------  ------  ------  ------  ------  ------  ------  ------  ------  ------
b_201       16       4      22       9       2      15       8       9       9      10      11      20      10      21       8       4      22       5       1      19       9       8       7      21       5      18
b_202        7      21      15       2      20       2       3       2      13      22      15      18       2       9       3      17       4      10      11       4       7       5      17      22      17       4
b_203       20       3      19       3       5      12       9       6       2      14       9       5       8      18      22       1      14      17       3       1       3      13      19      11      15      14
b_204       21      16      16      14       9      22      10       7      16       1       5      17      19       8      11       6      20      11      17       7       2      11       5      15       6      16
b_205       17       7      10      10       1       8      12      17       4      13      12       1      13       5      15       8       8      19       2      10      20      12       3       8      18      20
b_206       19      11       6       6       8      17       5      14      19      18      14       4      16      14      12      18       5      18      10       8      11      22      20      16       1       8
b_207        5       1       8      22      21      18      17      12      12       8       8      14      17       4      20      19      19      13       4      20       4      17       2       1       3       7
b_208        8       9      20      12       7      13      14       8       5       4       7      16       3       3      17      10      11      14       9      16      21      18      18       6      11       1
b_209        3       8      13       5      19      16      22       5      14      16       3      22       6      15       6      12      12       1      12      22      12      19       6      20      22      12
b_210       13       5       4      13      13       7      13      22       8       5       4       7       1      19      21       3      13       3       5      14      14       4      21      13      10       6
b_211       15      15       5      15      22       6       2      13       7       7      20       3      21       1      18      20      15       6      22       3       8      14      14       9      21      19
b_212       12      12      12       8      10       5      16      11       6       6      16      11      22      16      13       5       6       4      16       2      10      15       8       2       8      22
b_213        2      10      18      18       3      19      20       4      18       3      21       8       9       6       7      11       1       7       7      15       1      21       1      19       9      21
b_214       18      18      17       7      12      21       1      20       1      12      17       6      18      10       5      14      18      22      13      12      18       6      13      10       2      10
b_215       22      19       1       4       4      20      18      21      22      17      22      13      14      22       1      16       3       2      18       5      13       1      15      17       4       9
b_216       11      20       9      16      16       9      19      10      20       9      10      10       5      12      14       7      17      20      19      13      16      20       4       4       7      13
b_217        4      17      21       1      17      10      11       3      11      21      18      21       7       7       4      15      21       9      20      17       6       9      22       3      19      15
b_218       10       2       2      11      14       4      15       1       3      20       6       2      12      11       9      13       2      15      14       9      15       3       9      18      12      17
b_219        1      13       3      17      11      11       6      16      10      11      19       9      20      20      16       2       9      21      21      18      22       2      10       5      14       5
b_220       14      14       7      19      15       3       7      19      15      15      13      12      15      13       2       9      16      12      15      21       5      16      12       7      13       2
b_221        6      22      11      20      18       1       4      18      21       2       1      15      11      17      10      21      10       8       6       6      17      10      16      14      20      11
b_222        9       6      14      21       6      14      21      15      17      19       2      19       4       2      19      22       7      16       8      11      19       7      11      12      16       3

# Join

 hospital<br/>index   officer<br/>index   hospital<br/>id  hospital<br/>name    billet<br/>count<br/>max   officer<br/>id  office<br/>name<br/>last    preference<br/>of<br/>hospital   preference<br/>of<br/>officer
-------------------  ------------------  ----------------  ------------------  -------------------------  ---------------  -------------------------  -------------------------------  ------------------------------
                 16                   1               216  NMCP                                        6              401  Abraham                                                  4                              11
                 16                  26               216  NMCP                                        6              426  Zimmer                                                  17                              13
                  5                  18               205  NHCL                                        3              418  Rampling                                                22                              19
                  5                  22               205  NHCL                                        3              422  Vaughan                                                 20                              12
                  5                  25               205  NHCL                                        3              425  Young                                                    7                              18
                  9                   4               209  NHCP                                        3              404  Davidson                                                 5                               5
                  9                   8               209  NHCP                                        3              408  Harris                                                  20                               5
                  9                   9               209  NHCP                                        3              409  Ince                                                     3                              14
                 15                   6               215  NH Napl                                     3              406  Forsyth                                                  4                              20
                 22                   3               222  NH Yoko                                     3              403  Carr                                                     9                              14
                 22                  10               222  NH Yoko                                     3              410  Jones                                                   12                              19
                 22                  17               222  NH Yoko                                     3              417  Quinn                                                   23                               7
                  1                  19               201  NH Guam                                     2              419  Sutherland                                              10                               1
                  3                   7               203  Lejeune MEU                                 2              407  Glover                                                  20                               9
                  4                   2               204  Lejeune MLG                                 2              402  Bailey                                                  10                              16
                  4                  16               204  Lejeune MLG                                 2              416  Paige                                                    1                               6
                  7                  21               207  Oki MLG                                     2              421  Underwood                                                5                               4
                  7                  23               207  Oki MLG                                     2              423  Walker                                                   7                               2
                 18                  12               218  NMCSD                                       2              412  Lambert                                                 17                               2
                 18                  14               218  NMCSD                                       2              414  Nash                                                     6                              11
                  8                  15               208  Oki MEU                                     1              415  Oliver                                                  22                              17
                 10                  13               210  Ft Belv                                     1              413  Murray                                                  11                               1
                 11                  11               211  Guant                                       1              411  Knox                                                     1                              20
                 19                  20               219  NH Sig                                      1              420  Taylor                                                  14                              18
                 20                   5               220  NHTP                                        1              405  Ellison                                                 18                              15
                 21                  24               221  WHMP                                        1              424  Xiong                                                   13                              14


# Session Information
For the sake of documentation and reproducibility, the current report was rendered on a system using the following software.


```
Report rendered by Will at 2016-05-31, 17:43 -0500
```

```
R version 3.3.0 Patched (2016-05-05 r70588)
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows >= 8 x64 (build 9200)

locale:
[1] LC_COLLATE=English_United States.1252  LC_CTYPE=English_United States.1252   
[3] LC_MONETARY=English_United States.1252 LC_NUMERIC=C                          
[5] LC_TIME=English_United States.1252    

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] magrittr_1.5 knitr_1.13  

loaded via a namespace (and not attached):
 [1] Rcpp_0.12.5           tidyr_0.4.1           assertthat_0.1        dplyr_0.4.3          
 [5] digest_0.6.9          gmp_0.5-12            R6_2.1.2              DBI_0.4-1            
 [9] formatR_1.4           evaluate_0.9          highr_0.6             stringi_1.1.1        
[13] lazyeval_0.1.10       rmarkdown_0.9.6       partitions_1.9-18     polynom_1.3-8        
[17] tools_3.3.0           stringr_1.0.0         readr_0.2.2           matchingMarkets_0.2-1
[21] parallel_3.3.0        yaml_2.1.13           htmltools_0.3.5       lpSolve_5.6.13       
```
