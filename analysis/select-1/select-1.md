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



### Input Provided from Each Command



| college_id| 401| 402| 403| 404| 405| 406| 407| 408| 409| 410| 411| 412| 413| 414| 415| 416| 417| 418| 419| 420| 421| 422| 423| 424| 425| 426| 427| 428| 429| 430| 431| 432| 433| 434| 435| 436| 437| 438| 439| 440| 441| 442| 443| 444| 445| 446| 447| 448| 449| 450| 451|
|----------:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
|        201|  NA|   1|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   2|  NA|  NA|  NA|  NA|  NA|  NA|   3|  NA|  NA|   5|  NA|  NA|  NA|  NA|  NA|   4|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|
|        202|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   2|   3|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   1|  NA|  NA|  NA|   4|  NA|
|        203|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   1|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|
|        204|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   1|  NA|   2|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|
|        205|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   3|  NA|  NA|   2|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   1|  NA|
|        206|  NA|   3|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   1|   2|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   5|   6|  NA|  NA|  NA|  NA|  NA|   3|  NA|   4|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|
|        207|  NA|   7|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   6|  NA|   3|   2|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   8|  NA|  NA|   4|   5|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   1|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|
|        208|   9|   1|  NA|  NA|  NA|   4|  NA|  NA|  NA|   5|  10|  NA|  NA|  NA|   3|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   2|  NA|  NA|  NA|  NA|  NA|   8|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   7|   6|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|
|        209|   7|  NA|  NA|  NA|   6|  NA|  14|   2|   9|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  12|  NA|  NA|   1|  13|  NA|  NA|   8|  NA|  NA|   5|  10|  NA|   3|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   4|  NA|  NA|  NA|  NA|  NA|  11|  NA|  NA|  NA|  NA|  NA|  NA|  NA|
|        210|  NA|  NA|  NA|  NA|  NA|  NA|   1|  NA|  NA|  NA|  NA|  NA|  NA|   2|   6|   8|  NA|  NA|  NA|  NA|  NA|  NA|   4|  NA|  NA|  NA|  NA|  NA|  NA|   3|  NA|  NA|   5|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   9|  NA|   7|  NA|
|        211|  NA|   2|  NA|  NA|  NA|  NA|   3|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   1|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   4|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|
|        212|   6|  NA|  10|   1|   3|  NA|  NA|  NA|  NA|   2|  NA|   4|  NA|  NA|  NA|   7|  NA|  NA|  NA|  NA|   9|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   8|  11|  NA|  NA|  NA|  NA|  NA|  NA|   5|  NA|
|        213|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   1|  NA|  NA|  NA|   3|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   2|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   4|  NA|  NA|   5|  NA|   6|  NA|  NA|
|        214|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   2|  NA|   1|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   4|  NA|   3|  NA|  NA|
|        215|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   1|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   2|  NA|   3|  NA|  NA|
|        216|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   2|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   7|  NA|   5|  NA|  NA|  NA|   9|   4|   1|   8|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   3|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   6|
|        217|  NA|  NA|   7|  NA|  NA|  NA|  NA|  NA|  NA|  10|  NA|  NA|  NA|  NA|   3|  13|   5|   6|  NA|  NA|  NA|   9|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   1|   2|   4|   8|  NA|  NA|  NA|  NA|  NA|  12|  11|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  14|
|        218|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   2|  NA|  NA|   4|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   1|  NA|  NA|   3|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|
|        219|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   3|   9|   7|  NA|  NA|   1|   6|  NA|  NA|  NA|  NA|  10|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   8|  NA|  NA|  11|   2|  NA|  NA|  NA|   4|  NA|  NA|  NA|  NA|  NA|   5|  NA|  NA|  NA|  NA|  NA|  NA|
|        220|  NA|  NA|  NA|  NA|  13|  NA|  NA|  NA|  NA|   8|  15|   7|  10|  NA|  16|  NA|  NA|  NA|  NA|  NA|  14|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   2|  NA|   1|   5|  NA|  11|   9|  NA|  NA|  NA|   6|   3|  12|  NA|  NA|  NA|   4|  NA|  NA|  NA|  NA|  NA|  NA|



### Input Provided from Each Officer



