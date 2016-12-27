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
1. The current demonstration covers 51 officers, 20 unique commands, and 54 total possible billets.  In the specialty of emergency medicine, the term "command" and "hospital" can almost be used interchangably.  Almost all commands are located in a single command, and each command/hospital can have multiple billets.
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
|        201|   -|   1|   -|   -|   -|   -|   -|   -|   -|   -|   -|   2|   -|   -|   -|   -|   -|   -|   3|   -|   -|   5|   -|   -|   -|   -|   -|   4|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|
|        202|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   2|   3|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   1|   -|   -|   -|   4|   -|
|        203|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   1|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|
|        204|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   1|   -|   2|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|
|        205|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   3|   -|   -|   2|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   1|   -|
|        206|   -|   3|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   1|   2|   -|   -|   -|   -|   -|   -|   -|   -|   -|   5|   6|   -|   -|   -|   -|   -|   3|   -|   4|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|
|        207|   -|   7|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   6|   -|   3|   2|   -|   -|   -|   -|   -|   -|   -|   8|   -|   -|   4|   5|   -|   -|   -|   -|   -|   -|   -|   1|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|
|        208|   9|   1|   -|   -|   -|   4|   -|   -|   -|   5|  10|   -|   -|   -|   3|   -|   -|   -|   -|   -|   -|   -|   -|   -|   2|   -|   -|   -|   -|   -|   8|   -|   -|   -|   -|   -|   -|   -|   -|   7|   6|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|
|        209|   7|   -|   -|   -|   6|   -|  14|   2|   9|   -|   -|   -|   -|   -|   -|   -|  12|   -|   -|   1|  13|   -|   -|   8|   -|   -|   5|  10|   -|   3|   -|   -|   -|   -|   -|   -|   -|   4|   -|   -|   -|   -|   -|  11|   -|   -|   -|   -|   -|   -|   -|
|        210|   -|   -|   -|   -|   -|   -|   1|   -|   -|   -|   -|   -|   -|   2|   6|   8|   -|   -|   -|   -|   -|   -|   4|   -|   -|   -|   -|   -|   -|   3|   -|   -|   5|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   9|   -|   7|   -|
|        211|   -|   2|   -|   -|   -|   -|   3|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   1|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   4|   -|   -|   -|   -|   -|   -|   -|   -|   -|
|        212|   6|   -|  10|   1|   3|   -|   -|   -|   -|   2|   -|   4|   -|   -|   -|   7|   -|   -|   -|   -|   9|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   8|  11|   -|   -|   -|   -|   -|   -|   5|   -|
|        213|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   1|   -|   -|   -|   3|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   2|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   4|   -|   -|   5|   -|   6|   -|   -|
|        214|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   2|   -|   1|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   4|   -|   3|   -|   -|
|        215|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   1|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   2|   -|   3|   -|   -|
|        216|   -|   -|   -|   -|   -|   -|   -|   -|   2|   -|   -|   -|   -|   -|   -|   -|   7|   -|   5|   -|   -|   -|   9|   4|   1|   8|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   3|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   6|
|        217|   -|   -|   7|   -|   -|   -|   -|   -|   -|  10|   -|   -|   -|   -|   3|  13|   5|   6|   -|   -|   -|   9|   -|   -|   -|   -|   -|   -|   -|   -|   1|   2|   4|   8|   -|   -|   -|   -|   -|  12|  11|   -|   -|   -|   -|   -|   -|   -|   -|   -|  14|
|        218|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   2|   -|   -|   4|   -|   -|   -|   -|   -|   -|   -|   -|   1|   -|   -|   3|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|
|        219|   -|   -|   -|   -|   -|   -|   -|   -|   -|   3|   9|   7|   -|   -|   1|   6|   -|   -|   -|   -|  10|   -|   -|   -|   -|   -|   -|   -|   -|   -|   8|   -|   -|  11|   2|   -|   -|   -|   4|   -|   -|   -|   -|   -|   5|   -|   -|   -|   -|   -|   -|
|        220|   -|   -|   -|   -|  13|   -|   -|   -|   -|   8|  15|   7|  10|   -|  16|   -|   -|   -|   -|   -|  14|   -|   -|   -|   -|   -|   -|   -|   2|   -|   1|   5|   -|  11|   9|   -|   -|   -|   6|   3|  12|   -|   -|   -|   4|   -|   -|   -|   -|   -|   -|



