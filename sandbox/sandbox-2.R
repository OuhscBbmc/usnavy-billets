# knitr::stitch_rmd(script="./sandbox/sandbox-2.R", output="./stitched-output/sandbox/sandbox-2.md")
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.

# ---- load-sources ------------------------------------------------------------

# ---- load-packages -----------------------------------------------------------
# Run this line if necessary: install.packages(c("magrittr", "ggplot2", "matchingMarkets", "readr", "tidyr", "dplyr"))

# Attach these packages so their functions don't need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
library(magrittr      , quietly=TRUE)
library(ggplot2       , quietly=TRUE)

# Verify these packages are available on the machine, but their functions need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
requireNamespace("matchingMarkets"      , quietly=TRUE)  # devtools::install_version("matchingMarkets", version = "0.2-1", repos = "http://cran.us.r-project.org")
requireNamespace("readr"                , quietly=TRUE)
requireNamespace("tidyr"                , quietly=TRUE)
requireNamespace("dplyr"                , quietly=TRUE) #Avoid attaching dplyr, b/c its function names conflict with a lot of packages (esp base, stats, and plyr).

# ---- declare-globals ---------------------------------------------------------
# Constant values that won't change.

convert_utility_to_preference <- function( utility ) {
  apply(utility, 2, function( x ) {
    # Determine the order of (negative) values within a row.
    s <- sort.list(x, decreasing=T)

    # Re-establish the missing values.
    missing_indices <- which(is.na(x))
    ifelse(s %in% missing_indices, NA_integer_, s)
  })
}

# Each element is the rank (1 is the command's top choice).
commmand_utility <- -matrix(as.integer(c(
  # 3, 3, 2,  # Officer 1
  # 2, 2, 1,  # Officer 2
  # 1, 4, 3,  # Officer 3
  # 4, 1, 4   # Officer 4
#C1, C2, C3   # The 3 commands --each column represents a command's 4 preferences.
  1,  3,  2,  # Officer 1
  2,  1, NA,  # Officer 2
  3,  2,  1,  # Officer 3
  4,  4, NA   # Officer 4
)), ncol=3, byrow=TRUE)

# convert_utility_to_preference(commmand_utility)

# Each element is the rank (1 is the officer's top choice).
officer_utility <- -matrix(as.integer(c(
#O1, O2, O3, O4   # The 4 officers --each column represents an officer's 3 preferences
  1,  3,  2,  2,  # Command 1
  2,  1,  3, NA,  # Command 2
  3,  2,  1,  1   # Command 3
)), ncol=4, byrow=TRUE)


# Each element is the officer index/id
command_preference <- matrix(as.integer(c(
#C1,C2,C3   # The 3 commands --each column represents a command's 4 preferences.
  1, 2, 3,  # Preference 1
  2, 3, 1,  # Preference 2
  3, 1,NA,  # Preference 3
  4, 4,NA   # Preference 4
)), ncol=3, byrow=TRUE)

# Each element is the command index/id
officer_preference <- matrix(as.integer(c(
#O1, O2, O3, O4   # The 4 officers --each column represents an officer's 3 preferences
  1, 2, 3, 3,  # Preference 1
  2, 3, 1, 1,  # Preference 2
  3, 1, 2,NA   # Preference 3
)), ncol=4, byrow=TRUE)

convert_utility_to_preference(commmand_utility)
command_preference
testit::assert(
  "Command's conversion from utility to preference should be correct.",
  all.equal(
    target  = convert_utility_to_preference(commmand_utility),
    current = command_preference
  )
)

testit::assert(
  "Officer's conversion from utility to preference should be correct.",
  all.equal(
    target  = convert_utility_to_preference(officer_utility),
    current = officer_preference
  )
)


# ---- load-data ---------------------------------------------------------------

# ---- tweak-data --------------------------------------------------------------

# ---- match ------------------------------------------------------------------

m <- matchingMarkets::hri(
  c.prefs = command_preference, #College/command preferences (each officer is a row)
  s.prefs = officer_preference, #Student/officer preferences (each command is a row)
  nSlots  = c(2, 1, 1)
)
print(m)