| student_id| 201| 202| 203| 204| 205| 206| 207| 208| 209| 210| 211| 212| 213| 214| 215| 216| 217| 218| 219| 220|
|----------:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
|        401|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   1|   5|  NA|   2|   3|   4|  NA|   6|  NA|  NA|  NA|  NA|
|        402|   4|  NA|  NA|  NA|  NA|   2|   1|   3|  NA|  NA|   5|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|
|        403|   3|   4|  NA|  NA|  NA|  NA|  NA|  NA|   8|   1|  NA|   6|  NA|  NA|  NA|   7|   5|   2|  NA|  NA|
|        404|   6|  NA|  NA|  NA|   5|   4|  NA|  NA|   1|  NA|  NA|   3|  NA|  NA|  NA|   2|  NA|  NA|  NA|  NA|
|        405|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   1|  NA|  NA|   3|  NA|  NA|  NA|   2|  NA|  NA|   5|   4|
|        406|  NA|  NA|  NA|  NA|  NA|  NA|   1|  NA|   5|   2|  NA|   3|  NA|   8|   7|   6|  NA|   4|  NA|  NA|
|        407|  NA|   5|   6|   7|   4|   8|   9|  NA|   3|   1|   2|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|
|        408|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   1|  NA|  NA|   2|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|
|        409|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   2|  NA|  NA|  NA|  NA|  NA|  NA|   1|  NA|  NA|  NA|  NA|
|        410|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   1|  NA|  NA|   4|  NA|  NA|  NA|   2|  NA|  NA|   3|  NA|
|        411|  NA|   6|  NA|   7|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   2|   3|   1|  NA|  NA|  NA|  NA|   5|   4|
|        412|   1|   2|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   3|  NA|   6|   4|   5|  NA|  NA|  NA|   9|   8|   7|
|        413|  NA|  NA|   4|   5|  NA|  NA|  NA|  NA|  NA|   8|  NA|   2|   3|   1|  NA|  NA|  NA|  NA|   7|   6|
|        414|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   1|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|
|        415|  NA|  NA|  NA|  NA|  NA|  NA|   6|  NA|  NA|   1|  NA|  NA|  NA|  NA|   2|  NA|   3|  NA|   4|   5|
|        416|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   5|   1|  NA|   2|   7|  NA|  NA|   6|   4|   3|  NA|  NA|
|        417|  NA|  NA|  NA|  NA|  NA|   6|   5|   7|   3|   2|  NA|  NA|  NA|  NA|  NA|   1|   8|   4|  NA|  NA|
|        418|  NA|  NA|  NA|  NA|  NA|   4|   6|  NA|  NA|   5|   2|  NA|  NA|  NA|  NA|  NA|   3|   1|  NA|  NA|
|        419|  NA|  NA|  NA|  NA|   5|  NA|  NA|  NA|   3|   4|  NA|  NA|  NA|  NA|  NA|   1|  NA|   2|  NA|  NA|
|        420|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   1|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|
|        421|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   6|   5|  NA|   7|  NA|  NA|  NA|   1|  NA|   2|   3|   4|
|        422|   1|  NA|  NA|  NA|   4|  NA|  NA|  NA|  NA|   2|  NA|  NA|  NA|  NA|  NA|   5|  NA|   3|  NA|  NA|
|        423|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   4|   1|  NA|   5|  NA|  NA|  NA|   2|   6|   3|  NA|  NA|
|        424|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   1|   3|  NA|   4|  NA|  NA|  NA|   2|   6|   5|  NA|  NA|
|        425|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   5|   2|  NA|  NA|  NA|  NA|   1|   3|  NA|   4|  NA|  NA|
|        426|  NA|  NA|  NA|  NA|  NA|  NA|   4|  NA|  NA|   2|  NA|  NA|  NA|  NA|  NA|   1|  NA|   3|  NA|  NA|
|        427|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   1|  NA|  NA|   2|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|
|        428|  NA|  NA|  NA|  NA|  NA|   5|   6|  NA|   2|   1|  NA|   3|  NA|  NA|  NA|   4|  NA|  NA|  NA|  NA|
|        429|  NA|  NA|   4|   2|  NA|  NA|   7|  NA|  NA|  NA|  NA|  NA|   6|   5|  NA|  NA|  NA|  NA|   1|   3|
|        430|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   1|   2|  NA|  NA|  NA|  NA|  NA|   3|  NA|   4|  NA|  NA|
|        431|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   1|   4|   2|   3|
|        432|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   3|   2|   1|   4|   5|
|        433|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   5|   2|  NA|  NA|  NA|  NA|  NA|   4|   3|   1|  NA|  NA|
|        434|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   2|   5|   3|   4|   1|
|        435|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   3|   1|   2|
|        436|  NA|  NA|  NA|  NA|  NA|  NA|   1|   2|   3|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   4|  NA|  NA|
|        437|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   2|  NA|  NA|  NA|  NA|  NA|  NA|   1|  NA|  NA|  NA|  NA|
|        438|   6|  NA|  NA|  NA|   7|   3|   4|   5|   1|   2|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|
|        439|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   4|  NA|   2|   1|   3|
|        440|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   3|   4|  NA|   2|   1|
|        441|   5|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   4|   3|   2|   1|
|        442|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   1|   3|   4|   2|  NA|  NA|   5|  NA|  NA|  NA|  NA|  NA|
|        443|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   5|   4|  NA|   3|  NA|  NA|  NA|   1|   7|   2|  NA|   6|
|        444|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   1|   5|  NA|   4|   3|   2|  NA|   6|  NA|  NA|  NA|  NA|
|        445|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   5|   6|  NA|  NA|  NA|  NA|  NA|   3|   4|  NA|   1|   2|
|        446|  NA|   1|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|
|        447|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   5|   1|  NA|   3|  NA|  NA|  NA|   2|  NA|   4|  NA|  NA|
|        448|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   5|   1|   8|  NA|  NA|  NA|   7|   6|  NA|   4|   2|   3|
|        449|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   2|   1|  NA|   4|  NA|  NA|  NA|   3|  NA|  NA|  NA|  NA|
|        450|   1|   3|  10|   7|   2|  NA|  NA|  NA|  NA|   4|  NA|  NA|   9|  12|  NA|   6|  NA|   5|   8|  11|
|        451|  NA|  NA|  NA|  NA|  NA|  NA|  NA|  NA|   3|   4|  NA|   5|  NA|  NA|  NA|   1|   6|   2|  NA|  NA|