### Input Provided from Each Officer



| student_id| 201| 202| 203| 204| 205| 206| 207| 208| 209| 210| 211| 212| 213| 214| 215| 216| 217| 218| 219| 220|
|----------:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
|        401|   -|   -|   -|   -|   -|   -|   -|   -|   1|   5|   -|   2|   3|   4|   -|   6|   -|   -|   -|   -|
|        402|   4|   -|   -|   -|   -|   2|   1|   3|   -|   -|   5|   -|   -|   -|   -|   -|   -|   -|   -|   -|
|        403|   3|   4|   -|   -|   -|   -|   -|   -|   8|   1|   -|   6|   -|   -|   -|   7|   5|   2|   -|   -|
|        404|   6|   -|   -|   -|   5|   4|   -|   -|   1|   -|   -|   3|   -|   -|   -|   2|   -|   -|   -|   -|
|        405|   -|   -|   -|   -|   -|   -|   -|   -|   1|   -|   -|   3|   -|   -|   -|   2|   -|   -|   5|   4|
|        406|   -|   -|   -|   -|   -|   -|   1|   -|   5|   2|   -|   3|   -|   8|   7|   6|   -|   4|   -|   -|
|        407|   -|   5|   6|   7|   4|   8|   9|   -|   3|   1|   2|   -|   -|   -|   -|   -|   -|   -|   -|   -|
|        408|   -|   -|   -|   -|   -|   -|   -|   -|   1|   -|   -|   2|   -|   -|   -|   -|   -|   -|   -|   -|
|        409|   -|   -|   -|   -|   -|   -|   -|   -|   2|   -|   -|   -|   -|   -|   -|   1|   -|   -|   -|   -|
|        410|   -|   -|   -|   -|   -|   -|   -|   -|   1|   -|   -|   4|   -|   -|   -|   2|   -|   -|   3|   -|
|        411|   -|   6|   -|   7|   -|   -|   -|   -|   -|   -|   -|   2|   3|   1|   -|   -|   -|   -|   5|   4|
|        412|   1|   2|   -|   -|   -|   -|   -|   -|   -|   3|   -|   6|   4|   5|   -|   -|   -|   9|   8|   7|
|        413|   -|   -|   4|   5|   -|   -|   -|   -|   -|   8|   -|   2|   3|   1|   -|   -|   -|   -|   7|   6|
|        414|   -|   -|   -|   -|   -|   -|   -|   -|   -|   1|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|
|        415|   -|   -|   -|   -|   -|   -|   6|   -|   -|   1|   -|   -|   -|   -|   2|   -|   3|   -|   4|   5|
|        416|   -|   -|   -|   -|   -|   -|   -|   -|   5|   1|   -|   2|   7|   -|   -|   6|   4|   3|   -|   -|
|        417|   -|   -|   -|   -|   -|   6|   5|   7|   3|   2|   -|   -|   -|   -|   -|   1|   8|   4|   -|   -|
|        418|   -|   -|   -|   -|   -|   4|   6|   -|   -|   5|   2|   -|   -|   -|   -|   -|   3|   1|   -|   -|
|        419|   -|   -|   -|   -|   5|   -|   -|   -|   3|   4|   -|   -|   -|   -|   -|   1|   -|   2|   -|   -|
|        420|   -|   -|   -|   -|   -|   -|   -|   -|   1|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|
|        421|   -|   -|   -|   -|   -|   -|   -|   -|   6|   5|   -|   7|   -|   -|   -|   1|   -|   2|   3|   4|
|        422|   1|   -|   -|   -|   4|   -|   -|   -|   -|   2|   -|   -|   -|   -|   -|   5|   -|   3|   -|   -|
|        423|   -|   -|   -|   -|   -|   -|   -|   -|   4|   1|   -|   5|   -|   -|   -|   2|   6|   3|   -|   -|
|        424|   -|   -|   -|   -|   -|   -|   -|   -|   1|   3|   -|   4|   -|   -|   -|   2|   6|   5|   -|   -|
|        425|   -|   -|   -|   -|   -|   -|   -|   -|   5|   2|   -|   -|   -|   -|   1|   3|   -|   4|   -|   -|
|        426|   -|   -|   -|   -|   -|   -|   4|   -|   -|   2|   -|   -|   -|   -|   -|   1|   -|   3|   -|   -|
|        427|   -|   -|   -|   -|   -|   -|   -|   -|   1|   -|   -|   2|   -|   -|   -|   -|   -|   -|   -|   -|
|        428|   -|   -|   -|   -|   -|   5|   6|   -|   2|   1|   -|   3|   -|   -|   -|   4|   -|   -|   -|   -|
|        429|   -|   -|   4|   2|   -|   -|   7|   -|   -|   -|   -|   -|   6|   5|   -|   -|   -|   -|   1|   3|
|        430|   -|   -|   -|   -|   -|   -|   -|   -|   1|   2|   -|   -|   -|   -|   -|   3|   -|   4|   -|   -|
|        431|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   1|   4|   2|   3|
|        432|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   3|   2|   1|   4|   5|
|        433|   -|   -|   -|   -|   -|   -|   -|   -|   5|   2|   -|   -|   -|   -|   -|   4|   3|   1|   -|   -|
|        434|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   2|   5|   3|   4|   1|
|        435|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   3|   1|   2|
|        436|   -|   -|   -|   -|   -|   -|   1|   2|   3|   -|   -|   -|   -|   -|   -|   -|   -|   4|   -|   -|
|        437|   -|   -|   -|   -|   -|   -|   -|   -|   2|   -|   -|   -|   -|   -|   -|   1|   -|   -|   -|   -|
|        438|   6|   -|   -|   -|   7|   3|   4|   5|   1|   2|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|
|        439|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   4|   -|   2|   1|   3|
|        440|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   3|   4|   -|   2|   1|
|        441|   5|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   4|   3|   2|   1|
|        442|   -|   -|   -|   -|   -|   -|   -|   -|   1|   3|   4|   2|   -|   -|   5|   -|   -|   -|   -|   -|
|        443|   -|   -|   -|   -|   -|   -|   -|   -|   5|   4|   -|   3|   -|   -|   -|   1|   7|   2|   -|   6|
|        444|   -|   -|   -|   -|   -|   -|   -|   -|   1|   5|   -|   4|   3|   2|   -|   6|   -|   -|   -|   -|
|        445|   -|   -|   -|   -|   -|   -|   -|   -|   5|   6|   -|   -|   -|   -|   -|   3|   4|   -|   1|   2|
|        446|   -|   1|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|   -|
|        447|   -|   -|   -|   -|   -|   -|   -|   -|   5|   1|   -|   3|   -|   -|   -|   2|   -|   4|   -|   -|
|        448|   -|   -|   -|   -|   -|   -|   -|   -|   5|   1|   8|   -|   -|   -|   7|   6|   -|   4|   2|   3|
|        449|   -|   -|   -|   -|   -|   -|   -|   -|   2|   1|   -|   4|   -|   -|   -|   3|   -|   -|   -|   -|
|        450|   1|   3|  10|   7|   2|   -|   -|   -|   -|   4|   -|   -|   9|  12|   -|   6|   -|   5|   8|  11|
|        451|   -|   -|   -|   -|   -|   -|   -|   -|   3|   4|   -|   5|   -|   -|   -|   1|   6|   2|   -|   -|

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
| 11| 10|  -| 12| 21| 18| 17| 24|  7| 13|  2|  9| 28| 10|  -|  8| 31| 18| 34| 28|
| 18| 11|  -|  -| 18|  2| 16| 14| 29| 29|  6|  5| 15|  -|  -| 35| 14| 33|  9| 38|
| 27| 46|  -|  -|  -| 36| 28|  9| 36| 22| 40| 11| 42|  -|  -| 23| 32| 21| 37| 43|
| 21|  -|  -|  -|  -| 28| 29| 39| 26| 32|  -| 46|  -|  -|  -| 18| 16|  -| 43| 31|
|  -|  -|  -|  -|  -| 29| 14| 38|  5| 14|  -|  1|  -|  -|  -| 47| 17|  -| 15| 37|
|  -|  -|  -|  -|  -|  -|  2| 30|  1| 46|  -| 15|  -|  -|  -| 16|  3|  -| 11| 11|
|  -|  -|  -|  -|  -|  -| 25|  1| 23| 15|  -| 40|  -|  -|  -| 25| 33|  -| 30|  9|
|  -|  -|  -|  -|  -|  -|  -| 10|  8| 45|  -| 20|  -|  -|  -| 22| 21|  -| 10| 34|
|  -|  -|  -|  -|  -|  -|  -|  -| 27|  -|  -|  3|  -|  -|  -|  -|  9|  -| 20| 12|
|  -|  -|  -|  -|  -|  -|  -|  -| 42|  -|  -| 41|  -|  -|  -|  -| 39|  -| 33| 33|
|  -|  -|  -|  -|  -|  -|  -|  -| 16|  -|  -|  -|  -|  -|  -|  -| 38|  -|  -| 39|
|  -|  -|  -|  -|  -|  -|  -|  -| 20|  -|  -|  -|  -|  -|  -|  -| 15|  -|  -|  5|
|  -|  -|  -|  -|  -|  -|  -|  -|  6|  -|  -|  -|  -|  -|  -|  -| 47|  -|  -| 20|
|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -| 10|
|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -| 14|

