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

To walk through an example from the command's perspective, look at the fifth row in the first table.  The values represent how command ``c_205`` ranked the 62 officers.  The command's initial four officers (i.e., ``o_401, o_402, o_403, o_404``) were ranked 19, 30,  8, and 39.

To walk through an example from the officer's perspective, look at the second row in the second table.    The values represent how officer ``o_402`` ranked the 20 commands.  The officer's initial three commands (i.e., ``c_201, c_202, c_203``) were ranked 10,  4, and  1.

<!-- To walk through an example from the command's perspective, look at the fifth row in the first table.  The values represent how the 20 commands ranked officer ``o_405``.  The first four commands (i.e., ``c_201, c_202, c_203, c_204``) ranked officer ``o_405`` as 34, 38, 24, and 44.

To walk through an example from the officer's perspective, look at the second row in the second table.  The values represent how the 62 officers ranked command ``c_202``.  The first four officers (i.e., ``o_401, o_402, o_403, o_404``) ranked officer ``c_202`` as 15, 4, 7, and 2.-->


### Input Provided from Each Command



| command_id| o_401| o_402| o_403| o_404| o_405| o_406| o_407| o_408| o_409| o_410| o_411| o_412| o_413| o_414| o_415| o_416| o_417| o_418| o_419| o_420| o_421| o_422| o_423| o_424| o_425| o_426| o_427| o_428| o_429| o_430| o_431| o_432| o_433| o_434| o_435| o_436| o_437| o_438| o_439| o_440| o_441| o_442| o_443| o_444| o_445| o_446| o_447| o_448| o_449| o_450| o_451|
|----------:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|
|      c_201|    35|    27|    41|    13|    34|    22|     4|    45|    30|    25|    48|    32|    20|    14|    47|    17|    44|    10|    46|     9|    36|    18|     1|    49|    24|    19|    29|     8|    11|    26|    38|    39|    21|     5|     6|    37|    51|    31|    43|     7|    15|    28|    50|    42|    40|    23|    12|    16|     3|     2|    33|
|      c_202|     6|    36|    48|    20|    38|     2|    18|    30|    13|    47|    19|     5|    39|    45|     8|     9|    51|     4|    42|    22|    16|    11|    46|     7|    29|    32|    21|    23|    34|    28|     1|    25|    15|    41|    17|    12|    43|    33|    10|    49|    44|    26|    35|    14|    40|     3|    37|    50|    31|    27|    24|
|      c_203|    11|    38|     8|    28|    24|    19|    21|    37|    14|     3|    16|     9|    49|    18|     7|     2|    25|    12|    42|    35|    15|    41|    27|    51|     4|    46|    48|    32|    30|    44|    10|    47|     5|    50|    43|    22|     6|    40|    34|    36|    31|    13|    29|    33|    17|    45|    20|    39|    23|     1|    26|
|      c_204|     1|    30|    40|    14|    44|    51|    37|    50|    26|    21|    42|    34|    16|    35|    27|    49|    47|    31|     5|    45|    18|    33|    25|     7|    32|    11|    39|    10|    38|    43|    41|    15|     2|    29|     4|    48|    23|    36|    17|    19|     6|     3|     8|    46|    22|     9|    12|    28|    13|    24|    20|
|      c_205|    19|    30|     8|    39|     9|    10|    11|    42|    33|    49|    27|    35|    20|    21|     4|    36|     1|    50|     2|    48|    41|    47|    17|    37|    32|     7|    26|    15|    24|    51|    29|    34|    38|    12|    25|    45|    16|    13|     6|    28|    43|    22|     3|    23|    46|    44|    31|    14|    18|    40|     5|
|      c_206|    22|    41|    11|    27|    28|    31|    20|    47|    34|    42|    38|     3|    30|     6|    14|    17|    36|     4|    18|    24|    48|    37|    26|     2|    44|     8|    15|    21|     7|    45|     5|    50|    32|    29|    23|    10|    12|    16|    39|    51|    46|     1|    43|    25|    35|     9|    40|    33|    49|    13|    19|
|      c_207|    46|    39|     2|    13|    40|    28|     8|     5|    42|    47|    32|    41|    17|    49|    14|    20|     1|     4|     9|    15|    48|    22|    38|    36|     3|    12|     6|    30|    11|     7|    43|    24|    31|    23|    26|    34|    25|    29|    18|    51|    44|    45|    10|    19|    50|    33|    37|    35|    21|    16|    27|
|      c_208|    44|    22|     4|    16|    38|    11|    45|    47|     2|    42|     6|    21|    33|    36|    39|    24|    48|     1|    49|    28|    13|    19|    29|     8|    50|    18|    35|    41|     5|    31|    26|    12|    10|    20|     7|    40|    34|    25|    46|    51|    14|    37|    30|     3|    23|    43|    17|     9|    27|    32|    15|
|      c_209|    50|    19|    45|    22|    38|     8|    28|    24|    21|    41|     3|    18|    49|    25|    27|    14|    13|    16|    23|    47|    39|     9|    43|     4|    37|    35|    46|    51|     5|    20|    15|     2|    26|    48|    17|    36|    30|     7|    44|    40|    31|    10|    42|    12|     1|    33|     6|    32|    34|    11|    29|
|      c_210|     5|     7|     9|    40|    37|     6|    41|    44|    13|     8|    34|    12|    35|    10|    39|    11|    33|    43|    42|     2|     1|    47|     4|    45|    32|    36|    16|    46|    31|    48|    27|    19|    28|    15|    18|    21|    49|    38|    22|    29|    24|    26|    50|    30|    25|    51|    17|     3|    23|    20|    14|
|      c_211|    46|    37|     3|    27|    19|    25|    35|     5|    29|    48|    38|    16|    34|    50|     9|    12|    28|    39|     7|     8|    18|    31|    33|    20|    22|    15|    51|     6|    32|    13|    49|    23|     4|    45|    41|    36|    42|    47|    10|    24|     2|    26|     1|    21|    43|    44|    40|    11|    17|    30|    14|
|      c_212|     7|    27|    51|    19|     4|    15|     3|    50|    33|    13|    48|    32|    11|    12|    45|    17|     8|    41|    43|    44|    10|    42|    14|    49|    39|    21|    29|    35|    24|     1|    40|    18|    20|     2|    26|    22|     6|    31|    25|    38|    34|    37|    36|     5|    46|    30|    16|    23|     9|    28|    47|
|      c_213|    46|     6|    48|    27|    20|    36|    13|    21|    34|    11|     1|    50|    38|    41|    31|    29|    15|    30|    28|    37|    22|    32|    49|     2|     8|     7|    45|    43|     9|    24|    44|    12|    39|    25|    40|     5|    10|    16|     4|    14|    23|    35|    26|    18|    51|    17|    19|    47|    33|     3|    42|
|      c_214|    34|    27|    22|     8|    28|    42|     5|    21|     1|    44|    13|    16|    20|    38|     6|    49|    30|    41|    15|     4|    40|    32|    14|    47|    39|     9|    50|     2|     3|    45|    23|    37|    11|     7|    46|    19|    31|    43|    33|    35|    48|    51|    25|    18|    17|    26|    10|    12|    36|    24|    29|
|      c_215|    37|    34|    49|    23|    42|    32|     5|    46|    33|    41|    31|    29|    51|    48|    14|    24|    35|    40|     3|    44|    22|     9|    13|    25|    10|    19|    45|     1|    47|    28|    16|    26|     8|     7|    36|    15|     2|    43|    38|    21|    12|    50|    18|    11|     6|    27|    30|    39|    20|    17|     4|
|      c_216|     9|    16|    11|    12|     4|    17|    51|    24|    32|    42|    13|    34|    49|    36|    43|    37|     8|    10|    23|     6|    46|    27|    41|     1|     5|    39|    21|    48|    45|     7|    20|    19|     3|    35|    28|    30|    47|    22|    31|    14|    26|    40|    29|    33|    38|    50|    18|    44|     2|    15|    25|
|      c_217|    44|    47|    51|     2|     1|    36|     7|    31|     3|    39|    42|    19|    27|    50|    40|    38|    10|    20|    43|     5|    22|    46|    29|    37|    26|     6|    25|    24|    12|     8|    14|    45|    28|    30|     9|    33|     4|    32|    17|    15|    41|    18|    34|    16|    21|    23|    49|    13|    48|    35|    11|
|      c_218|     1|    31|    23|    17|    34|    28|     6|    48|    38|    37|    20|    43|     7|    11|    19|    35|    14|    41|    29|     9|    15|    12|    16|    50|     2|    42|    51|    33|    36|    49|    40|    13|    47|    27|     5|    21|    22|    25|     8|     3|    44|    46|    32|    39|    45|    26|    24|     4|    10|    30|    18|
|      c_219|    37|     5|    42|    23|    18|    12|    26|    10|    28|    41|    48|    43|    22|    47|    15|    35|    24|    50|    20|    16|    19|    45|    27|    29|     2|    39|     3|    51|     8|    30|    33|     7|    14|     4|    25|    46|    38|    17|    31|     9|    21|    11|    36|    32|     1|    40|    44|    13|    34|     6|    49|
|      c_220|    25|    46|     3|    34|    15|    51|    31|    23|     8|    37|    17|     7|    26|    10|    18|    50|     9|    43|     1|     4|    30|    27|     5|    33|    38|    29|    22|    14|    41|    45|    21|    32|    42|    28|    19|    11|    35|     6|    20|    49|    39|    36|    40|    44|    12|    48|    47|    24|    16|    13|     2|



