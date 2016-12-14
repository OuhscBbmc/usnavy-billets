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

To walk through an example from the command's perspective, look at the fifth row in the first table.  The values represent how command ``c_205`` ranked the 62 officers.  The command's initial four officers (i.e., ``o_401, o_402, o_403, o_404``) were ranked  4,  5,  6, and  7.

To walk through an example from the officer's perspective, look at the second row in the second table.    The values represent how officer ``o_402`` ranked the 20 commands.  The officer's initial three commands (i.e., ``c_201, c_202, c_203``) were ranked  4,  6, and  7.

<!-- To walk through an example from the command's perspective, look at the fifth row in the first table.  The values represent how the 20 commands ranked officer ``o_405``.  The first four commands (i.e., ``c_201, c_202, c_203, c_204``) ranked officer ``o_405`` as 9, 9, 6, and 7.

To walk through an example from the officer's perspective, look at the second row in the second table.  The values represent how the 62 officers ranked command ``c_202``.  The first four officers (i.e., ``o_401, o_402, o_403, o_404``) ranked officer ``c_202`` as 8, 6, 4, and 7.-->


### Input Provided from Each Command



| command_id| o_401| o_402| o_403| o_404| o_405| o_406| o_407| o_408| o_409| o_410| o_411| o_412| o_413| o_414| o_415| o_416| o_417| o_418| o_419| o_420| o_421| o_422| o_423| o_424| o_425| o_426| o_427| o_428| o_429| o_430| o_431| o_432| o_433| o_434| o_435| o_436| o_437| o_438| o_439| o_440| o_441| o_442| o_443| o_444| o_445| o_446| o_447| o_448| o_449| o_450| o_451|
|----------:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|
|      c_201|     6|     1|     7|     8|     9|    10|    11|    12|    13|    14|    15|     2|    16|    17|    18|    19|    20|    21|     3|    22|    23|     5|    24|    25|    26|    27|    28|     4|    29|    30|    31|    32|    33|    34|    35|    36|    37|    38|    39|    40|    41|    42|    43|    44|    45|    46|    47|    48|    49|    50|    51|
|      c_202|     5|     6|     7|     8|     9|    10|    11|    12|    13|    14|     2|     3|    15|    16|    17|    18|    19|    20|    21|    22|    23|    24|    25|    26|    27|    28|    29|    30|    31|    32|    33|    34|    35|    36|    37|    38|    39|    40|    41|    42|    43|    44|    45|    46|    47|     1|    48|    49|    50|     4|    51|
|      c_203|     2|     3|     4|     5|     6|     7|     8|     9|    10|    11|    12|    13|    14|    15|    16|    17|    18|    19|    20|    21|    22|    23|    24|    25|    26|    27|    28|    29|     1|    30|    31|    32|    33|    34|    35|    36|    37|    38|    39|    40|    41|    42|    43|    44|    45|    46|    47|    48|    49|    50|    51|
|      c_204|     3|     4|     5|     6|     7|     8|     9|    10|    11|    12|     1|    13|     2|    14|    15|    16|    17|    18|    19|    20|    21|    22|    23|    24|    25|    26|    27|    28|    29|    30|    31|    32|    33|    34|    35|    36|    37|    38|    39|    40|    41|    42|    43|    44|    45|    46|    47|    48|    49|    50|    51|
|      c_205|     4|     5|     6|     7|     8|     9|    10|    11|    12|    13|    14|    15|    16|    17|    18|    19|    20|    21|     3|    22|    23|     2|    24|    25|    26|    27|    28|    29|    30|    31|    32|    33|    34|    35|    36|    37|    38|    39|    40|    41|    42|    43|    44|    45|    46|    47|    48|    49|    50|     1|    51|
|      c_206|     7|     3|     8|     9|    10|    11|    12|    13|    14|    15|    16|    17|    18|    19|    20|    21|    22|     1|    23|    24|    25|    26|    27|    28|    29|    30|    31|    32|     5|     6|    33|    34|    35|    36|    37|     2|    38|     4|    39|    40|    41|    42|    43|    44|    45|    46|    47|    48|    49|    50|    51|
|      c_207|     9|     7|    10|    11|    12|    13|    14|    15|    16|    17|    18|    19|    20|    21|     6|    22|     3|     2|    23|    24|    25|    26|    27|    28|    29|     8|    30|    31|     4|     5|    32|    33|    34|    35|    36|    37|    38|     1|    39|    40|    41|    42|    43|    44|    45|    46|    47|    48|    49|    50|    51|
|      c_208|     9|     1|    11|    12|    13|     4|    14|    15|    16|     5|    10|    17|    18|    19|     3|    20|    21|    22|    23|    24|    25|    26|    27|    28|     2|    29|    30|    31|    32|    33|     8|    34|    35|    36|    37|    38|    39|    40|    41|     7|     6|    42|    43|    44|    45|    46|    47|    48|    49|    50|    51|
|      c_209|     7|    15|    16|    17|     6|    18|    14|     2|     9|    19|    20|    21|    22|    23|    24|    25|    12|    26|    27|     1|    13|    28|    29|     8|    30|    31|     5|    10|    32|     3|    33|    34|    35|    36|    37|    38|    39|     4|    40|    41|    42|    43|    44|    11|    45|    46|    47|    48|    49|    50|    51|
|      c_210|    10|    11|    12|    13|    14|    15|     1|    16|    17|    18|    19|    20|    21|     2|     6|     8|    22|    23|    24|    25|    26|    27|     4|    28|    29|    30|    31|    32|    33|     3|    34|    35|     5|    36|    37|    38|    39|    40|    41|    42|    43|    44|    45|    46|    47|    48|    49|     9|    50|     7|    51|
|      c_211|     5|     2|     6|     7|     8|     9|     3|    10|    11|    12|    13|    14|    15|    16|    17|    18|    19|     1|    20|    21|    22|    23|    24|    25|    26|    27|    28|    29|    30|    31|    32|    33|    34|    35|    36|    37|    38|    39|    40|    41|    42|     4|    43|    44|    45|    46|    47|    48|    49|    50|    51|
|      c_212|     6|    12|    10|     1|     3|    13|    14|    15|    16|     2|    17|     4|    18|    19|    20|     7|    21|    22|    23|    24|     9|    25|    26|    27|    28|    29|    30|    31|    32|    33|    34|    35|    36|    37|    38|    39|    40|    41|    42|    43|    44|     8|    11|    45|    46|    47|    48|    49|    50|     5|    51|
|      c_213|     5|     6|     7|     8|     9|    10|    11|    12|    13|    14|    15|     1|    16|    17|    18|     3|    19|    20|    21|    22|    23|    24|    25|    26|    27|    28|    29|    30|     2|    31|    32|    33|    34|    35|    36|    37|    38|    39|    40|    41|    42|    43|    44|     4|    45|    46|    47|    48|    49|    50|    51|
|      c_214|     3|     4|     5|     6|     7|     8|     9|    10|    11|    12|     2|    13|     1|    14|    15|    16|    17|    18|    19|    20|    21|    22|    23|    24|    25|    26|    27|    28|    29|    30|    31|    32|    33|    34|    35|    36|    37|    38|    39|    40|    41|    42|    43|    44|    45|    46|    47|    48|    49|    50|    51|
|      c_215|     2|     3|     4|     5|     6|     7|     8|     9|    10|    11|    12|    13|    14|    15|    16|    17|    18|    19|    20|    21|    22|    23|    24|    25|     1|    26|    27|    28|    29|    30|    31|    32|    33|    34|    35|    36|    37|    38|    39|    40|    41|    42|    43|    44|    45|    46|    47|    48|    49|    50|    51|
|      c_216|    10|    11|    12|    13|    14|    15|    16|    17|     2|    18|    19|    20|    21|    22|    23|    24|     7|    25|     5|    26|    27|    28|     9|     4|     1|     8|    29|    30|    31|    32|    33|    34|    35|    36|    37|    38|     3|    39|    40|    41|    42|    43|    44|    45|    46|    47|    48|    49|    50|    51|     6|
|      c_217|    15|    16|     7|    17|    18|    19|    20|    21|    22|    10|    23|    24|    25|    26|     3|    13|     5|     6|    27|    28|    29|     9|    30|    31|    32|    33|    34|    35|    36|    37|     1|     2|     4|     8|    38|    39|    40|    41|    42|    12|    11|    43|    44|    45|    46|    47|    48|    49|    50|    51|    14|
|      c_218|     5|     6|     7|     8|     9|    10|    11|    12|    13|    14|    15|    16|    17|    18|    19|    20|    21|    22|     2|    23|    24|     4|    25|    26|    27|    28|    29|    30|    31|    32|     1|    33|    34|     3|    35|    36|    37|    38|    39|    40|    41|    42|    43|    44|    45|    46|    47|    48|    49|    50|    51|
|      c_219|    12|    13|    14|    15|    16|    17|    18|    19|    20|     3|     9|     7|    21|    22|     1|     6|    23|    24|    25|    26|    10|    27|    28|    29|    30|    31|    32|    33|    34|    35|     8|    36|    37|    11|     2|    38|    39|    40|     4|    41|    42|    43|    44|    45|     5|    46|    47|    48|    49|    50|    51|
|      c_220|    17|    18|    19|    20|    13|    21|    22|    23|    24|     8|    15|     7|    10|    25|    16|    26|    27|    28|    29|    30|    14|    31|    32|    33|    34|    35|    36|    37|     2|    38|     1|     5|    39|    11|     9|    40|    41|    42|     6|     3|    12|    43|    44|    45|     4|    46|    47|    48|    49|    50|    51|