```


### Input Provided from Each Officer
```



|  1|  2|  3|  4|  5|  6|  7|  8|  9| 10| 11| 12| 13| 14| 15| 16| 17| 18| 19| 20| 21| 22| 23| 24| 25| 26| 27| 28| 29| 30| 31| 32| 33| 34| 35| 36| 37| 38| 39| 40| 41| 42| 43| 44| 45| 46| 47|
|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
|  9|  7| 10|  9|  9| 10|  9| 16|  9| 14|  1| 14| 10| 10| 10| 16| 18| 16|  9| 16|  1| 10|  9| 15| 16|  9| 10| 19|  9| 17| 18| 18| 20| 19| 16|  9| 19| 20| 20|  9| 16|  9| 19|  2| 10|  1| 16|
| 12|  6| 18| 16| 16| 11| 12|  9| 16| 12|  2| 12|  -| 15| 12| 10| 11| 18|  -| 18| 10| 16| 16| 10| 10| 12|  9|  4| 10| 19| 17| 10| 16| 20|  9| 10| 18| 19| 19| 12| 18| 14| 20|  -| 19|  5| 18|
| 13|  8|  1| 12| 12|  9|  -|  -| 19| 13| 10| 13|  -| 17| 18|  9| 17|  9|  -| 19| 18| 18| 10| 16| 18|  -| 12| 20| 16| 20| 16| 17| 18| 18|  -|  6| 20| 16| 18| 10| 12| 13| 16|  -| 20|  2|  9|
| 14|  1|  2|  6| 20|  5|  -|  -| 12| 20| 13|  3|  -| 19| 17| 18|  6| 10|  -| 20|  5|  9| 12| 18|  7|  -| 16|  3| 18| 18| 19| 16| 19|  -|  -|  7| 16| 17| 17| 11| 10| 12| 17|  -| 18| 10| 10|
| 10| 11| 17|  5| 19|  2|  -|  -|  -| 19| 14|  4|  -| 20|  9|  7| 10|  5|  -| 10| 16| 12| 18|  9|  -|  -|  6| 14|  -|  -| 20|  9| 17|  -|  -|  8|  -|  -|  1| 15|  9| 10|  9|  -|  9| 18| 12|
| 16|  -| 12|  1|  -|  3|  -|  -|  -|  2| 12| 20|  -|  7| 16|  6|  7|  -|  -|  9|  -| 17| 17|  -|  -|  -|  7| 13|  -|  -|  -|  -|  -|  -|  -|  1|  -|  -|  -|  -| 20| 16| 10|  -| 16| 16| 17|
|  -|  -| 16|  -|  -|  4|  -|  -|  -|  4| 20| 19|  -|  -| 13|  8|  -|  -|  -| 12|  -|  -|  -|  -|  -|  -|  -|  7|  -|  -|  -|  -|  -|  -|  -|  5|  -|  -|  -|  -| 17|  -|  -|  -| 15|  4|  -|
|  -|  -|  9|  -|  -|  6|  -|  -|  -|  -| 19| 10|  -|  -|  -| 17|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -| 11| 19|  -|
|  -|  -|  -|  -|  -|  7|  -|  -|  -|  -| 18|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -| 13|  -|
|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  3|  -|
|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -| 20|  -|
|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -|  -| 14|  -|

