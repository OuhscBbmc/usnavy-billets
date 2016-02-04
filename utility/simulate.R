# knitr::stitch_rmd(script="./utility/simulate.R", output="./utility/stitched-output/simulate.md")
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.

# ---- load-sources ------------------------------------------------------------

# ---- load-packages -----------------------------------------------------------
# Attach these packages so their functions don't need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
library(magrittr, quietly=TRUE)

# Verify these packages are available on the machine, but their functions need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
requireNamespace("readr")
requireNamespace("tidyr")
requireNamespace("dplyr") #Avoid attaching dplyr, b/c its function names conflict with a lot of packages (esp base, stats, and plyr).

# ---- declare-globals ---------------------------------------------------------
set.seed(245)
path_out_billet  <- "./data-phi-free/derived/billet.csv"
path_out_officer <- "./data-phi-free/derived/officer.csv"

# ---- load-data ---------------------------------------------------------------
# Read the CSVs
ds_billet_roster   <- readr::read_csv("./data-phi-free/raw/billet-roster.csv")
ds_officer_roster  <- readr::read_csv("./data-phi-free/raw/officer-roster.csv")

# ---- tweak-data --------------------------------------------------------------


# ---- expand ------------------------------------------------------------------
# tidyr::nesting(ds_billet_roster$billet_id  , ds_billet_roster$billet_name      ),
# tidyr::nesting(ds_officer_roster$officer_id, ds_officer_roster$office_name_last)

ds_billet <- expand.grid(
  billet_id  =  ds_billet_roster$billet_id,
  officer_id =  ds_officer_roster$officer_id,
  stringsAsFactors = FALSE
)

ds_officer <- expand.grid(
  officer_id =  ds_officer_roster$officer_id,
  billet_id  =  ds_billet_roster$billet_id,
  stringsAsFactors = FALSE
)

ds_billet <- ds_billet %>%
  dplyr::group_by(billet_id) %>%
  dplyr::mutate(
    preference = base::sample(ds_officer_roster$officer_id)
  ) %>%
  dplyr::ungroup() %>%
  dplyr::arrange(billet_id)

ds_officer <- ds_officer %>%
  dplyr::group_by(officer_id) %>%
  dplyr::mutate(
    preference = base::sample(ds_billet_roster$billet_id)
  ) %>%
  dplyr::ungroup() %>%
  dplyr::arrange(officer_id)

# ---- save-to-disk ------------------------------------------------------------
readr::write_csv(ds_billet , path_out_billet)
readr::write_csv(ds_officer, path_out_officer)
