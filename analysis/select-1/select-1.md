# Selection Demo of US Navy Detailing Marketplace Pilot Program
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




Summary
===========================================

### Background

To increase billet assignment transparency, and to give members and commands more control of the process, 2017 Navy Emergency Medicine Billets will be assigned using a detailing marketplace.  This is a pilot project within the Navy's larger effort to modernize the personnel system.  
  
A list of available billets will be published in the summer of 2016 for physicians to compete for.  At the same time, a list of officers/physicians up for orders will be made available for commands to recruit.  In January, rank lists from officers and commands will be submitted and run through the deferred acceptance algorithm.  The algorithm, used in the National Resident Matching Program, will optimize a match between officer and command.

What follows is a demonstration of the algorithm using theoretical data.

### Notes 
1. The current demonstration covers 62 officers, 20 unique commands, and 54 total possible billets.  In the specialty of emergency medicine, the term "command" and "hospital" can almost be used interchangably.  Almost all commands are located in a single command, and each command/hospital can have multiple billets.
1. The four simulated datasets are viewable and editable [online](https://github.com/OuhscBbmc/usnavy-billets/tree/master/data-phi-free).
    * [roster of the commands](https://github.com/OuhscBbmc/usnavy-billets/blob/master/data-phi-free/raw/command-roster.csv).
    * [roster of the officers](https://github.com/OuhscBbmc/usnavy-billets/blob/master/data-phi-free/raw/officer-roster.csv).
    * [rankings inputted from the commands](https://github.com/OuhscBbmc/usnavy-billets/blob/master/data-phi-free/derived/command.csv).
    * [rankings inputted from the officers](https://github.com/OuhscBbmc/usnavy-billets/blob/master/data-phi-free/derived/officer.csv).
1. Although there can be multiple billets per command, an officer ranks the global command, instead of a specific billet.  Similarly, the command ranks an officer, instead of a billet ranking an officer.  The billet capacity of a command is considered during the matching process.
1. The following survey adequately addresses the current project needs, which involves only a few dozen commands and officers in one specialty.  The survey framework would need to be generalized and scaled out, depending on the additional volume and types of specializations. https://bbmc.ouhsc.edu/redcap/surveys/?s=7XNAFK337W

### Sources
1. This demonstration was developed primarily by [Will Beasley](http://ouhsc.edu/bbmc/team/), Assistant Professor of Research, University of Oklahoma College of Medicine, [Department of Pediatrics](http://www.oumedicine.com/pediatrics).  The code developed for the billet marketplace project is open source and [available online](https://github.com/OuhscBbmc/usnavy-billets).  
1. The project members are appreciative of the open source [`matchingMarkets`](https://cran.r-project.org/package=matchingMarkets) R package, (independently developed by [Thilo Klein](https://github.com/thiloklein) since [2013](https://github.com/thiloklein/matchingMarkets/commits/master)) that implements the Gale-Shapley (1962) Deferred Acceptance Algorithm. For further discussion, see [Roth (2007) Deferred Acceptance Algorithms: History, Theory, Practice, and
Open Questions](https://dash.harvard.edu/bitstream/handle/1/2579651/Roth_Deferred%20Acceptance.pdf) and the [2012 Nobel Prize material](http://www.nobelprize.org/nobel_prizes/economic-sciences/laureates/2012/press.html).
1. The [most recent version](https://rawgit.com/OuhscBbmc/usnavy-billets/master/analysis/select-1/select-1.html) of this demonstration report is available in the [public repository](https://github.com/OuhscBbmc/usnavy-billets).  (An [alternate location](https://github.com/OuhscBbmc/usnavy-billets/blob/master/analysis/select-1/select-1.md) is also available.)

### Unanswered Questions

1. How should the process be adjusted to accommodate issues like (a) recent tours overseas, (b) seniority, and (c) cliques?  Our current plan is to set some a priori points, and approximate it with a transformation.  The transformed rankings are fed into the matching algorithm.
1. How should spousal placement (and other hard restrictions) be handled?  We are currently investigating what will happen if the other (nonacceptable sites) are left blank for the officer, and fed into the matching algorithm.
1. How should 'subjective retirement thresholds' be handled?  For instance, suppose an officer will retire if they don't match to San Diego.  If they're matched somewhere else and retire, how should their assigned billet be filled?  Does the algorithm need to be run another time?  If so, several runs might be required (if other people's thresholds fail on subsequent runs), which is undesirable.
1. How can we adjust the process to match members married to other active duty members (COLOs) or enrolled in the Exceptional Family Member Program (EFMP) who have limited billet-assignment options.  That is, some members will have to be matched to certain billets even if those commands do not rank them highly.
1. How can we adjust the process to allow members to not match?  Specifically, some members have no obligation to stay in the Navy and can elect to get out if they do not get their preferred pick.  How do we allow this without affecting the integrity of the algorithm?
1. How do we incentivize less desirable commands?
1. How do we mitigate the advantage on-board members may have in securing an extension or retour?


### Answered Questions

 1. --

# Raw Rankings

These two tables represent the raw/initial rankings provided from each command (in the first table) and from each officer (in the second table).  No adjustments have been made yet to the rankings.

In the first table (i.e., "Input from Each *Command*"), each row represents a single command's preferences; each column represents a officer being ranked.  In constrast, in the second table (i.e., "Input Provided from Each *Officer*"), each row represents a single officer's preferences; each column represents a hopsital being ranked.


<!-- To walk through an example from the command's perspective, look at the fifth row in the first table.  The values represent how the 20 commands ranked officer ``o_405``.  The first four commands (i.e., ``c_201, c_202, c_203, c_204``) ranked officer ``o_405`` as 9, 9, 6, and 7.

To walk through an example from the officer's perspective, look at the second row in the second table.  The values represent how the 62 officers ranked command ``c_202``.  The first four officers (i.e., ``o_401, o_402, o_403, o_404``) ranked officer ``c_202`` as 8, 6, 4, and 7.-->


### Input Provided from Each Command



| c_201| c_202| c_203| c_204| c_205| c_206| c_207| c_208| c_209| c_210| c_211| c_212| c_213| c_214| c_215| c_216| c_217| c_218| c_219| c_220|
|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|
|     2|    46|    29|    11|    50|    18|    38|     2|    20|     7|    18|     4|    12|    13|    25|    25|    31|    31|    15|    31|
|    12|    11|     1|    13|    22|    36|    18|    25|     8|    14|     2|    10|    29|    11|     1|     9|    32|    19|    35|    29|
|    19|    12|     2|     1|    19|     2|    17|    15|    30|    30|     7|     5|    16|     1|     2|    37|    15|    34|    10|    40|
|    28|    50|     3|     2|     1|    38|    29|     6|    38|    23|    42|    12|    44|     2|     3|    24|    33|    22|    39|    45|
|    22|     1|     4|     3|     2|    29|    30|    10|    27|    33|     1|    50|     1|     3|     4|    19|    17|     1|    45|    32|
|     1|     2|     5|     4|     3|    30|    15|    41|     5|    15|     3|     1|     2|     4|     5|    51|    18|     2|    16|    39|
|     3|     3|     6|     5|     4|     1|     2|    40|     1|    50|     4|    16|     3|     5|     6|    17|     3|     3|    12|    12|
|     4|     4|     7|     6|     5|     3|    26|    31|    24|    16|     5|    42|     4|     6|     7|    26|    34|     4|    31|    10|
|     5|     5|     8|     7|     6|     4|     1|     1|     9|    48|     6|    21|     5|     7|     8|    23|    22|     5|    11|    35|
|     6|     6|     9|     8|     7|     5|     3|    11|    28|     1|     8|     3|     6|     8|     9|     1|    10|     6|    21|    13|
|     7|     7|    10|     9|     8|     6|     4|     3|    44|     2|     9|    43|     7|     9|    10|     2|    41|     7|    34|    34|
|     8|     8|    11|    10|     9|     7|     5|     4|    17|     3|    10|     2|     8|    10|    11|     3|    40|     8|     1|    41|
|     9|     9|    12|    12|    10|     8|     6|     5|    21|     4|    11|     6|     9|    12|    12|     4|    16|     9|     2|     5|
|    10|    10|    13|    14|    11|     9|     7|     7|     7|     5|    12|     7|    10|    14|    13|     5|    51|    10|     3|    21|
|    11|    13|    14|    15|    12|    10|     8|     8|     2|     6|    13|     8|    11|    15|    14|     6|     1|    11|     4|    11|
|    13|    14|    15|    16|    13|    11|     9|     9|     3|     8|    14|     9|    13|    16|    15|     7|     2|    12|     5|    15|
|    14|    15|    16|    17|    14|    12|    10|    12|     4|     9|    15|    11|    14|    17|    16|     8|     4|    13|     6|     1|
|    15|    16|    17|    18|    15|    13|    11|    13|     6|    10|    16|    13|    15|    18|    17|    10|     5|    14|     7|     2|
|    16|    17|    18|    19|    16|    14|    12|    14|    10|    11|    17|    14|    17|    19|    18|    11|     6|    15|     8|     3|
|    17|    18|    19|    20|    17|    15|    13|    16|    11|    12|    19|    15|    18|    20|    19|    12|     7|    16|     9|     4|
|    18|    19|    20|    21|    18|    16|    14|    17|    12|    13|    20|    17|    19|    21|    20|    13|     8|    17|    13|     6|
|    20|    20|    21|    22|    20|    17|    16|    18|    13|    17|    21|    18|    20|    22|    21|    14|     9|    18|    14|     7|
|    21|    21|    22|    23|    21|    19|    19|    19|    14|    18|    22|    19|    21|    23|    22|    15|    11|    20|    17|     8|
|    23|    22|    23|    24|    23|    20|    20|    20|    15|    19|    23|    20|    22|    24|    23|    16|    12|    21|    18|     9|
|    24|    23|    24|    25|    24|    21|    21|    21|    16|    20|    24|    22|    23|    25|    24|    18|    13|    23|    19|    14|
|    25|    24|    25|    26|    25|    22|    22|    22|    18|    21|    25|    23|    24|    26|    26|    20|    14|    24|    20|    16|
|    26|    25|    26|    27|    26|    23|    23|    23|    19|    22|    26|    24|    25|    27|    27|    21|    19|    25|    22|    17|
|    27|    26|    27|    28|    27|    24|    24|    24|    22|    24|    27|    25|    26|    28|    28|    22|    20|    26|    23|    18|
|    29|    27|    28|    29|    28|    25|    25|    26|    23|    25|    28|    26|    27|    29|    29|    27|    21|    27|    24|    19|
|    30|    28|    30|    30|    29|    26|    27|    27|    25|    26|    29|    27|    28|    30|    30|    28|    23|    28|    25|    20|
|    31|    29|    31|    31|    30|    27|    28|    28|    26|    27|    30|    28|    30|    31|    31|    29|    24|    29|    26|    22|
|    32|    30|    32|    32|    31|    28|    31|    29|    29|    28|    31|    29|    31|    32|    32|    30|    25|    30|    27|    23|
|    33|    31|    33|    33|    32|    31|    32|    30|    31|    29|    32|    30|    32|    33|    33|    31|    26|    32|    28|    24|
|    34|    32|    34|    34|    33|    32|    33|    32|    32|    31|    33|    31|    33|    34|    34|    32|    27|    33|    29|    25|
|    35|    33|    35|    35|    34|    33|    34|    33|    33|    32|    34|    32|    34|    35|    35|    33|    28|    35|    30|    26|
|    36|    34|    36|    36|    35|    34|    35|    34|    34|    34|    35|    33|    35|    36|    36|    34|    29|    36|    32|    27|
|    37|    35|    37|    37|    36|    35|    36|    35|    35|    35|    36|    34|    36|    37|    37|    35|    30|    37|    33|    28|
|    38|    36|    38|    38|    37|    37|    37|    36|    36|    36|    37|    35|    37|    38|    38|    36|    35|    38|    36|    30|
|    39|    37|    39|    39|    38|    39|    39|    37|    37|    37|    38|    36|    38|    39|    39|    38|    36|    39|    37|    33|
|    40|    38|    40|    40|    39|    40|    40|    38|    39|    38|    39|    37|    39|    40|    40|    39|    37|    40|    38|    36|
|    41|    39|    41|    41|    40|    41|    41|    39|    40|    39|    40|    38|    40|    41|    41|    40|    38|    41|    40|    37|
|    42|    40|    42|    42|    41|    42|    42|    42|    41|    40|    41|    39|    41|    42|    42|    41|    39|    42|    41|    38|
|    43|    41|    43|    43|    42|    43|    43|    43|    42|    41|    43|    40|    42|    43|    43|    42|    42|    43|    42|    42|
|    44|    42|    44|    44|    43|    44|    44|    44|    43|    42|    44|    41|    43|    44|    44|    43|    43|    44|    43|    43|
|    45|    43|    45|    45|    44|    45|    45|    45|    45|    43|    45|    44|    45|    45|    45|    44|    44|    45|    44|    44|
|    46|    44|    46|    46|    45|    46|    46|    46|    46|    44|    46|    45|    46|    46|    46|    45|    45|    46|    46|    46|
|    47|    45|    47|    47|    46|    47|    47|    47|    47|    45|    47|    46|    47|    47|    47|    46|    46|    47|    47|    47|
|    48|    47|    48|    48|    47|    48|    48|    48|    48|    46|    48|    47|    48|    48|    48|    47|    47|    48|    48|    48|
|    49|    48|    49|    49|    48|    49|    49|    49|    49|    47|    49|    48|    49|    49|    49|    48|    48|    49|    49|    49|
|    50|    49|    50|    50|    49|    50|    50|    50|    50|    49|    50|    49|    50|    50|    50|    49|    49|    50|    50|    50|
|    51|    51|    51|    51|    51|    51|    51|    51|    51|    51|    51|    51|    51|    51|    51|    50|    50|    51|    51|    51|



### Input Provided from Each Officer



|      | o_401| o_402| o_403| o_404| o_405| o_406| o_407| o_408| o_409| o_410| o_411| o_412| o_413| o_414| o_415| o_416| o_417| o_418| o_419| o_420| o_421| o_422| o_423| o_424| o_425| o_426| o_427| o_428| o_429| o_430| o_431| o_432| o_433| o_434| o_435| o_436| o_437| o_438| o_439| o_440| o_441| o_442| o_443| o_444| o_445| o_446| o_447| o_448| o_449| o_450| o_451|
|:-----|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|
|c_201 |     7|     4|     3|     6|     6|     9|    10|     3|     3|     5|     8|     1|     9|     2|     7|     8|     9|     7|     6|     2|     8|     1|     7|     7|     6|     5|     3|     7|     8|     5|     5|     6|     6|     6|     4|     5|     3|     6|     5|     5|     5|     6|     8|     7|     7|     2|     6|     9|     5|     1|     7|
|c_202 |     8|     6|     4|     7|     7|    10|     5|     4|     4|     6|     6|     2|    10|     3|     8|     9|    10|     8|     7|     3|     9|     6|     8|     8|     7|     6|     4|     8|     9|     6|     6|     7|     7|     7|     5|     6|     4|     8|     6|     6|     6|     7|     9|     8|     8|     1|     7|    10|     6|     3|     8|
|c_203 |     9|     7|     9|     8|     8|    11|     6|     5|     5|     7|     9|    10|     4|     4|     9|    10|    11|     9|     8|     4|    10|     7|     9|     9|     8|     7|     5|     9|     4|     7|     7|     8|     8|     8|     6|     7|     5|     9|     7|     7|     7|     8|    10|     9|     9|     3|     8|    11|     7|    10|     9|
|c_204 |    10|     8|    10|     9|     9|    12|     7|     6|     6|     8|     7|    11|     5|     5|    10|    11|    12|    10|     9|     5|    11|     8|    10|    10|     9|     8|     6|    10|     2|     8|     8|     9|     9|     9|     7|     8|     6|    10|     8|     8|     8|     9|    11|    10|    10|     4|     9|    12|     8|     7|    10|
|c_205 |    11|     9|    11|     5|    10|    13|     4|     7|     7|     9|    10|    12|    11|     6|    11|    12|    13|    11|     5|     6|    12|     4|    11|    11|    10|     9|     7|    11|    10|     9|     9|    10|    10|    10|     8|     9|     7|     7|     9|     9|     9|    10|    12|    11|    11|     5|    10|    13|     9|     2|    11|
|c_206 |    12|     2|    12|     4|    11|    14|     8|     8|     8|    10|    11|    13|    12|     7|    12|    13|     6|     4|    10|     7|    13|     9|    12|    12|    11|    10|     8|     5|    11|    10|    10|    11|    11|    11|     9|    10|     8|     3|    10|    10|    10|    11|    13|    12|    12|     6|    11|    14|    10|    13|    12|
|c_207 |    13|     1|    13|    10|    12|     1|     9|     9|     9|    11|    12|    14|    13|     8|     6|    14|     5|     6|    11|     8|    14|    10|    13|    13|    12|     4|     9|     6|     7|    11|    11|    12|    12|    12|    10|     1|     9|     4|    11|    11|    11|    12|    14|    13|    13|     7|    12|    15|    11|    14|    13|
|c_208 |    14|     3|    14|    11|    13|    15|    11|    10|    10|    12|    13|    15|    14|     9|    13|    15|     7|    12|    12|     9|    15|    11|    14|    14|    13|    11|    10|    12|    12|    12|    12|    13|    13|    13|    11|     2|    10|     5|    12|    12|    12|    13|    15|    14|    14|     8|    13|    16|    12|    15|    14|
|c_209 |     1|    10|     8|     1|     1|     5|     3|     1|     2|     1|    14|    16|    15|    10|    14|     5|     3|    13|     3|    10|     6|    12|     4|     1|     5|    12|     1|     2|    13|     1|    13|    14|     5|    14|    12|     3|     2|     1|    13|    13|    13|     1|     5|     1|     5|     9|     5|     5|     2|    16|     3|
|c_210 |     5|    11|     1|    12|    14|     2|     1|    11|    11|    13|    15|     3|     8|     1|     1|     1|     2|     5|     4|     1|     5|     2|     1|     3|     2|     2|    11|     1|    14|     2|    14|    15|     2|    15|    13|    11|    11|     2|    14|    14|    14|     3|     4|     5|     6|    10|     1|     1|     1|     4|     4|
|c_211 |    15|     5|    15|    13|    15|    16|     2|    12|    12|    14|    16|    17|    16|    11|    15|    16|    14|     2|    13|    11|    16|    13|    15|    15|    14|    13|    12|    13|    15|    13|    15|    16|    14|    16|    14|    12|    12|    11|    15|    15|    15|     4|    16|    15|    15|    11|    14|     8|    13|    17|    15|
|c_212 |     2|    12|     6|     3|     3|     3|    12|     2|    13|     4|     2|     6|     2|    12|    16|     2|    15|    14|    14|    12|     7|    14|     5|     4|    15|    14|     2|     3|    16|    14|    16|    17|    15|    17|    15|    13|    13|    12|    16|    16|    16|     2|     3|     4|    16|    12|     3|    17|     4|    18|     5|
|c_213 |     3|    13|    16|    14|    16|    17|    13|    13|    14|    15|     3|     4|     3|    13|    17|     7|    16|    15|    15|    13|    17|    15|    16|    16|    16|    15|    13|    14|     6|    15|    17|    18|    16|    18|    16|    14|    14|    13|    17|    17|    17|    14|    17|     3|    17|    13|    15|    18|    14|     9|    16|
|c_214 |     4|    14|    17|    15|    17|     8|    14|    14|    15|    16|     1|     5|     1|    14|    18|    17|    17|    16|    16|    14|    18|    16|    17|    17|    17|    16|    14|    15|     5|    16|    18|    19|    17|    19|    17|    15|    15|    14|    18|    18|    18|    15|    18|     2|    18|    14|    16|    19|    15|    12|    17|
|c_215 |    16|    15|    18|    16|    18|     7|    15|    15|    16|    17|    17|    18|    17|    15|     2|    18|    18|    17|    17|    15|    19|    17|    18|    18|     1|    17|    15|    16|    17|    17|    19|    20|    18|    20|    18|    16|    16|    15|    19|    19|    19|     5|    19|    16|    19|    15|    17|     7|    16|    19|    18|
|c_216 |     6|    16|     7|     2|     2|     6|    16|    16|     1|     2|    18|    19|    18|    16|    19|     6|     1|    18|     1|    16|     1|     5|     2|     2|     3|     1|    16|     4|    18|     3|    20|     3|     4|     2|    19|    17|     1|    16|     4|     3|    20|    16|     1|     6|     3|    16|     2|     6|     3|     6|     1|
|c_217 |    17|    17|     5|    17|    19|    18|    17|    17|    17|    18|    19|    20|    19|    17|     3|     4|     8|     3|    18|    17|    20|    18|     6|     6|    18|    18|    17|    17|    19|    18|     1|     2|     3|     5|    20|    18|    17|    17|    20|     4|     4|    17|     7|    17|     4|    17|    18|    20|    17|    20|     6|
|c_218 |    18|    18|     2|    18|    20|     4|    18|    18|    18|    19|    20|     9|    20|    18|    20|     3|     4|     1|     2|    18|     2|     3|     3|     5|     4|     3|    18|    18|    20|     4|     4|     1|     1|     3|     3|     4|    18|    18|     2|    20|     3|    18|     2|    18|    20|    18|     4|     4|    18|     5|     2|
|c_219 |    19|    19|    19|    19|     5|    19|    19|    19|    19|     3|     5|     8|     7|    19|     4|    19|    19|    19|    19|    19|     3|    19|    19|    19|    19|    19|    19|    19|     1|    19|     2|     4|    19|     4|     1|    19|    19|    19|     1|     2|     2|    19|    20|    19|     1|    19|    19|     2|    19|     8|    19|
|c_220 |    20|    20|    20|    20|     4|    20|    20|    20|    20|    20|     4|     7|     6|    20|     5|    20|    20|    20|    20|    20|     4|    20|    20|    20|    20|    20|    20|    20|     3|    20|     3|     5|    20|     1|     2|    20|    20|    20|     3|     1|     1|    20|     6|    20|     2|    20|    20|     3|    20|    11|    20|

Results
===========================================

### Matches

The skinny table below shows the pairs of command--officer matches.  Notice that not all entities were matched.  This is because there were 54 total billets (across 20 unique commands), but 62 officers.  This is only the essential information.  See the following section for a comprehensive table.

| command<br/>index|officer<br/>index |
|-----------------:|:-----------------|
|                 1|12                |
|                 2|3                 |
|                 2|46                |
|                 3|20                |
|                 3|26                |
|                 4|47                |
|                 4|49                |
|                 4|51                |
|                 5|50                |
|                 6|28                |
|                 7|2                 |
|                 7|17                |
|                 8|36                |
|                 9|1                 |
|                 9|5                 |
|                 9|8                 |
|                 9|27                |
|                 9|30                |
|                 9|38                |
|                10|7                 |
|                10|14                |
|                10|23                |
|                10|33                |
|                11|18                |
|                12|4                 |
|                12|6                 |
|                12|16                |
|                12|42                |
|                12|43                |
|                13|44                |
|                14|11                |
|                14|13                |
|                15|25                |
|                16|9                 |
|                16|19                |
|                16|24                |
|                16|37                |
|                17|15                |
|                17|31                |
|                17|32                |
|                18|22                |
|                19|10                |
|                19|21                |
|                19|29                |
|                19|35                |
|                19|39                |
|                19|45                |
|                20|34                |
|                20|40                |
|                20|41                |
|                20|48                |

### Display

The final table shows the indices of only the successful matches, along with the following information:

* the hopsital ID and name (`command id` and `command name`), 
* the maximum number of billets for a command (`billet count max`),
* the officer ID and name  (`officer id` and `officer name last`), 
* the preference expressed from the command for the officer (`preference from command`)
* the preference expressed from the officer for the command (`preference from officer`)

In this demonstration, notice that not all commands filled every billet.


| command<br/>index| officer<br/>index|command<br/>id |command<br/>name | billet<br/>count<br/>max|officer<br/>id |officer<br/>tag |officer<br/>name<br/>last | preference<br/>from<br/>command| preference<br/>from<br/>officer|
|-----------------:|-----------------:|:--------------|:----------------|------------------------:|:--------------|:---------------|:-------------------------|-------------------------------:|-------------------------------:|
|                 9|                 1|c_209          |NMCP             |                        6|o_401          |xvxe            |Abraham                   |                               7|                               1|
|                 9|                 5|c_209          |NMCP             |                        6|o_405          |87cl            |Ellison                   |                               6|                               1|
|                 9|                 8|c_209          |NMCP             |                        6|o_408          |as5q            |Harris                    |                               2|                               1|
|                 9|                27|c_209          |NMCP             |                        6|o_427          |9je3            |Aikman                    |                               5|                               1|
|                 9|                30|c_209          |NMCP             |                        6|o_430          |zkff            |Dulles                    |                               3|                               1|
|                 9|                38|c_209          |NMCP             |                        6|o_438          |tun2            |Laurence                  |                               4|                               1|
|                19|                10|c_219          |1st MLG          |                        6|o_410          |5t8r            |Jones                     |                               3|                               3|
|                19|                21|c_219          |1st MLG          |                        6|o_421          |zaif            |Underwood                 |                              10|                               3|
|                19|                29|c_219          |1st MLG          |                        6|o_429          |85i6            |Coolie                    |                              34|                               1|
|                19|                35|c_219          |1st MLG          |                        6|o_435          |cbku            |Instance                  |                               2|                               1|
|                19|                39|c_219          |1st MLG          |                        6|o_439          |ob7u            |Michaels                  |                               4|                               1|
|                19|                45|c_219          |1st MLG          |                        6|o_445          |fg86            |Sherman                   |                               5|                               1|
|                12|                 4|c_212          |NHCL             |                        5|o_404          |pd7n            |Davidson                  |                               1|                               3|
|                12|                 6|c_212          |NHCL             |                        5|o_406          |m8w6            |Forsyth                   |                              13|                               3|
|                12|                16|c_212          |NHCL             |                        5|o_416          |1qhj            |Paige                     |                               7|                               2|
|                12|                42|c_212          |NHCL             |                        5|o_442          |bqrp            |Power                     |                               8|                               2|
|                12|                43|c_212          |NHCL             |                        5|o_443          |yocg            |Quincy                    |                              11|                               3|
|                 4|                47|c_204          |3rd MLG          |                        4|o_447          |goed            |Unger                     |                              47|                               9|
|                 4|                49|c_204          |3rd MLG          |                        4|o_449          |lptr            |Wilson                    |                              49|                               8|
|                 4|                51|c_204          |3rd MLG          |                        4|o_451          |fjh2            |Yu                        |                              51|                              10|
|                10|                 7|c_210          |Jax              |                        4|o_407          |wnaf            |Glover                    |                               1|                               1|
|                10|                14|c_210          |Jax              |                        4|o_414          |k1lv            |Nash                      |                               2|                               1|
|                10|                23|c_210          |Jax              |                        4|o_423          |vqdq            |Walker                    |                               4|                               1|
|                10|                33|c_210          |Jax              |                        4|o_433          |6zmz            |Grind                     |                               5|                               2|
|                16|                 9|c_216          |NMCSD            |                        4|o_409          |pb8x            |Ince                      |                               2|                               1|
|                16|                19|c_216          |NMCSD            |                        4|o_419          |pt9y            |Sutherland                |                               5|                               1|
|                16|                24|c_216          |NMCSD            |                        4|o_424          |d6hs            |Xiong                     |                               4|                               2|
|                16|                37|c_216          |NMCSD            |                        4|o_437          |ojoz            |Kippler                   |                               3|                               1|
|                20|                34|c_220          |1st MEU          |                        4|o_434          |525l            |Hyer                      |                              11|                               1|
|                20|                40|c_220          |1st MEU          |                        4|o_440          |27vk            |Never                     |                               3|                               1|
|                20|                41|c_220          |1st MEU          |                        4|o_441          |ovvy            |Object                    |                              12|                               1|
|                20|                48|c_220          |1st MEU          |                        4|o_448          |nkql            |Vince                     |                              48|                               3|
|                17|                15|c_217          |NH 29P           |                        3|o_415          |cn7q            |Oliver                    |                               3|                               3|
|                17|                31|c_217          |NH 29P           |                        3|o_431          |6ust            |Estes                     |                               1|                               1|
|                17|                32|c_217          |NH 29P           |                        3|o_432          |785o            |Flag                      |                               2|                               2|
|                 2|                 3|c_202          |NH Oki           |                        2|o_403          |x0qi            |Carr                      |                               7|                               4|
|                 2|                46|c_202          |NH Oki           |                        2|o_446          |wfv3            |Tut                       |                               1|                               1|
|                 3|                20|c_203          |Oki MEU          |                        2|o_420          |paed            |Taylor                    |                              21|                               4|
|                 3|                26|c_203          |Oki MEU          |                        2|o_426          |d2nz            |Zimmer                    |                              27|                               7|
|                 5|                50|c_205          |NH Yoko          |                        2|o_450          |2w56            |Xiang                     |                               1|                               2|
|                 7|                 2|c_207          |Napl             |                        2|o_402          |kobl            |Bailey                    |                               7|                               1|
|                 7|                17|c_207          |Napl             |                        2|o_417          |s9l6            |Quinn                     |                               3|                               5|
|                13|                44|c_213          |2nd MLG          |                        2|o_444          |yk8a            |Rolls                     |                               4|                               3|
|                14|                11|c_214          |2nd MEU          |                        2|o_411          |2tb7            |Knox                      |                               2|                               1|
|                14|                13|c_214          |2nd MEU          |                        2|o_413          |5sjg            |Murray                    |                               1|                               1|
|                 1|                12|c_201          |Guam             |                        1|o_412          |9aa1            |Lambert                   |                               2|                               1|
|                 6|                28|c_206          |Rota             |                        1|o_428          |vzno            |Bell                      |                              32|                               5|
|                 8|                36|c_208          |Sig              |                        1|o_436          |0cot            |Jack                      |                              38|                               2|
|                11|                18|c_211          |Gitmo            |                        1|o_418          |bakn            |Rampling                  |                               1|                               2|
|                15|                25|c_215          |CBIRF            |                        1|o_425          |tb5t            |Young                     |                               1|                               1|
|                18|                22|c_218          |NH Pend          |                        1|o_422          |h8pg            |Vaughan                   |                               4|                               3|
|                NA|                52|c_ NA          |NA               |                       NA|o_452          |lsg3            |Zack                      |                              NA|                              NA|
|                NA|                53|c_ NA          |NA               |                       NA|o_453          |lgds            |Ades                      |                              NA|                              NA|
|                NA|                54|c_ NA          |NA               |                       NA|o_454          |jp1a            |Byron                     |                              NA|                              NA|
|                NA|                55|c_ NA          |NA               |                       NA|o_455          |zs4z            |Colgate                   |                              NA|                              NA|
|                NA|                56|c_ NA          |NA               |                       NA|o_456          |0izt            |Dyer                      |                              NA|                              NA|
|                NA|                57|c_ NA          |NA               |                       NA|o_457          |7-Jun           |Easton                    |                              NA|                              NA|
|                NA|                58|c_ NA          |NA               |                       NA|o_458          |jmhn            |Fox                       |                              NA|                              NA|
|                NA|                59|c_ NA          |NA               |                       NA|o_459          |zpzj            |Gauge                     |                              NA|                              NA|
|                NA|                60|c_ NA          |NA               |                       NA|o_460          |q5lj            |Hastings                  |                              NA|                              NA|
|                NA|                61|c_ NA          |NA               |                       NA|o_461          |rzj1            |Ides                      |                              NA|                              NA|
|                NA|                62|c_ NA          |NA               |                       NA|o_462          |hw3p            |James                     |                              NA|                              NA|


### Desirability

Finally, the desirability of the the entities can be represented several ways.  Perhaps the simplest is plotting how each entity  ranked each other.  In the first graph, each column represents the rankings received by an officer; the diamond represents the officer's mean rank.  If all commands believed the officer was the best fit for them, all 20 blue dots (as well as the diamond) would be at $y$=1.  The second graph is similar, but reflects the desirability of each command, from the officer's perspective.  These blue points are distributed more evenly than in the real world, because the preference data was (simply) generated.

![](figure-png/graph-desirability-1.png)<!-- -->![](figure-png/graph-desirability-2.png)<!-- -->


Session Information
===========================================
We would like to address any questions or suggestions during any stage of the evaluation. Please contact [Richard C. Childers](mailto:richard.childers@navy.mil), CDR NPC, PERS-4415.

For the sake of documentation and reproducibility, the current report was rendered on a system using the following software.


```
Report rendered by wbeasley at 2016-12-22, 10:39 -0600
```

```
R version 3.3.2 Patched (2016-11-07 r71639)
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows 7 x64 (build 7601) Service Pack 1

locale:
[1] LC_COLLATE=English_United States.1252  LC_CTYPE=English_United States.1252   
[3] LC_MONETARY=English_United States.1252 LC_NUMERIC=C                          
[5] LC_TIME=English_United States.1252    

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] ggplot2_2.2.0 magrittr_1.5  knitr_1.15.1 

loaded via a namespace (and not attached):
 [1] Rcpp_0.12.8           partitions_1.9-18     munsell_0.4.3         colorspace_1.3-2     
 [5] R6_2.2.0              highr_0.6             dplyr_0.5.0.9000      stringr_1.1.0        
 [9] plyr_1.8.4            tools_3.3.2           grid_3.3.2            gtable_0.2.0         
[13] DBI_0.5-1             htmltools_0.3.5       matchingMarkets_0.3-2 yaml_2.1.14          
[17] lazyeval_0.2.0        rprojroot_1.1         digest_0.6.10         assertthat_0.1       
[21] tibble_1.2            gmp_0.5-12            rJava_0.9-8           tidyr_0.6.0          
[25] readr_1.0.0           evaluate_0.10         rmarkdown_1.3         labeling_0.3         
[29] stringi_1.1.2         scales_0.4.1          backports_1.0.4       polynom_1.3-9        
```