### Matches


The skinny table below shows the pairs of command--officer matches.  Notice that not all entities were matched.  This is because there were 54 total billets (across 20 unique commands), but 51 officers.  This is only the essential information.  See the following section for a comprehensive table.


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


| command<br/>index| officer<br/>index| command<br/>rank| officer<br/>rank|command<br/>id |command<br/>name | billet<br/>count<br/>max|officer<br/>id |officer<br/>tag |officer<br/>name<br/>last |
|-----------------:|-----------------:|----------------:|----------------:|:--------------|:----------------|------------------------:|:--------------|:---------------|:-------------------------|
|                 1|                11|                2|                1|c_201          |Guam             |                        1|o_412          |9aa1            |Lambert                   |
|                 2|                44|                1|                1|c_202          |NH Oki           |                        2|o_446          |wfv3            |Tut                       |
|                 5|                46|                1|                1|c_205          |NH Yoko          |                        2|o_450          |2w56            |Xiang                     |
|                 7|                 2|                6|                2|c_207          |Napl             |                        2|o_402          |kobl            |Bailey                    |
|                 7|                16|                3|               11|c_207          |Napl             |                        2|o_417          |s9l6            |Quinn                     |
|                 9|                 5|                6|                6|c_209          |NMCP             |                        6|o_405          |87cl            |Ellison                   |
|                 9|                 7|                2|                2|c_209          |NMCP             |                        6|o_408          |as5q            |Harris                    |
|                 9|                19|                1|                1|c_209          |NMCP             |                        6|o_420          |paed            |Taylor                    |
|                 9|                26|                5|                5|c_209          |NMCP             |                        6|o_427          |9je3            |Aikman                    |
|                 9|                29|                3|                3|c_209          |NMCP             |                        6|o_430          |zkff            |Dulles                    |
|                 9|                36|                4|                4|c_209          |NMCP             |                        6|o_438          |tun2            |Laurence                  |
|                10|                 6|                1|                1|c_210          |Jax              |                        4|o_407          |wnaf            |Glover                    |
|                10|                13|                2|                2|c_210          |Jax              |                        4|o_414          |k1lv            |Nash                      |
|                10|                22|                4|                3|c_210          |Jax              |                        4|o_423          |vqdq            |Walker                    |
|                10|                32|                5|                4|c_210          |Jax              |                        4|o_433          |6zmz            |Grind                     |
|                11|                17|                1|                1|c_211          |Gitmo            |                        1|o_418          |bakn            |Rampling                  |
|                12|                 1|                5|                8|c_212          |NHCL             |                        5|o_401          |xvxe            |Abraham                   |
|                12|                 3|                9|                8|c_212          |NHCL             |                        5|o_403          |x0qi            |Carr                      |
|                12|                 4|                1|                1|c_212          |NHCL             |                        5|o_404          |pd7n            |Davidson                  |
|                12|                15|                6|                7|c_212          |NHCL             |                        5|o_416          |1qhj            |Paige                     |
|                12|                40|                7|                4|c_212          |NHCL             |                        5|o_442          |bqrp            |Power                     |
|                13|                42|                4|                7|c_213          |2nd MLG          |                        2|o_444          |yk8a            |Rolls                     |
|                14|                10|                2|                2|c_214          |2nd MEU          |                        2|o_411          |2tb7            |Knox                      |
|                14|                12|                1|                1|c_214          |2nd MEU          |                        2|o_413          |5sjg            |Murray                    |
|                15|                24|                1|                1|c_215          |CBIRF            |                        1|o_425          |tb5t            |Young                     |
|                16|                 8|                2|                1|c_216          |NMCSD            |                        4|o_409          |pb8x            |Ince                      |
|                16|                18|                5|                4|c_216          |NMCSD            |                        4|o_419          |pt9y            |Sutherland                |
|                16|                23|                4|                9|c_216          |NMCSD            |                        4|o_424          |d6hs            |Xiong                     |
|                16|                35|                3|                2|c_216          |NMCSD            |                        4|o_437          |ojoz            |Kippler                   |
|                17|                14|                3|                7|c_217          |NH 29P           |                        3|o_415          |cn7q            |Oliver                    |
|                17|                30|                1|                1|c_217          |NH 29P           |                        3|o_431          |6ust            |Estes                     |
|                17|                31|                2|                2|c_217          |NH 29P           |                        3|o_432          |785o            |Flag                      |
|                18|                21|                4|                2|c_218          |NH Pend          |                        1|o_422          |h8pg            |Vaughan                   |
|                19|                 9|                3|                2|c_219          |1st MLG          |                        6|o_410          |5t8r            |Jones                     |
|                19|                20|                9|                5|c_219          |1st MLG          |                        6|o_421          |zaif            |Underwood                 |
|                19|                34|                2|                1|c_219          |1st MLG          |                        6|o_435          |cbku            |Instance                  |
|                19|                37|                4|                3|c_219          |1st MLG          |                        6|o_439          |ob7u            |Michaels                  |
|                19|                43|                5|                4|c_219          |1st MLG          |                        6|o_445          |fg86            |Sherman                   |
|                20|                28|                2|                1|c_220          |1st MEU          |                        4|o_429          |85i6            |Coolie                    |
|                20|                33|               10|                3|c_220          |1st MEU          |                        4|o_434          |525l            |Hyer                      |
|                20|                38|                3|                2|c_220          |1st MEU          |                        4|o_440          |27vk            |Never                     |
|                20|                39|               11|                4|c_220          |1st MEU          |                        4|o_441          |ovvy            |Object                    |