### Input Provided from Each Officer



| officer_id| c_201| c_202| c_203| c_204| c_205| c_206| c_207| c_208| c_209| c_210| c_211| c_212| c_213| c_214| c_215| c_216| c_217| c_218| c_219| c_220|
|----------:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|
|      o_401|     7|     8|     9|    10|    11|    12|    13|    14|     1|     5|    15|     2|     3|     4|    16|     6|    17|    18|    19|    20|
|      o_402|     4|     6|     7|     8|     9|     2|     1|     3|    10|    11|     5|    12|    13|    14|    15|    16|    17|    18|    19|    20|
|      o_403|     3|     4|     9|    10|    11|    12|    13|    14|     8|     1|    15|     6|    16|    17|    18|     7|     5|     2|    19|    20|
|      o_404|     6|     7|     8|     9|     5|     4|    10|    11|     1|    12|    13|     3|    14|    15|    16|     2|    17|    18|    19|    20|
|      o_405|     6|     7|     8|     9|    10|    11|    12|    13|     1|    14|    15|     3|    16|    17|    18|     2|    19|    20|     5|     4|
|      o_406|     9|    10|    11|    12|    13|    14|     1|    15|     5|     2|    16|     3|    17|     8|     7|     6|    18|     4|    19|    20|
|      o_407|    10|     5|     6|     7|     4|     8|     9|    11|     3|     1|     2|    12|    13|    14|    15|    16|    17|    18|    19|    20|
|      o_408|     3|     4|     5|     6|     7|     8|     9|    10|     1|    11|    12|     2|    13|    14|    15|    16|    17|    18|    19|    20|
|      o_409|     3|     4|     5|     6|     7|     8|     9|    10|     2|    11|    12|    13|    14|    15|    16|     1|    17|    18|    19|    20|
|      o_410|     5|     6|     7|     8|     9|    10|    11|    12|     1|    13|    14|     4|    15|    16|    17|     2|    18|    19|     3|    20|
|      o_411|     8|     6|     9|     7|    10|    11|    12|    13|    14|    15|    16|     2|     3|     1|    17|    18|    19|    20|     5|     4|
|      o_412|     1|     2|    10|    11|    12|    13|    14|    15|    16|     3|    17|     6|     4|     5|    18|    19|    20|     9|     8|     7|
|      o_413|     9|    10|     4|     5|    11|    12|    13|    14|    15|     8|    16|     2|     3|     1|    17|    18|    19|    20|     7|     6|
|      o_414|     2|     3|     4|     5|     6|     7|     8|     9|    10|     1|    11|    12|    13|    14|    15|    16|    17|    18|    19|    20|
|      o_415|     7|     8|     9|    10|    11|    12|     6|    13|    14|     1|    15|    16|    17|    18|     2|    19|     3|    20|     4|     5|
|      o_416|     8|     9|    10|    11|    12|    13|    14|    15|     5|     1|    16|     2|     7|    17|    18|     6|     4|     3|    19|    20|
|      o_417|     9|    10|    11|    12|    13|     6|     5|     7|     3|     2|    14|    15|    16|    17|    18|     1|     8|     4|    19|    20|
|      o_418|     7|     8|     9|    10|    11|     4|     6|    12|    13|     5|     2|    14|    15|    16|    17|    18|     3|     1|    19|    20|
|      o_419|     6|     7|     8|     9|     5|    10|    11|    12|     3|     4|    13|    14|    15|    16|    17|     1|    18|     2|    19|    20|
|      o_420|     2|     3|     4|     5|     6|     7|     8|     9|    10|     1|    11|    12|    13|    14|    15|    16|    17|    18|    19|    20|
|      o_421|     8|     9|    10|    11|    12|    13|    14|    15|     6|     5|    16|     7|    17|    18|    19|     1|    20|     2|     3|     4|
|      o_422|     1|     6|     7|     8|     4|     9|    10|    11|    12|     2|    13|    14|    15|    16|    17|     5|    18|     3|    19|    20|
|      o_423|     7|     8|     9|    10|    11|    12|    13|    14|     4|     1|    15|     5|    16|    17|    18|     2|     6|     3|    19|    20|
|      o_424|     7|     8|     9|    10|    11|    12|    13|    14|     1|     3|    15|     4|    16|    17|    18|     2|     6|     5|    19|    20|
|      o_425|     6|     7|     8|     9|    10|    11|    12|    13|     5|     2|    14|    15|    16|    17|     1|     3|    18|     4|    19|    20|
|      o_426|     5|     6|     7|     8|     9|    10|     4|    11|    12|     2|    13|    14|    15|    16|    17|     1|    18|     3|    19|    20|
|      o_427|     3|     4|     5|     6|     7|     8|     9|    10|     1|    11|    12|     2|    13|    14|    15|    16|    17|    18|    19|    20|
|      o_428|     7|     8|     9|    10|    11|     5|     6|    12|     2|     1|    13|     3|    14|    15|    16|     4|    17|    18|    19|    20|
|      o_429|     8|     9|     4|     2|    10|    11|     7|    12|    13|    14|    15|    16|     6|     5|    17|    18|    19|    20|     1|     3|
|      o_430|     5|     6|     7|     8|     9|    10|    11|    12|     1|     2|    13|    14|    15|    16|    17|     3|    18|     4|    19|    20|
|      o_431|     5|     6|     7|     8|     9|    10|    11|    12|    13|    14|    15|    16|    17|    18|    19|    20|     1|     4|     2|     3|
|      o_432|     6|     7|     8|     9|    10|    11|    12|    13|    14|    15|    16|    17|    18|    19|    20|     3|     2|     1|     4|     5|
|      o_433|     6|     7|     8|     9|    10|    11|    12|    13|     5|     2|    14|    15|    16|    17|    18|     4|     3|     1|    19|    20|
|      o_434|     6|     7|     8|     9|    10|    11|    12|    13|    14|    15|    16|    17|    18|    19|    20|     2|     5|     3|     4|     1|
|      o_435|     4|     5|     6|     7|     8|     9|    10|    11|    12|    13|    14|    15|    16|    17|    18|    19|    20|     3|     1|     2|
|      o_436|     5|     6|     7|     8|     9|    10|     1|     2|     3|    11|    12|    13|    14|    15|    16|    17|    18|     4|    19|    20|
|      o_437|     3|     4|     5|     6|     7|     8|     9|    10|     2|    11|    12|    13|    14|    15|    16|     1|    17|    18|    19|    20|
|      o_438|     6|     8|     9|    10|     7|     3|     4|     5|     1|     2|    11|    12|    13|    14|    15|    16|    17|    18|    19|    20|
|      o_439|     5|     6|     7|     8|     9|    10|    11|    12|    13|    14|    15|    16|    17|    18|    19|     4|    20|     2|     1|     3|
|      o_440|     5|     6|     7|     8|     9|    10|    11|    12|    13|    14|    15|    16|    17|    18|    19|     3|     4|    20|     2|     1|
|      o_441|     5|     6|     7|     8|     9|    10|    11|    12|    13|    14|    15|    16|    17|    18|    19|    20|     4|     3|     2|     1|
|      o_442|     6|     7|     8|     9|    10|    11|    12|    13|     1|     3|     4|     2|    14|    15|     5|    16|    17|    18|    19|    20|
|      o_443|     8|     9|    10|    11|    12|    13|    14|    15|     5|     4|    16|     3|    17|    18|    19|     1|     7|     2|    20|     6|
|      o_444|     7|     8|     9|    10|    11|    12|    13|    14|     1|     5|    15|     4|     3|     2|    16|     6|    17|    18|    19|    20|
|      o_445|     7|     8|     9|    10|    11|    12|    13|    14|     5|     6|    15|    16|    17|    18|    19|     3|     4|    20|     1|     2|
|      o_446|     2|     1|     3|     4|     5|     6|     7|     8|     9|    10|    11|    12|    13|    14|    15|    16|    17|    18|    19|    20|
|      o_447|     6|     7|     8|     9|    10|    11|    12|    13|     5|     1|    14|     3|    15|    16|    17|     2|    18|     4|    19|    20|
|      o_448|     9|    10|    11|    12|    13|    14|    15|    16|     5|     1|     8|    17|    18|    19|     7|     6|    20|     4|     2|     3|
|      o_449|     5|     6|     7|     8|     9|    10|    11|    12|     2|     1|    13|     4|    14|    15|    16|     3|    17|    18|    19|    20|
|      o_450|     1|     3|    10|     7|     2|    13|    14|    15|    16|     4|    17|    18|     9|    12|    19|     6|    20|     5|     8|    11|
|      o_451|     7|     8|     9|    10|    11|    12|    13|    14|     3|     4|    15|     5|    16|    17|    18|     1|     6|     2|    19|    20|

