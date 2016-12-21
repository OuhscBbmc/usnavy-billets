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


commmand_utility <- -matrix(as.integer(c(
  # 3, 3, 2,  # Officer 1
  # 2, 2, 1,  # Officer 2
  # 1, 4, 3,  # Officer 3
  # 4, 1, 4   # Officer 4

  1, 3, 2,  # Officer 1
  2, 1, 3,  # Officer 2
  3, 2, 1,  # Officer 3
  4, 4, 4   # Officer 4
)), ncol=3, byrow=TRUE)

officer_utility <- -matrix(as.integer(c(
  1, 3, 2, 2,  # Command 1
  2, 1, 3, 3,  # Command 2
  3, 2, 1, 1   # Command 3
)), ncol=4, byrow=TRUE)

command_preference <- matrix(as.integer(c(
  #1,  2,  3   # The 3 commands --each column represents a command's 4 preferences.
  1, 2, 3,  # Officer 1
  2, 3, 1,  # Officer 2
  3, 1, 2,  # Officer 3
  4, 4, 4   # Officer 4
)), ncol=3, byrow=TRUE)

officer_preference <- matrix(as.integer(c(
  #1,  2,  3,  4   # The 4 officers --each column represents an officer's 3 preferences.
  1, 2, 3, 3,  # Command 1
  2, 3, 1, 1,  # Command 2
  3, 1, 2, 2   # Command 3
)), ncol=4, byrow=TRUE)


testit::assert(
  "Command's conversion from utility to preference should be correct.",
  all.equal(
    target  = matchingR::sortIndex(commmand_utility) + 1,
    current = command_preference
  )
)
testit::assert(
  "Officer's conversion from utility to preference should be correct.",
  all.equal(
    target  = matchingR::sortIndex(officer_utility) + 1,
    current = officer_preference
  )
)



# ---- load-data ---------------------------------------------------------------

# ---- tweak-data --------------------------------------------------------------

# ---- match ------------------------------------------------------------------

matchingR::galeShapley.validate(
  reviewerPref = command_preference,
  proposerPref = officer_preference
)
matchingR::galeShapley.collegeAdmissions(
  collegePref = command_preference,
  studentPref = officer_preference,
  slots = 1
)

m <- matchingMarkets::hri(
  c.prefs = command_preference, #College/command preferences (each officer is a row)
  s.prefs = officer_preference, #Student/officer preferences (each command is a row)
  nSlots  =c(2,1,1)
)
print(m)