Results
===========================================


### Pre-screen

Commands and officers must be excluded from the matching algorithm if none of their choices ranked them back.


```
The following 0 colleges/commands were never ranked by students/officers who ranked them: .  They will be removed.
```

```
The following 4 students/officers were never ranked by colleges/commands who ranked them: 406, 436, 447, 449.  They will be removed.
```

### Preference




```


### Input Provided from Each Command
```



|  1|  2|  3|  4|  5|  6|  7|  8|  9| 10| 11| 12| 13| 14| 15| 16| 17| 18| 19| 20|
|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
|  2| 44| 28| 10| 46| 17| 36|  2| 19|  6| 17|  4| 11| 12| 24| 24| 30| 30| 14| 30|
| 11| 10| NA| 12| 21| 18| 17| 24|  7| 13|  2|  9| 28| 10| NA|  8| 31| 18| 34| 28|
| 18| 11| NA| NA| 18|  2| 16| 14| 29| 29|  6|  5| 15| NA| NA| 35| 14| 33|  9| 38|
| 27| 46| NA| NA| NA| 36| 28|  9| 36| 22| 40| 11| 42| NA| NA| 23| 32| 21| 37| 43|
| 21| NA| NA| NA| NA| 28| 29| 39| 26| 32| NA| 46| NA| NA| NA| 18| 16| NA| 43| 31|
| NA| NA| NA| NA| NA| 29| 14| 38|  5| 14| NA|  1| NA| NA| NA| 47| 17| NA| 15| 37|
| NA| NA| NA| NA| NA| NA|  2| 30|  1| 46| NA| 15| NA| NA| NA| 16|  3| NA| 11| 11|
| NA| NA| NA| NA| NA| NA| 25|  1| 23| 15| NA| 40| NA| NA| NA| 25| 33| NA| 30|  9|
| NA| NA| NA| NA| NA| NA| NA| 10|  8| 45| NA| 20| NA| NA| NA| 22| 21| NA| 10| 34|
| NA| NA| NA| NA| NA| NA| NA| NA| 27| NA| NA|  3| NA| NA| NA| NA|  9| NA| 20| 12|
| NA| NA| NA| NA| NA| NA| NA| NA| 42| NA| NA| 41| NA| NA| NA| NA| 39| NA| 33| 33|
| NA| NA| NA| NA| NA| NA| NA| NA| 16| NA| NA| NA| NA| NA| NA| NA| 38| NA| NA| 39|
| NA| NA| NA| NA| NA| NA| NA| NA| 20| NA| NA| NA| NA| NA| NA| NA| 15| NA| NA|  5|
| NA| NA| NA| NA| NA| NA| NA| NA|  6| NA| NA| NA| NA| NA| NA| NA| 47| NA| NA| 20|
| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| 10|
| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| 14|

```


### Input Provided from Each Officer
```



