# knitr::stitch_rmd(script="./sandbox/sandbox-1.R", output="./stitched-output/sandbox/sandbox-1.md")
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.

# ---- load-sources ------------------------------------------------------------

# ---- load-packages -----------------------------------------------------------
# Run this line if necessary: install.packages(c("magrittr", "ggplot2", "matchingMarkets", "readr", "tidyr", "dplyr"))

# Attach these packages so their functions don't need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
library(magrittr, quietly=TRUE)
library(ggplot2, quietly=TRUE)

# Verify these packages are available on the machine, but their functions need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
requireNamespace("matchingR")  # devtools::install_version("jtilly/matchingR")
# requireNamespace("matchingMarkets")  # devtools::install_version("matchingMarkets", version = "0.2-1", repos = "http://cran.us.r-project.org")
requireNamespace("readr")
requireNamespace("tidyr")
requireNamespace("dplyr") #Avoid attaching dplyr, b/c its function names conflict with a lot of packages (esp base, stats, and plyr).

# ---- declare-globals ---------------------------------------------------------
# Constant values that won't change.

command_transition <- matrix(c(
  #1,  2,  3   # The 3 commands --each column represents a command's 4 preferences.
  3L, 3L, 2L,  # Officer 1
  2L, 2L, 1L,  # Officer 2
  1L, 4L, 3L,  # Officer 3
  4L, 1L, 4L   # Officer 4
), ncol=3, byrow=TRUE)

officer_transition <- matrix(c(
  #1,  2,  3,  4   # The 4 officers --each column represents an officer's 3 preferences.
  2L, 3L, 1L, 3L,  # Command 1
  1L, 1L, 3L, 1L,  # Command 2
  3L, 2L, 2L, 2L   # Command 3
), ncol=4, byrow=TRUE)

# ---- load-data ---------------------------------------------------------------

# ---- tweak-data --------------------------------------------------------------

# ---- match ------------------------------------------------------------------

matchingR::galeShapley.validate(
  reviewerPref = command_transition,
  proposerPref = officer_transition
)
matchingR::galeShapley.collegeAdmissions(
  collegePref = command_transition,
  studentPref = officer_transition
)

# m <- matchingMarkets::hri(
#   c.prefs = command_transition, #College/command preferences (each officer is a row)
#   s.prefs = officer_transition, #Student/officer preferences (each command is a row)
#   nSlots  =c(1,1,1)
# )
# # print(m)
#