### Input Provided from Each Officer



| officer_id| c_201| c_202| c_203| c_204| c_205| c_206| c_207| c_208| c_209| c_210| c_211| c_212| c_213| c_214| c_215| c_216| c_217| c_218| c_219| c_220|
|----------:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|
|      o_401|     1|    15|     7|     8|     3|    19|     2|     6|    10|    18|    11|    12|     9|     5|     4|    20|    17|    16|    14|    13|
|      o_402|    10|     4|     1|    14|    16|     7|    18|     6|    12|    19|    15|     9|    17|     2|    13|    11|     8|     5|     3|    20|
|      o_403|    14|     7|     6|    10|    19|     5|    18|    16|     2|     1|     8|    20|    15|    12|     9|    17|     3|    11|    13|     4|
|      o_404|     3|     2|    19|    14|    15|     4|    11|    17|     6|    12|     5|     9|    10|    18|     8|     7|    20|    13|    16|     1|
|      o_405|    20|    15|    13|     5|     3|    10|     8|    19|     2|    18|    12|     1|    14|    11|     6|    16|     4|     7|     9|    17|
|      o_406|    11|    15|    12|    16|    17|     3|     6|    18|     1|     2|    10|     4|    14|    19|     5|     9|    20|     8|    13|     7|
|      o_407|     2|    13|    19|    10|    12|     3|     5|    15|    11|    17|    16|     6|    14|     8|     4|     7|     1|     9|    18|    20|
|      o_408|    15|    20|    19|     9|     6|    10|    12|    13|     5|    11|    18|     1|     7|     4|    17|    14|    16|     8|     2|     3|
|      o_409|     3|     8|    12|     7|    10|    17|     4|    13|    11|     6|    14|     1|     9|    19|    20|    15|    18|     2|    16|     5|
|      o_410|    10|     7|    15|     8|     6|     2|     5|    19|    16|     4|    13|     3|    18|    17|    11|    14|    12|    20|     1|     9|
|      o_411|     9|    11|     6|     2|     8|    13|    14|    10|    12|    15|    20|     1|    18|    19|     7|     3|     5|    17|     4|    16|
|      o_412|    19|     8|     5|     1|    10|    12|    20|     4|    16|    14|     2|    11|    18|     7|    17|    13|     6|     3|     9|    15|
|      o_413|    13|    19|     3|    11|     7|     6|     5|    15|    20|    16|    17|    14|     9|     4|    10|     2|    18|     1|    12|     8|
|      o_414|    18|    17|    13|     2|     3|     1|     7|     8|    10|    12|    20|     6|    11|     5|    16|    14|     9|    19|     4|    15|
|      o_415|    12|     4|    18|    15|    16|     7|    10|    19|    17|    20|     8|     5|    13|    11|    14|     6|     2|     3|     1|     9|
|      o_416|    15|    14|    18|    13|    20|     2|    17|    10|     5|     3|     8|    11|     7|    16|    12|     4|     1|     6|     9|    19|
|      o_417|     3|     1|    20|    18|    12|    19|    17|     2|    11|     9|     5|    14|    15|     6|     4|    10|     7|     8|    16|    13|
|      o_418|    11|    19|    16|    14|    17|     2|     6|     4|     1|     8|    20|     9|     7|     5|     3|    13|    18|    10|    12|    15|
|      o_419|     9|    17|    10|    15|    14|    18|    11|    20|     8|    13|     7|     6|    12|    16|     3|     1|     4|     5|     2|    19|
|      o_420|     4|    13|    17|     5|    15|    20|    11|     6|    12|     7|    14|    16|    18|     3|     9|     1|    10|     2|    19|     8|
|      o_421|    18|    19|    20|     6|    13|     7|     8|    17|    14|    15|     9|     5|     1|    16|     4|    12|     3|     2|    11|    10|
|      o_422|    12|     4|     6|    14|     3|     7|    11|     5|    13|    15|     1|     2|     9|     8|    17|    10|    18|    16|    20|    19|
|      o_423|     7|     6|     2|     4|    17|     3|     5|    14|    11|    13|    16|    15|     1|    12|    20|    19|     8|     9|    10|    18|
|      o_424|     1|    10|    15|    17|     6|    19|    20|     7|    13|    18|     2|     9|    12|    11|    16|     5|     8|     4|    14|     3|
|      o_425|    15|     5|     1|     4|     8|     2|    11|    18|    13|    14|    10|     9|    17|    19|    16|     7|     3|     6|    20|    12|
|      o_426|     3|    11|     2|    20|    16|     6|    14|    17|    10|     7|    13|     9|    15|    19|    18|     1|     4|     5|     8|    12|
|      o_427|     5|     1|    11|    13|     3|     9|     2|    18|    10|     6|     8|    15|    19|    12|    17|     4|    14|    16|     7|    20|
|      o_428|     3|     8|    17|    18|    12|     2|     1|     4|    15|     5|    13|     7|    16|    20|    19|     9|     6|    10|    14|    11|
|      o_429|     3|     4|     2|     7|    11|    18|     6|    19|     5|    14|     9|    13|     1|    20|    10|     8|    15|    17|    12|    16|
|      o_430|     3|    20|    10|     8|     9|     6|    16|    14|    18|    13|     1|    12|    15|     2|     4|    19|     7|     5|    11|    17|
|      o_431|    12|     7|    15|     1|     4|    13|    10|     5|     3|     8|     6|    14|    16|    20|     9|    19|    17|    11|    18|     2|
|      o_432|     1|     5|    14|     3|     9|    18|    20|    19|     6|    10|     4|    17|     2|     7|    16|    15|    11|     8|    13|    12|
|      o_433|     9|    11|     1|     3|    16|    19|     6|     4|     2|    12|     8|     5|    10|    18|     7|    13|    14|    20|    15|    17|
|      o_434|    10|     2|    16|    17|    18|     3|    11|    20|     7|    19|     5|    13|    15|    12|    14|     6|     4|     1|     8|     9|
|      o_435|    18|     9|    20|    19|     4|     8|     1|    10|    14|     6|    15|    12|    17|     5|     2|     3|    16|    11|    13|     7|
|      o_436|    12|    15|    14|     9|    19|     2|     7|    13|    20|     3|     4|    10|    17|    18|     5|    16|     1|     8|    11|     6|
|      o_437|     6|     7|     8|    12|    14|    15|     9|     5|    18|    17|     4|    13|    20|     1|    19|     3|    16|    11|    10|     2|
|      o_438|    11|     2|     9|    12|    15|     5|    14|    17|     4|    18|     3|    16|     8|    13|    20|     6|     1|    10|    19|     7|
|      o_439|    10|    15|     4|    12|     1|    19|     3|     8|    16|     5|    11|    14|    20|     9|    17|    13|     2|    18|     7|     6|
|      o_440|    11|     9|     3|    12|     7|    13|    15|     5|    19|    20|    10|     6|    17|    14|     2|     4|     8|     1|    18|    16|
|      o_441|    19|     3|     8|    10|    14|    18|    17|    13|    15|     2|     5|     1|     7|    11|    12|    20|     6|     9|     4|    16|
|      o_442|     1|     5|    12|     4|    18|     9|     6|     3|    10|     8|    14|    17|    13|     2|    16|    20|    15|    11|    19|     7|
|      o_443|     5|    10|    11|    17|    14|    13|     3|     9|    15|    16|     7|     2|     8|    12|     6|     1|    19|    18|     4|    20|
|      o_444|    13|     6|     7|    15|    18|    17|    16|    14|    11|     3|     8|    10|    19|     4|     9|     1|     2|     5|    20|    12|
|      o_445|     2|    14|     6|     7|    11|    13|     5|    20|    18|    17|    16|    12|     1|     9|    15|     8|    10|     3|    19|     4|
|      o_446|    17|    18|     9|     2|    16|    11|     3|     8|    15|    19|     5|    20|     1|    13|     4|     7|    12|    10|     6|    14|
|      o_447|     6|    10|     2|     7|     5|    13|    14|     4|    19|     1|    15|    12|     9|    18|     3|     8|    17|    16|    20|    11|
|      o_448|    13|     8|    11|    17|     3|     7|     6|    15|    20|     1|     2|     9|    12|     4|    10|    16|     5|    18|    19|    14|
|      o_449|    19|    20|     9|     1|     3|    13|    18|    11|    17|    10|     8|    12|     4|     6|     2|    14|     7|     5|    15|    16|
|      o_450|    11|     8|     3|     7|     5|    15|     6|    18|     2|    14|     9|     1|    19|     4|    17|    12|    13|    16|    10|    20|
|      o_451|    12|    13|    10|    20|    19|    16|     8|    18|    14|     4|    15|     1|     9|    17|    11|     3|     2|     6|     5|     7|