|  1|  2|  3|  4|  5|  6|  7|  8|  9| 10| 11| 12| 13| 14| 15| 16| 17| 18| 19| 20| 21| 22| 23| 24| 25| 26| 27| 28| 29| 30| 31| 32| 33| 34| 35| 36| 37| 38| 39| 40| 41| 42| 43| 44| 45| 46| 47|
|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
|  9|  7| 10|  9|  9| 10|  9| 16|  9| 14|  1| 14| 10| 10| 10| 16| 18| 16|  9| 16|  1| 10|  9| 15| 16|  9| 10| 19|  9| 17| 18| 18| 20| 19| 16|  9| 19| 20| 20|  9| 16|  9| 19|  2| 10|  1| 16|
| 12|  6| 18| 16| 16| 11| 12|  9| 16| 12|  2| 12| NA| 15| 12| 10| 11| 18| NA| 18| 10| 16| 16| 10| 10| 12|  9|  4| 10| 19| 17| 10| 16| 20|  9| 10| 18| 19| 19| 12| 18| 14| 20| NA| 19|  5| 18|
| 13|  8|  1| 12| 12|  9| NA| NA| 19| 13| 10| 13| NA| 17| 18|  9| 17|  9| NA| 19| 18| 18| 10| 16| 18| NA| 12| 20| 16| 20| 16| 17| 18| 18| NA|  6| 20| 16| 18| 10| 12| 13| 16| NA| 20|  2|  9|
| 14|  1|  2|  6| 20|  5| NA| NA| 12| 20| 13|  3| NA| 19| 17| 18|  6| 10| NA| 20|  5|  9| 12| 18|  7| NA| 16|  3| 18| 18| 19| 16| 19| NA| NA|  7| 16| 17| 17| 11| 10| 12| 17| NA| 18| 10| 10|
| 10| 11| 17|  5| 19|  2| NA| NA| NA| 19| 14|  4| NA| 20|  9|  7| 10|  5| NA| 10| 16| 12| 18|  9| NA| NA|  6| 14| NA| NA| 20|  9| 17| NA| NA|  8| NA| NA|  1| 15|  9| 10|  9| NA|  9| 18| 12|
| 16| NA| 12|  1| NA|  3| NA| NA| NA|  2| 12| 20| NA|  7| 16|  6|  7| NA| NA|  9| NA| 17| 17| NA| NA| NA|  7| 13| NA| NA| NA| NA| NA| NA| NA|  1| NA| NA| NA| NA| 20| 16| 10| NA| 16| 16| 17|
| NA| NA| 16| NA| NA|  4| NA| NA| NA|  4| 20| 19| NA| NA| 13|  8| NA| NA| NA| 12| NA| NA| NA| NA| NA| NA| NA|  7| NA| NA| NA| NA| NA| NA| NA|  5| NA| NA| NA| NA| 17| NA| NA| NA| 15|  4| NA|
| NA| NA|  9| NA| NA|  6| NA| NA| NA| NA| 19| 10| NA| NA| NA| 17| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| 11| 19| NA|
| NA| NA| NA| NA| NA|  7| NA| NA| NA| NA| 18| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| 13| NA|
| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA|  3| NA|
| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| 20| NA|
| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| NA| 14| NA|

### Matches


The skinny table below shows the pairs of command--officer matches.  Notice that not all entities were matched.  This is because there were 54 total billets (across 20 unique commands), but 62 officers.  This is only the essential information.  See the following section for a comprehensive table.

| command<br/>index| officer<br/>index| command<br/>rank| officer<br/>rank| command<br/>optimal| officer<br/>optimal| matching| slots|
|-----------------:|-----------------:|----------------:|----------------:|-------------------:|-------------------:|--------:|-----:|
|                 1|                11|                2|                1|                   1|                   1|        1|     1|
|                 2|                44|                1|                1|                   1|                   1|        1|     2|
|                 5|                46|                1|                1|                   1|                   1|        1|    10|
|                 7|                 2|                6|                2|                   1|                   1|        1|    14|
|                 7|                16|                3|               11|                   1|                   1|        1|    13|
|                 9|                 5|                6|                6|                   1|                   1|        1|    21|
|                 9|                 7|                2|                2|                   1|                   1|        1|    17|
|                 9|                19|                1|                1|                   1|                   1|        1|    16|
|                 9|                26|                5|                5|                   1|                   1|        1|    20|
|                 9|                29|                3|                3|                   1|                   1|        1|    18|
|                 9|                36|                4|                4|                   1|                   1|        1|    19|
|                10|                 6|                1|                1|                   1|                   1|        1|    22|
|                10|                13|                2|                2|                   1|                   1|        1|    23|
|                10|                22|                4|                3|                   1|                   1|        1|    24|
|                10|                32|                5|                4|                   1|                   1|        1|    25|
|                11|                17|                1|                1|                   1|                   1|        1|    26|
|                12|                 1|                5|                8|                   1|                   1|        1|    28|
|                12|                 3|                9|                8|                   1|                   1|        1|    31|
|                12|                 4|                1|                1|                   1|                   1|        1|    27|
|                12|                15|                6|                7|                   1|                   1|        1|    29|
|                12|                40|                7|                4|                   1|                   1|        1|    30|
|                13|                42|                4|                7|                   1|                   1|        1|    32|
|                14|                10|                2|                2|                   1|                   1|        1|    35|
|                14|                12|                1|                1|                   1|                   1|        1|    34|
|                15|                24|                1|                1|                   1|                   1|        1|    36|
|                16|                 8|                2|                1|                   1|                   1|        1|    37|
|                16|                18|                5|                4|                   1|                   1|        1|    40|
|                16|                23|                4|                9|                   1|                   1|        1|    39|
|                16|                35|                3|                2|                   1|                   1|        1|    38|
|                17|                14|                3|                7|                   1|                   1|        1|    43|
|                17|                30|                1|                1|                   1|                   1|        1|    41|
|                17|                31|                2|                2|                   1|                   1|        1|    42|
|                18|                21|                4|                2|                   1|                   1|        1|    44|
|                19|                 9|                3|                2|                   1|                   1|        1|    46|
|                19|                20|                9|                5|                   1|                   1|        1|    49|
|                19|                34|                2|                1|                   1|                   1|        1|    45|
|                19|                37|                4|                3|                   1|                   1|        1|    47|
|                19|                43|                5|                4|                   1|                   1|        1|    48|
|                20|                28|                2|                1|                   1|                   1|        1|    51|
|                20|                33|               10|                3|                   1|                   1|        1|    53|
|                20|                38|                3|                2|                   1|                   1|        1|    52|
|                20|                39|               11|                4|                   1|                   1|        1|    54|

