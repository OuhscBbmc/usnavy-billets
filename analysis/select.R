# knitr::stitch_rmd(script="./analysis/select.R", output="./analysis/stitched-output/select.md")
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.

# ---- load-sources ------------------------------------------------------------

# ---- load-packages -----------------------------------------------------------
# Attach these packages so their functions don't need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
library(magrittr, quietly=TRUE)

# Verify these packages are available on the machine, but their functions need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
requireNamespace("matchingMarkets")
requireNamespace("readr")
requireNamespace("tidyr")
requireNamespace("dplyr") #Avoid attaching dplyr, b/c its function names conflict with a lot of packages (esp base, stats, and plyr).

# ---- declare-globals ---------------------------------------------------------
path_out_billet  <- "./data-phi-free/derived/billet.csv"
path_out_officer <- "./data-phi-free/derived/officer.csv"

# ---- load-data ---------------------------------------------------------------
# Read the CSVs
ds_billet_long   <- readr::read_csv(path_out_billet)
ds_officer_long  <- readr::read_csv(path_out_officer)

# ---- tweak-data --------------------------------------------------------------
ds_billet <- ds_billet_long %>%
  dplyr::mutate(
    billet_id  = sprintf("b_%03d", billet_id),
    officer_id = sprintf("o_%03d", officer_id)
  ) %>%
  tidyr::spread(key=officer_id, value=preference)

billet <- ds_billet %>%
  dplyr::select(-billet_id) %>%
  as.matrix()
row.names(billet) <- ds_billet$billet_id

ds_officer <- ds_officer_long %>%
  dplyr::mutate(
    billet_id = sprintf("b_%03d", billet_id),
    officer_id = sprintf("o_%03d", officer_id)
  ) %>%
  tidyr::spread(key=billet_id, value=preference)

officer <- ds_officer %>%
  dplyr::select(-officer_id) %>%
  as.matrix()
row.names(officer) <- ds_officer$officer_id