### Unmatched

There were 4 commands which didn't match to at least one officer.  Similarly, there were 9 officers which didn't match to at least one command.  


| command<br/>id|command<br/>name | billet<br/>count<br/>max| command<br/>index|
|--------------:|:----------------|------------------------:|-----------------:|
|            203|Oki MEU          |                        2|                 3|
|            204|3rd MLG          |                        4|                 4|
|            206|Rota             |                        1|                 6|
|            208|Sig              |                        1|                 8|



| officer<br/>id|officer<br/>tag |officer<br/>name<br/>last | officer<br/>index|
|--------------:|:---------------|:-------------------------|-----------------:|
|            406|m8w6            |Forsyth                   |                NA|
|            426|d2nz            |Zimmer                    |                25|
|            428|vzno            |Bell                      |                27|
|            436|0cot            |Jack                      |                NA|
|            443|yocg            |Quincy                    |                41|
|            447|goed            |Unger                     |                NA|
|            448|nkql            |Vince                     |                45|
|            449|lptr            |Wilson                    |                NA|
|            451|fjh2            |Yu                        |                47|


### Desirability

Finally, the desirability of the the entities can be represented several ways.  Perhaps the simplest is plotting how each entity  ranked each other.  In the first graph, each column represents the rankings received by an officer; the diamond represents the officer's mean rank.  If all commands believed the officer was the best fit for them, all 20 blue dots (as well as the diamond) would be at $y$=1.  The second graph is similar, but reflects the desirability of each command, from the officer's perspective.  These blue points are distributed more evenly than in the real world, because the preference data was (simply) generated.

![](figure-png/graph-desirability-1.png)<!-- -->![](figure-png/graph-desirability-2.png)<!-- -->


Session Information
===========================================
We would like to address any questions or suggestions during any stage of the evaluation. Please contact [Richard C. Childers](mailto:richard.childers@navy.mil), CDR NPC, PERS-4415.

For the sake of documentation and reproducibility, the current report was rendered on a system using the following software.


```
Report rendered by wbeasley at 2016-12-27, 00:20 -0600
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