### Display

The final table shows the indices of only the successful matches, along with the following information:

* the hopsital ID and name (`command id` and `command name`), 
* the maximum number of billets for a command (`billet count max`),
* the officer ID and name  (`officer id` and `officer name last`), 
* the preference expressed from the command for the officer (`preference from command`)
* the preference expressed from the officer for the command (`preference from officer`)

In this demonstration, notice that not all commands filled every billet.


| command<br/>index| officer<br/>index| command<br/>rank| officer<br/>rank|command<br/>id |command<br/>name | billet<br/>count<br/>max|officer<br/>id |officer<br/>tag |officer<br/>name<br/>last | rank.x| rank.y|
|-----------------:|-----------------:|----------------:|----------------:|:--------------|:----------------|------------------------:|:--------------|:---------------|:-------------------------|------:|------:|
|                 9|                 5|                6|                6|c_209          |NMCP             |                        6|o_405          |87cl            |Ellison                   |      6|      1|
|                 9|                 7|                2|                2|c_209          |NMCP             |                        6|o_408          |as5q            |Harris                    |      2|      1|
|                 9|                19|                1|                1|c_209          |NMCP             |                        6|o_420          |paed            |Taylor                    |      1|      1|
|                 9|                26|                5|                5|c_209          |NMCP             |                        6|o_427          |9je3            |Aikman                    |      5|      1|
|                 9|                29|                3|                3|c_209          |NMCP             |                        6|o_430          |zkff            |Dulles                    |      3|      1|
|                 9|                36|                4|                4|c_209          |NMCP             |                        6|o_438          |tun2            |Laurence                  |      4|      1|
|                19|                 9|                3|                2|c_219          |1st MLG          |                        6|o_410          |5t8r            |Jones                     |      3|      3|
|                19|                20|                9|                5|c_219          |1st MLG          |                        6|o_421          |zaif            |Underwood                 |     10|      3|
|                19|                34|                2|                1|c_219          |1st MLG          |                        6|o_435          |cbku            |Instance                  |      2|      1|
|                19|                37|                4|                3|c_219          |1st MLG          |                        6|o_439          |ob7u            |Michaels                  |      4|      1|
|                19|                43|                5|                4|c_219          |1st MLG          |                        6|o_445          |fg86            |Sherman                   |      5|      1|
|                12|                 1|                5|                8|c_212          |NHCL             |                        5|o_401          |xvxe            |Abraham                   |      6|      2|
|                12|                 3|                9|                8|c_212          |NHCL             |                        5|o_403          |x0qi            |Carr                      |     10|      6|
|                12|                 4|                1|                1|c_212          |NHCL             |                        5|o_404          |pd7n            |Davidson                  |      1|      3|
|                12|                15|                6|                7|c_212          |NHCL             |                        5|o_416          |1qhj            |Paige                     |      7|      2|
|                12|                40|                7|                4|c_212          |NHCL             |                        5|o_442          |bqrp            |Power                     |      8|      2|
|                 4|                NA|               NA|               NA|c_204          |3rd MLG          |                        4|o_406          |m8w6            |Forsyth                   |     NA|     NA|
|                 4|                NA|               NA|               NA|c_204          |3rd MLG          |                        4|o_436          |0cot            |Jack                      |     NA|     NA|
|                 4|                NA|               NA|               NA|c_204          |3rd MLG          |                        4|o_447          |goed            |Unger                     |     NA|     NA|
|                 4|                NA|               NA|               NA|c_204          |3rd MLG          |                        4|o_449          |lptr            |Wilson                    |     NA|     NA|
|                 4|                NA|               NA|               NA|c_204          |3rd MLG          |                        4|o_452          |lsg3            |Zack                      |     NA|     NA|
|                 4|                NA|               NA|               NA|c_204          |3rd MLG          |                        4|o_453          |lgds            |Ades                      |     NA|     NA|
|                 4|                NA|               NA|               NA|c_204          |3rd MLG          |                        4|o_454          |jp1a            |Byron                     |     NA|     NA|
|                 4|                NA|               NA|               NA|c_204          |3rd MLG          |                        4|o_455          |zs4z            |Colgate                   |     NA|     NA|
|                 4|                NA|               NA|               NA|c_204          |3rd MLG          |                        4|o_456          |0izt            |Dyer                      |     NA|     NA|
|                 4|                NA|               NA|               NA|c_204          |3rd MLG          |                        4|o_457          |7-Jun           |Easton                    |     NA|     NA|
|                 4|                NA|               NA|               NA|c_204          |3rd MLG          |                        4|o_458          |jmhn            |Fox                       |     NA|     NA|
|                 4|                NA|               NA|               NA|c_204          |3rd MLG          |                        4|o_459          |zpzj            |Gauge                     |     NA|     NA|
|                 4|                NA|               NA|               NA|c_204          |3rd MLG          |                        4|o_460          |q5lj            |Hastings                  |     NA|     NA|
|                 4|                NA|               NA|               NA|c_204          |3rd MLG          |                        4|o_461          |rzj1            |Ides                      |     NA|     NA|
|                 4|                NA|               NA|               NA|c_204          |3rd MLG          |                        4|o_462          |hw3p            |James                     |     NA|     NA|
|                10|                 6|                1|                1|c_210          |Jax              |                        4|o_407          |wnaf            |Glover                    |      1|      1|
|                10|                13|                2|                2|c_210          |Jax              |                        4|o_414          |k1lv            |Nash                      |      2|      1|
|                10|                22|                4|                3|c_210          |Jax              |                        4|o_423          |vqdq            |Walker                    |      4|      1|
|                10|                32|                5|                4|c_210          |Jax              |                        4|o_433          |6zmz            |Grind                     |      5|      2|
|                16|                 8|                2|                1|c_216          |NMCSD            |                        4|o_409          |pb8x            |Ince                      |      2|      1|
|                16|                18|                5|                4|c_216          |NMCSD            |                        4|o_419          |pt9y            |Sutherland                |      5|      1|
|                16|                23|                4|                9|c_216          |NMCSD            |                        4|o_424          |d6hs            |Xiong                     |      4|      2|
|                16|                35|                3|                2|c_216          |NMCSD            |                        4|o_437          |ojoz            |Kippler                   |      3|      1|
|                20|                28|                2|                1|c_220          |1st MEU          |                        4|o_429          |85i6            |Coolie                    |      2|      3|
|                20|                33|               10|                3|c_220          |1st MEU          |                        4|o_434          |525l            |Hyer                      |     11|      1|
|                20|                38|                3|                2|c_220          |1st MEU          |                        4|o_440          |27vk            |Never                     |      3|      1|
|                20|                39|               11|                4|c_220          |1st MEU          |                        4|o_441          |ovvy            |Object                    |     12|      1|
|                17|                14|                3|                7|c_217          |NH 29P           |                        3|o_415          |cn7q            |Oliver                    |      3|      3|
|                17|                30|                1|                1|c_217          |NH 29P           |                        3|o_431          |6ust            |Estes                     |      1|      1|
|                17|                31|                2|                2|c_217          |NH 29P           |                        3|o_432          |785o            |Flag                      |      2|      2|
|                 2|                44|                1|                1|c_202          |NH Oki           |                        2|o_446          |wfv3            |Tut                       |      1|      1|
|                 3|                NA|               NA|               NA|c_203          |Oki MEU          |                        2|o_406          |m8w6            |Forsyth                   |     NA|     NA|
|                 3|                NA|               NA|               NA|c_203          |Oki MEU          |                        2|o_436          |0cot            |Jack                      |     NA|     NA|
|                 3|                NA|               NA|               NA|c_203          |Oki MEU          |                        2|o_447          |goed            |Unger                     |     NA|     NA|
|                 3|                NA|               NA|               NA|c_203          |Oki MEU          |                        2|o_449          |lptr            |Wilson                    |     NA|     NA|
|                 3|                NA|               NA|               NA|c_203          |Oki MEU          |                        2|o_452          |lsg3            |Zack                      |     NA|     NA|
|                 3|                NA|               NA|               NA|c_203          |Oki MEU          |                        2|o_453          |lgds            |Ades                      |     NA|     NA|
|                 3|                NA|               NA|               NA|c_203          |Oki MEU          |                        2|o_454          |jp1a            |Byron                     |     NA|     NA|
|                 3|                NA|               NA|               NA|c_203          |Oki MEU          |                        2|o_455          |zs4z            |Colgate                   |     NA|     NA|
|                 3|                NA|               NA|               NA|c_203          |Oki MEU          |                        2|o_456          |0izt            |Dyer                      |     NA|     NA|
|                 3|                NA|               NA|               NA|c_203          |Oki MEU          |                        2|o_457          |7-Jun           |Easton                    |     NA|     NA|
|                 3|                NA|               NA|               NA|c_203          |Oki MEU          |                        2|o_458          |jmhn            |Fox                       |     NA|     NA|
|                 3|                NA|               NA|               NA|c_203          |Oki MEU          |                        2|o_459          |zpzj            |Gauge                     |     NA|     NA|
|                 3|                NA|               NA|               NA|c_203          |Oki MEU          |                        2|o_460          |q5lj            |Hastings                  |     NA|     NA|
|                 3|                NA|               NA|               NA|c_203          |Oki MEU          |                        2|o_461          |rzj1            |Ides                      |     NA|     NA|
|                 3|                NA|               NA|               NA|c_203          |Oki MEU          |                        2|o_462          |hw3p            |James                     |     NA|     NA|
|                 5|                46|                1|                1|c_205          |NH Yoko          |                        2|o_450          |2w56            |Xiang                     |      1|      2|
|                 7|                 2|                6|                2|c_207          |Napl             |                        2|o_402          |kobl            |Bailey                    |      7|      1|
|                 7|                16|                3|               11|c_207          |Napl             |                        2|o_417          |s9l6            |Quinn                     |      3|      5|
|                13|                42|                4|                7|c_213          |2nd MLG          |                        2|o_444          |yk8a            |Rolls                     |      4|      3|
|                14|                10|                2|                2|c_214          |2nd MEU          |                        2|o_411          |2tb7            |Knox                      |      2|      1|
|                14|                12|                1|                1|c_214          |2nd MEU          |                        2|o_413          |5sjg            |Murray                    |      1|      1|
|                 1|                11|                2|                1|c_201          |Guam             |                        1|o_412          |9aa1            |Lambert                   |      2|      1|
|                 6|                NA|               NA|               NA|c_206          |Rota             |                        1|o_406          |m8w6            |Forsyth                   |     NA|     NA|
|                 6|                NA|               NA|               NA|c_206          |Rota             |                        1|o_436          |0cot            |Jack                      |     NA|     NA|
|                 6|                NA|               NA|               NA|c_206          |Rota             |                        1|o_447          |goed            |Unger                     |     NA|     NA|
|                 6|                NA|               NA|               NA|c_206          |Rota             |                        1|o_449          |lptr            |Wilson                    |     NA|     NA|
|                 6|                NA|               NA|               NA|c_206          |Rota             |                        1|o_452          |lsg3            |Zack                      |     NA|     NA|
|                 6|                NA|               NA|               NA|c_206          |Rota             |                        1|o_453          |lgds            |Ades                      |     NA|     NA|
|                 6|                NA|               NA|               NA|c_206          |Rota             |                        1|o_454          |jp1a            |Byron                     |     NA|     NA|
|                 6|                NA|               NA|               NA|c_206          |Rota             |                        1|o_455          |zs4z            |Colgate                   |     NA|     NA|
|                 6|                NA|               NA|               NA|c_206          |Rota             |                        1|o_456          |0izt            |Dyer                      |     NA|     NA|
|                 6|                NA|               NA|               NA|c_206          |Rota             |                        1|o_457          |7-Jun           |Easton                    |     NA|     NA|
|                 6|                NA|               NA|               NA|c_206          |Rota             |                        1|o_458          |jmhn            |Fox                       |     NA|     NA|
|                 6|                NA|               NA|               NA|c_206          |Rota             |                        1|o_459          |zpzj            |Gauge                     |     NA|     NA|
|                 6|                NA|               NA|               NA|c_206          |Rota             |                        1|o_460          |q5lj            |Hastings                  |     NA|     NA|
|                 6|                NA|               NA|               NA|c_206          |Rota             |                        1|o_461          |rzj1            |Ides                      |     NA|     NA|
|                 6|                NA|               NA|               NA|c_206          |Rota             |                        1|o_462          |hw3p            |James                     |     NA|     NA|
|                 8|                NA|               NA|               NA|c_208          |Sig              |                        1|o_406          |m8w6            |Forsyth                   |     NA|     NA|
|                 8|                NA|               NA|               NA|c_208          |Sig              |                        1|o_436          |0cot            |Jack                      |     NA|     NA|
|                 8|                NA|               NA|               NA|c_208          |Sig              |                        1|o_447          |goed            |Unger                     |     NA|     NA|
|                 8|                NA|               NA|               NA|c_208          |Sig              |                        1|o_449          |lptr            |Wilson                    |     NA|     NA|
|                 8|                NA|               NA|               NA|c_208          |Sig              |                        1|o_452          |lsg3            |Zack                      |     NA|     NA|
|                 8|                NA|               NA|               NA|c_208          |Sig              |                        1|o_453          |lgds            |Ades                      |     NA|     NA|
|                 8|                NA|               NA|               NA|c_208          |Sig              |                        1|o_454          |jp1a            |Byron                     |     NA|     NA|
|                 8|                NA|               NA|               NA|c_208          |Sig              |                        1|o_455          |zs4z            |Colgate                   |     NA|     NA|
|                 8|                NA|               NA|               NA|c_208          |Sig              |                        1|o_456          |0izt            |Dyer                      |     NA|     NA|
|                 8|                NA|               NA|               NA|c_208          |Sig              |                        1|o_457          |7-Jun           |Easton                    |     NA|     NA|
|                 8|                NA|               NA|               NA|c_208          |Sig              |                        1|o_458          |jmhn            |Fox                       |     NA|     NA|
|                 8|                NA|               NA|               NA|c_208          |Sig              |                        1|o_459          |zpzj            |Gauge                     |     NA|     NA|
|                 8|                NA|               NA|               NA|c_208          |Sig              |                        1|o_460          |q5lj            |Hastings                  |     NA|     NA|
|                 8|                NA|               NA|               NA|c_208          |Sig              |                        1|o_461          |rzj1            |Ides                      |     NA|     NA|
|                 8|                NA|               NA|               NA|c_208          |Sig              |                        1|o_462          |hw3p            |James                     |     NA|     NA|
|                11|                17|                1|                1|c_211          |Gitmo            |                        1|o_418          |bakn            |Rampling                  |      1|      2|
|                15|                24|                1|                1|c_215          |CBIRF            |                        1|o_425          |tb5t            |Young                     |      1|      1|
|                18|                21|                4|                2|c_218          |NH Pend          |                        1|o_422          |h8pg            |Vaughan                   |      4|      3|
|                NA|                25|               NA|               NA|c_ NA          |NA               |                       NA|o_426          |d2nz            |Zimmer                    |     NA|     NA|
|                NA|                27|               NA|               NA|c_ NA          |NA               |                       NA|o_428          |vzno            |Bell                      |     NA|     NA|
|                NA|                41|               NA|               NA|c_ NA          |NA               |                       NA|o_443          |yocg            |Quincy                    |     NA|     NA|
|                NA|                45|               NA|               NA|c_ NA          |NA               |                       NA|o_448          |nkql            |Vince                     |     NA|     NA|
|                NA|                47|               NA|               NA|c_ NA          |NA               |                       NA|o_451          |fjh2            |Yu                        |     NA|     NA|


