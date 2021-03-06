# usnavy-billets

[![Build Status](https://travis-ci.org/OuhscBbmc/usnavy-billets.svg?branch=master)](https://travis-ci.org/OuhscBbmc/usnavy-billets)  [![Build status](https://ci.appveyor.com/api/projects/status/9prab5vvec9sa4ms?svg=true)](https://ci.appveyor.com/project/wibeasley/usnavy-billets)

This project explores possibilities of optimally assigning naval officers to billets.  The demonstration report is viewable in [this report](https://rawgit.com/OuhscBbmc/usnavy-billets/master/analysis/select-1/select-1.html) (or alternatively, this location hosted directly [within the repository](https://github.com/OuhscBbmc/usnavy-billets/blob/master/analysis/select-1/select-1.md).

The following survey adequately addresses the current project needs, which involves only a few dozen commands and officers in one specialty.  The survey framework would need to be generalized and scaled out, depending on the additional volume and types of specializations. https://bbmc.ouhsc.edu/redcap/surveys/?s=7XNAFK337W

**Notes**:

1. The project is under the initial direction of [Richard C. Childers](mailto:richard.childers@navy.mil), CDR NPC, PERS-4415, with advisement from [Alvin Roth](http://web.stanford.edu/~alroth/).
1. This demonstration was developed primarily by [Will Beasley](http://ouhsc.edu/bbmc/team/), Assistant Professor of Research, University of Oklahoma College of Medicine, [Department of Pediatrics](http://www.oumedicine.com/pediatrics).  The code developed for the billet marketplace project is open source and [available online](https://github.com/OuhscBbmc/usnavy-billets).  
1. The project members are appreciative of the open source [`matchingMarkets`](https://cran.r-project.org/package=matchingMarkets) R package, (independently developed by [Thilo Klein](https://github.com/thiloklein) since [2013](https://github.com/thiloklein/matchingMarkets/commits/master)) that implements the Gale-Shapley (1962) Deferred Acceptance Algorithm. For further discussion, see [Roth (2007) Deferred Acceptance Algorithms: History, Theory, Practice, and
Open Questions](https://dash.harvard.edu/bitstream/handle/1/2579651/Roth_Deferred%20Acceptance.pdf) and the [2012 Nobel Prize material](http://www.nobelprize.org/nobel_prizes/economic-sciences/laureates/2012/press.html).
1. Further information & Context: [Billets and Career Path](http://www.public.navy.mil/bupers-npc/officer/Detailing/IWC/IP/Pages/BilletsandCareerPath.aspx).

## Installation

This package can be installed from [GitHub](https://github.com/OuhscBbmc/usnavy-billets) after installing the `remotes` package.  Depending on your machine, you may have to first install some of the [dependencies](https://github.com/OuhscBbmc/usnavy-billets/blob/master/DESCRIPTION) (which are listed under the 'Imports', 'Suggests', and 'Remotes' headings).  The [rJava](https://CRAN.R-project.org/package=rJava) package is trickiest, because it relies on Java underneath; see that package's documentation for troubleshooting its installation.  

```r
install.packages("remotes") # Run this line if the 'remotes' package isn't installed already.
install.packages("rJava")
remotes::install_github(repo="thiloklein/matchingMarkets")
remotes::install_github(repo="OuhscBbmc/usnavy-billets", dependencies=TRUE)
```

Other installation resources include:
* The "What is a Package?" section in [*R Packages* by Hadley Wickham](http://r-pkgs.had.co.nz/package.html),
* [R Packages](https://www.datacamp.com/community/tutorials/r-packages-guide) on DataCamp,
* Troubleshooting [installing packages within RStudio](https://support.rstudio.com/hc/en-us/articles/200554786-Problem-Installing-Packages), and
* The [remotes](https://github.com/r-lib/remotes) package (which assumes some of the functionality of [devtools](https://github.com/r-lib/devtools).
