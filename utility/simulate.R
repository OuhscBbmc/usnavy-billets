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
path_out_hospital  <- "./data-phi-free/derived/hospital.csv"
path_out_officer   <- "./data-phi-free/derived/officer.csv"

# ---- load-data ---------------------------------------------------------------
# Read the CSVs
ds_hospital_roster <- readr::read_csv("./data-phi-free/raw/hospital-roster.csv")
ds_officer_roster  <- readr::read_csv("./data-phi-free/raw/officer-roster.csv")

# ---- tweak-data --------------------------------------------------------------


# ---- expand ------------------------------------------------------------------
# tidyr::nesting(ds_hospital_roster$hospital_id  , ds_hospital_roster$hospital_name      ),
# tidyr::nesting(ds_officer_roster$officer_id, ds_officer_roster$office_name_last)

ds_hospital <- expand.grid(
  hospital_id  =  ds_hospital_roster$hospital_id,
  officer_id   =  ds_officer_roster$officer_id,
  stringsAsFactors = FALSE
)

ds_officer <- expand.grid(
  officer_id   =  ds_officer_roster$officer_id,
  hospital_id  =  ds_hospital_roster$hospital_id,
  stringsAsFactors = FALSE
)

ds_hospital <- ds_hospital %>%
  dplyr::group_by(hospital_id) %>%
  dplyr::mutate(
    preference = base::sample(length(ds_officer_roster$officer_id))
  ) %>%
  dplyr::ungroup() %>%
  dplyr::arrange(hospital_id)

ds_officer <- ds_officer %>%
  dplyr::group_by(officer_id) %>%
  dplyr::mutate(
    preference = base::sample(length(ds_hospital_roster$hospital_id))
  ) %>%
  dplyr::ungroup() %>%
  dplyr::arrange(officer_id)

# ---- save-to-disk ------------------------------------------------------------
readr::write_csv(ds_hospital , path_out_hospital)
readr::write_csv(ds_officer, path_out_officer)