### Desirability

Finally, the desirability of the the entities can be represented several ways.  Perhaps the simplest is plotting how each entity  ranked each other.  In the first graph, each column represents the rankings received by an officer; the diamond represents the officer's mean rank.  If all commands believed the officer was the best fit for them, all 20 blue dots (as well as the diamond) would be at $y$=1.  The second graph is similar, but reflects the desirability of each command, from the officer's perspective.  These blue points are distributed more evenly than in the real world, because the preference data was (simply) generated.

![](figure-png/graph-desirability-1.png)<!-- -->![](figure-png/graph-desirability-2.png)<!-- -->


Session Information
===========================================
We would like to address any questions or suggestions during any stage of the evaluation. Please contact [Richard C. Childers](mailto:richard.childers@navy.mil), CDR NPC, PERS-4415.

For the sake of documentation and reproducibility, the current report was rendered on a system using the following software.


```
Report rendered by wbeasley at 2016-12-26, 22:59 -0600
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
 [1] Rcpp_0.12.8              partitions_1.9-18        munsell_0.4.3           
 [4] colorspace_1.3-2         lattice_0.20-34          R6_2.2.0                
 [7] highr_0.6                dplyr_0.5.0.9000         stringr_1.1.0           
[10] plyr_1.8.4               tools_3.3.2              parallel_3.3.2          
[13] grid_3.3.2               lpSolve_5.6.13           gtable_0.2.0            
[16] DBI_0.5-1                USNavyBillets_0.1.1.9000 htmltools_0.3.5         
[19] matchingMarkets_0.3-3    yaml_2.1.14              lazyeval_0.2.0          
[22] rprojroot_1.1            digest_0.6.10            assertthat_0.1          
[25] tibble_1.2               gmp_0.5-12               rJava_0.9-8             
[28] tidyr_0.6.0              readr_1.0.0              evaluate_0.10           
[31] rmarkdown_1.3            labeling_0.3             stringi_1.1.2           
[34] scales_0.4.1             backports_1.0.4          polynom_1.3-9           
```