Results
===========================================

### Matches

The skinny table below shows the pairs of command--officer matches.  Notice that not all entities were matched.  This is because there were 54 total billets (across 20 unique commands), but 62 officers.  This is only the essential information.  See the following section for a comprehensive table.

| command<br/>index|officer<br/>index |
|-----------------:|:-----------------|
|                 1|25                |
|                 2|45                |
|                 2|47                |
|                 3|14                |
|                 3|28                |
|                 4|2                 |
|                 4|29                |
|                 4|32                |
|                 4|39                |
|                 5|27                |
|                 5|42                |
|                 6|11                |
|                 7|1                 |
|                 7|13                |
|                 8|21                |
|                 9|19                |
|                 9|33                |
|                 9|36                |
|                 9|40                |
|                 9|49                |
|                 9|50                |
|                10|5                 |
|                10|9                 |
|                10|10                |
|                10|34                |
|                11|38                |
|                12|6                 |
|                12|15                |
|                12|22                |
|                12|31                |
|                12|51                |
|                13|20                |
|                13|48                |
|                14|4                 |
|                14|16                |
|                15|37                |
|                16|23                |
|                17|43                |
|                17|44                |
|                17|46                |
|                18|35                |
|                19|3                 |
|                19|7                 |
|                19|12                |
|                19|18                |
|                19|24                |
|                19|41                |
|                20|8                 |
|                20|17                |
|                20|26                |
|                20|30                |

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
|                 9|                19|c_209          |NMCP             |                        6|o_419          |pt9y            |Sutherland                |                              23|                               8|
|                 9|                33|c_209          |NMCP             |                        6|o_433          |6zmz            |Grind                     |                              26|                               2|
|                 9|                36|c_209          |NMCP             |                        6|o_436          |0cot            |Jack                      |                              36|                              20|
|                 9|                40|c_209          |NMCP             |                        6|o_440          |27vk            |Never                     |                              40|                              19|
|                 9|                49|c_209          |NMCP             |                        6|o_449          |lptr            |Wilson                    |                              34|                              17|
|                 9|                50|c_209          |NMCP             |                        6|o_450          |2w56            |Xiang                     |                              11|                               2|
|                19|                 3|c_219          |1st MLG          |                        6|o_403          |x0qi            |Carr                      |                              42|                              13|
|                19|                 7|c_219          |1st MLG          |                        6|o_407          |wnaf            |Glover                    |                              26|                              18|
|                19|                12|c_219          |1st MLG          |                        6|o_412          |9aa1            |Lambert                   |                              43|                               9|
|                19|                18|c_219          |1st MLG          |                        6|o_418          |bakn            |Rampling                  |                              50|                              12|
|                19|                24|c_219          |1st MLG          |                        6|o_424          |d6hs            |Xiong                     |                              29|                              14|
|                19|                41|c_219          |1st MLG          |                        6|o_441          |ovvy            |Object                    |                              21|                               4|
|                12|                 6|c_212          |NHCL             |                        5|o_406          |m8w6            |Forsyth                   |                              15|                               4|
|                12|                15|c_212          |NHCL             |                        5|o_415          |cn7q            |Oliver                    |                              45|                               5|
|                12|                22|c_212          |NHCL             |                        5|o_422          |h8pg            |Vaughan                   |                              42|                               2|
|                12|                31|c_212          |NHCL             |                        5|o_431          |6ust            |Estes                     |                              40|                              14|
|                12|                51|c_212          |NHCL             |                        5|o_451          |fjh2            |Yu                        |                              47|                               1|
|                 4|                 2|c_204          |3rd MLG          |                        4|o_402          |kobl            |Bailey                    |                              30|                              14|
|                 4|                29|c_204          |3rd MLG          |                        4|o_429          |85i6            |Coolie                    |                              38|                               7|
|                 4|                32|c_204          |3rd MLG          |                        4|o_432          |785o            |Flag                      |                              15|                               3|
|                 4|                39|c_204          |3rd MLG          |                        4|o_439          |ob7u            |Michaels                  |                              17|                              12|
|                10|                 5|c_210          |Jax              |                        4|o_405          |87cl            |Ellison                   |                              37|                              18|
|                10|                 9|c_210          |Jax              |                        4|o_409          |pb8x            |Ince                      |                              13|                               6|
|                10|                10|c_210          |Jax              |                        4|o_410          |5t8r            |Jones                     |                               8|                               4|
|                10|                34|c_210          |Jax              |                        4|o_434          |525l            |Hyer                      |                              15|                              19|
|                16|                23|c_216          |NMCSD            |                        4|o_423          |vqdq            |Walker                    |                              41|                              19|
|                20|                 8|c_220          |1st MEU          |                        4|o_408          |as5q            |Harris                    |                              23|                               3|
|                20|                17|c_220          |1st MEU          |                        4|o_417          |s9l6            |Quinn                     |                               9|                              13|
|                20|                26|c_220          |1st MEU          |                        4|o_426          |d2nz            |Zimmer                    |                              29|                              12|
|                20|                30|c_220          |1st MEU          |                        4|o_430          |zkff            |Dulles                    |                              45|                              17|
|                17|                43|c_217          |NH 29P           |                        3|o_443          |yocg            |Quincy                    |                              34|                              19|
|                17|                44|c_217          |NH 29P           |                        3|o_444          |yk8a            |Rolls                     |                              16|                               2|
|                17|                46|c_217          |NH 29P           |                        3|o_446          |wfv3            |Tut                       |                              23|                              12|
|                 2|                45|c_202          |NH Oki           |                        2|o_445          |fg86            |Sherman                   |                              40|                              14|
|                 2|                47|c_202          |NH Oki           |                        2|o_447          |goed            |Unger                     |                              37|                              10|
|                 3|                14|c_203          |Oki MEU          |                        2|o_414          |k1lv            |Nash                      |                              18|                              13|
|                 3|                28|c_203          |Oki MEU          |                        2|o_428          |vzno            |Bell                      |                              32|                              17|
|                 5|                27|c_205          |NH Yoko          |                        2|o_427          |9je3            |Aikman                    |                              26|                               3|
|                 5|                42|c_205          |NH Yoko          |                        2|o_442          |bqrp            |Power                     |                              22|                              18|
|                 7|                 1|c_207          |Napl             |                        2|o_401          |xvxe            |Abraham                   |                              46|                               2|
|                 7|                13|c_207          |Napl             |                        2|o_413          |5sjg            |Murray                    |                              17|                               5|
|                13|                20|c_213          |2nd MLG          |                        2|o_420          |paed            |Taylor                    |                              37|                              18|
|                13|                48|c_213          |2nd MLG          |                        2|o_448          |nkql            |Vince                     |                              47|                              12|
|                14|                 4|c_214          |2nd MEU          |                        2|o_404          |pd7n            |Davidson                  |                               8|                              18|
|                14|                16|c_214          |2nd MEU          |                        2|o_416          |1qhj            |Paige                     |                              49|                              16|
|                 1|                25|c_201          |Guam             |                        1|o_425          |tb5t            |Young                     |                              24|                              15|
|                 6|                11|c_206          |Rota             |                        1|o_411          |2tb7            |Knox                      |                              38|                              13|
|                 8|                21|c_208          |Sig              |                        1|o_421          |zaif            |Underwood                 |                              13|                              17|
|                11|                38|c_211          |Gitmo            |                        1|o_438          |tun2            |Laurence                  |                              47|                               3|
|                15|                37|c_215          |CBIRF            |                        1|o_437          |ojoz            |Kippler                   |                               2|                              19|
|                18|                35|c_218          |NH Pend          |                        1|o_435          |cbku            |Instance                  |                               5|                              11|
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
Report rendered by wbeasley at 2016-11-26, 23:14 -0600
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
[1] ggplot2_2.2.0 knitr_1.15.1  magrittr_1.5 

loaded via a namespace (and not attached):
 [1] Rcpp_0.12.8           partitions_1.9-18     munsell_0.4.3         testit_0.6           
 [5] colorspace_1.3-1      R6_2.2.0              highr_0.6             plyr_1.8.4           
 [9] stringr_1.1.0         dplyr_0.5.0           tools_3.3.2           grid_3.3.2           
[13] gtable_0.2.0          DBI_0.5-1             matchingMarkets_0.3-2 htmltools_0.3.5      
[17] yaml_2.1.14           lazyeval_0.2.0        assertthat_0.1        rprojroot_1.1        
[21] digest_0.6.10         tibble_1.2            gmp_0.5-12            rJava_0.9-8          
[25] readr_1.0.0           tidyr_0.6.0           evaluate_0.10         rmarkdown_1.2        
[29] labeling_0.3          stringi_1.1.2         scales_0.4.1          backports_1.0.4      
[33] polynom_1.3-8         markdown_0.7.7       
```
