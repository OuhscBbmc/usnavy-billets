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
path_out_command   <- "./data-phi-free/derived/command.csv"
path_out_officer   <- "./data-phi-free/derived/officer.csv"

# ---- load-data ---------------------------------------------------------------
# Read the CSVs
ds_command_roster  <- readr::read_csv("./data-phi-free/raw/command-roster.csv")
ds_officer_roster  <- readr::read_csv("./data-phi-free/raw/officer-roster.csv")

# ---- tweak-data --------------------------------------------------------------
ds_officer_roster <- ds_officer_roster %>%
  dplyr::select(-officer_name_last)

# ---- expand ------------------------------------------------------------------
# tidyr::nesting(ds_command_roster$command_id  , ds_command_roster$command_name      ),
# tidyr::nesting(ds_officer_roster$officer_id, ds_officer_roster$office_name_last)

ds_command <- expand.grid(
  command_id   =  ds_command_roster$command_id,
  officer_id   =  ds_officer_roster$officer_id,
  stringsAsFactors = FALSE
)

ds_officer <- expand.grid(
  officer_id   =  ds_officer_roster$officer_id,
  command_id   =  ds_command_roster$command_id,
  stringsAsFactors = FALSE
)

ds_command <- ds_command %>%
  dplyr::group_by(command_id) %>%
  dplyr::mutate(
    preference = base::sample(length(ds_officer_roster$officer_id))
  ) %>%
  dplyr::ungroup() %>%
  dplyr::arrange(command_id) %>%
  dplyr::left_join(ds_command_roster, by="command_id") %>%
  dplyr::left_join(ds_officer_roster, by="officer_id")

ds_officer <- ds_officer %>%
  dplyr::group_by(officer_id) %>%
  dplyr::mutate(
    preference = base::sample(length(ds_command_roster$command_id))
  ) %>%
  dplyr::ungroup() %>%
  dplyr::arrange(officer_id) %>%
  dplyr::left_join(ds_officer_roster, by="officer_id") %>%
  dplyr::left_join(ds_command_roster, by="command_id")

# ---- save-to-disk ------------------------------------------------------------
readr::write_csv(ds_command , path_out_command)
readr::write_csv(ds_officer, path_out_officer)