Results
===========================================

### Matches

The skinny table below shows the pairs of command--officer matches.  Notice that not all entities were matched.  This is because there were 54 total billets (across 20 unique commands), but 62 officers.  This is only the essential information.  See the following section for a comprehensive table.

| command<br/>index|officer<br/>index |
|-----------------:|:-----------------|
|                 1|12                |
|                 2|14                |
|                 2|20                |
|                 3|3                 |
|                 3|8                 |
|                 4|2                 |
|                 4|9                 |
|                 4|22                |
|                 4|26                |
|                 5|4                 |
|                 5|7                 |
|                 6|10                |
|                 7|11                |
|                 7|15                |
|                 8|1                 |
|                 9|6                 |
|                 9|16                |
|                 9|17                |
|                 9|18                |
|                 9|19                |
|                 9|21                |
|                10|13                |
|                10|23                |
|                10|24                |
|                10|25                |
|                11|5                 |
|                12|27                |
|                12|28                |
|                12|29                |
|                12|30                |
|                12|31                |
|                13|32                |
|                13|33                |
|                14|34                |
|                14|35                |
|                15|36                |
|                16|37                |
|                16|38                |
|                16|39                |
|                16|40                |
|                17|41                |
|                17|42                |
|                17|43                |
|                18|44                |
|                19|45                |
|                19|46                |
|                19|47                |
|                19|48                |
|                19|49                |
|                19|50                |
|                20|51                |

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
|                 9|                 6|c_209          |NMCP             |                        6|o_406          |m8w6            |Forsyth                   |                              18|                               5|
|                 9|                16|c_209          |NMCP             |                        6|o_416          |1qhj            |Paige                     |                              25|                               5|
|                 9|                17|c_209          |NMCP             |                        6|o_417          |s9l6            |Quinn                     |                              12|                               3|
|                 9|                18|c_209          |NMCP             |                        6|o_418          |bakn            |Rampling                  |                              26|                              13|
|                 9|                19|c_209          |NMCP             |                        6|o_419          |pt9y            |Sutherland                |                              27|                               3|
|                 9|                21|c_209          |NMCP             |                        6|o_421          |zaif            |Underwood                 |                              13|                               6|
|                19|                45|c_219          |1st MLG          |                        6|o_445          |fg86            |Sherman                   |                               5|                               1|
|                19|                46|c_219          |1st MLG          |                        6|o_446          |wfv3            |Tut                       |                              46|                              19|
|                19|                47|c_219          |1st MLG          |                        6|o_447          |goed            |Unger                     |                              47|                              19|
|                19|                48|c_219          |1st MLG          |                        6|o_448          |nkql            |Vince                     |                              48|                               2|
|                19|                49|c_219          |1st MLG          |                        6|o_449          |lptr            |Wilson                    |                              49|                              19|
|                19|                50|c_219          |1st MLG          |                        6|o_450          |2w56            |Xiang                     |                              50|                               8|
|                12|                27|c_212          |NHCL             |                        5|o_427          |9je3            |Aikman                    |                              30|                               2|
|                12|                28|c_212          |NHCL             |                        5|o_428          |vzno            |Bell                      |                              31|                               3|
|                12|                29|c_212          |NHCL             |                        5|o_429          |85i6            |Coolie                    |                              32|                              16|
|                12|                30|c_212          |NHCL             |                        5|o_430          |zkff            |Dulles                    |                              33|                              14|
|                12|                31|c_212          |NHCL             |                        5|o_431          |6ust            |Estes                     |                              34|                              16|
|                 4|                 2|c_204          |3rd MLG          |                        4|o_402          |kobl            |Bailey                    |                               4|                               8|
|                 4|                 9|c_204          |3rd MLG          |                        4|o_409          |pb8x            |Ince                      |                              11|                               6|
|                 4|                22|c_204          |3rd MLG          |                        4|o_422          |h8pg            |Vaughan                   |                              22|                               8|
|                 4|                26|c_204          |3rd MLG          |                        4|o_426          |d2nz            |Zimmer                    |                              26|                               8|
|                10|                13|c_210          |Jax              |                        4|o_413          |5sjg            |Murray                    |                              21|                               8|
|                10|                23|c_210          |Jax              |                        4|o_423          |vqdq            |Walker                    |                               4|                               1|
|                10|                24|c_210          |Jax              |                        4|o_424          |d6hs            |Xiong                     |                              28|                               3|
|                10|                25|c_210          |Jax              |                        4|o_425          |tb5t            |Young                     |                              29|                               2|
|                16|                37|c_216          |NMCSD            |                        4|o_437          |ojoz            |Kippler                   |                               3|                               1|
|                16|                38|c_216          |NMCSD            |                        4|o_438          |tun2            |Laurence                  |                              39|                              16|
|                16|                39|c_216          |NMCSD            |                        4|o_439          |ob7u            |Michaels                  |                              40|                               4|
|                16|                40|c_216          |NMCSD            |                        4|o_440          |27vk            |Never                     |                              41|                               3|
|                20|                51|c_220          |1st MEU          |                        4|o_451          |fjh2            |Yu                        |                              51|                              20|
|                17|                41|c_217          |NH 29P           |                        3|o_441          |ovvy            |Object                    |                              11|                               4|
|                17|                42|c_217          |NH 29P           |                        3|o_442          |bqrp            |Power                     |                              43|                              17|
|                17|                43|c_217          |NH 29P           |                        3|o_443          |yocg            |Quincy                    |                              44|                               7|
|                 2|                14|c_202          |NH Oki           |                        2|o_414          |k1lv            |Nash                      |                              16|                               3|
|                 2|                20|c_202          |NH Oki           |                        2|o_420          |paed            |Taylor                    |                              22|                               3|
|                 3|                 3|c_203          |Oki MEU          |                        2|o_403          |x0qi            |Carr                      |                               4|                               9|
|                 3|                 8|c_203          |Oki MEU          |                        2|o_408          |as5q            |Harris                    |                               9|                               5|
|                 5|                 4|c_205          |NH Yoko          |                        2|o_404          |pd7n            |Davidson                  |                               7|                               5|
|                 5|                 7|c_205          |NH Yoko          |                        2|o_407          |wnaf            |Glover                    |                              10|                               4|
|                 7|                11|c_207          |Napl             |                        2|o_411          |2tb7            |Knox                      |                              18|                              12|
|                 7|                15|c_207          |Napl             |                        2|o_415          |cn7q            |Oliver                    |                               6|                               6|
|                13|                32|c_213          |2nd MLG          |                        2|o_432          |785o            |Flag                      |                              33|                              18|
|                13|                33|c_213          |2nd MLG          |                        2|o_433          |6zmz            |Grind                     |                              34|                              16|
|                14|                34|c_214          |2nd MEU          |                        2|o_434          |525l            |Hyer                      |                              34|                              19|
|                14|                35|c_214          |2nd MEU          |                        2|o_435          |cbku            |Instance                  |                              35|                              17|
|                 1|                12|c_201          |Guam             |                        1|o_412          |9aa1            |Lambert                   |                               2|                               1|
|                 6|                10|c_206          |Rota             |                        1|o_410          |5t8r            |Jones                     |                              15|                              10|
|                 8|                 1|c_208          |Sig              |                        1|o_401          |xvxe            |Abraham                   |                               9|                              14|
|                11|                 5|c_211          |Gitmo            |                        1|o_405          |87cl            |Ellison                   |                               8|                              15|
|                15|                36|c_215          |CBIRF            |                        1|o_436          |0cot            |Jack                      |                              36|                              16|
|                18|                44|c_218          |NH Pend          |                        1|o_444          |yk8a            |Rolls                     |                              44|                              18|
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
Report rendered by wbeasley at 2016-12-14, 12:37 -0600
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
 [1] Rcpp_0.12.8           partitions_1.9-18     munsell_0.4.3         colorspace_1.3-1     
 [5] R6_2.2.0              highr_0.6             dplyr_0.5.0.9000      stringr_1.1.0        
 [9] plyr_1.8.4            tools_3.3.2           grid_3.3.2            gtable_0.2.0         
[13] DBI_0.5-1             htmltools_0.3.5       matchingMarkets_0.3-2 yaml_2.1.14          
[17] lazyeval_0.2.0        rprojroot_1.1         digest_0.6.10         assertthat_0.1       
[21] tibble_1.2            gmp_0.5-12            rJava_0.9-8           tidyr_0.6.0          
[25] readr_1.0.0           evaluate_0.10         rmarkdown_1.2         labeling_0.3         
[29] stringi_1.1.2         scales_0.4.1          backports_1.0.4       polynom_1.3-9        
```
