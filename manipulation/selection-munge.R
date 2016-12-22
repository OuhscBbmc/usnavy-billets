# knitr::stitch_rmd(script="./manipulation/selection-munge.R", output="./stitched-output/manipulation/selection-munge.md")
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.

# ---- load-sources ------------------------------------------------------------
# Call `base::source()` on any repo file that defines functions needed below.  Ideally, no real operations are performed.

# ---- load-packages -----------------------------------------------------------
# Attach these package(s) so their functions don't need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
library(magrittr, quietly=TRUE)

# Verify these packages are available on the machine, but their functions need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
requireNamespace("readr"         , quietly=TRUE)
requireNamespace("tidyr"         , quietly=TRUE)
requireNamespace("dplyr"         , quietly=TRUE) #Avoid attaching dplyr, b/c its function names conflict with a lot of packages (esp base, stats, and plyr).
requireNamespace("testit"        , quietly=TRUE) #For asserting conditions meet expected patterns.

# ---- declare-globals ---------------------------------------------------------
# Constant values that won't change.
set.seed(43) #So the random sampling won't change.
path_in_command_roster              <- "data-phi-free/raw/command-roster.csv"
path_in_command_wide                <- "data-phi-free/raw/command-wide.csv"
path_out_command_wide               <- "data-phi-free/derived/command.csv"

path_in_officer_roster              <- "data-phi-free/raw/officer-roster.csv"
path_in_officer_wide                <- "data-phi-free/raw/officer-wide.csv"
path_out_officer_wide               <- "data-phi-free/derived/officer.csv"

# ---- load-data ---------------------------------------------------------------
# Read the CSVs
ds_command_roster      <- readr::read_csv(path_in_command_roster)
ds_command_wide        <- readr::read_csv(path_in_command_wide)

ds_officer_roster      <- readr::read_csv(path_in_officer_roster)
ds_officer_wide        <- readr::read_csv(path_in_officer_wide)

rm(path_in_command_roster, path_in_command_wide)
rm(path_in_officer_roster, path_in_officer_wide)

# Print the first few rows of each table, especially if you're stitching with knitr (see first line of this file).
#   If you print, make sure that the datasets don't contain any PHI.
ds_command_roster
ds_command_wide
ds_officer_roster
ds_officer_wide

# ---- tweak-data --------------------------------------------------------------
# OuhscMunge::column_rename_headstart(ds_county) #Spit out columns to help write call ato `dplyr::rename()`.
# colnames(ds_command_wide)  <- make.names(colnames(ds_command_wide))

ds_command_long <- ds_command_wide %>%
  dplyr::rename_(
    "officer_id"     = "Code"
  ) %>%
  tidyr::gather(key=command_name, value=preference, -officer_id) %>%
  dplyr::left_join(ds_command_roster, by="command_name") %>%
  dplyr::arrange(command_id, officer_id)

ds_officer_long <- ds_officer_wide %>%
  dplyr::rename_(
    "officer_id"     = "Code"
  ) %>%
  tidyr::gather(key=command_name, value=preference, -officer_id) %>%
  dplyr::left_join(
    ds_command_roster %>%
      dplyr::select(command_id, command_name),
    by="command_name"
  ) %>%
  dplyr::left_join(ds_officer_roster, by="officer_id") %>%
  dplyr::arrange(command_id, officer_id)

# ---- verify-values-command -----------------------------------------------------------
# Sniff out problems
testit::assert("The officer_id must be nonmissing.", all(!is.na(ds_command_long$officer_id)))
testit::assert("The command_name must be nonmissing.", all(!is.na(ds_command_long$command_name)))
testit::assert("The preference must be nonmissing.", all(!is.na(ds_command_long$preference)))
testit::assert("The command_id must be nonmissing.", all(!is.na(ds_command_long$command_id)))
testit::assert("The billet_count_max must be nonmissing.", all(!is.na(ds_command_long$billet_count_max)))
testit::assert("The officer_id-command_id combination should be unique.", all(!duplicated(paste(ds_command_long$officer_id, ds_command_long$command_id))))
testit::assert("The command_id-preference combination should be unique.", all(!duplicated(paste(ds_command_long$command_id, ds_command_long$preference))))

# ---- verify-values-officer -----------------------------------------------------------
# Sniff out problems
testit::assert("The officer_id must be nonmissing.", all(!is.na(ds_officer_long$officer_id)))
testit::assert("The command_name must be nonmissing.", all(!is.na(ds_officer_long$command_name)))
testit::assert("The preference must be nonmissing.", all(!is.na(ds_officer_long$preference)))
testit::assert("The command_id must be nonmissing.", all(!is.na(ds_officer_long$command_id)))
testit::assert("The officer_id-command_id combination should be unique.", all(!duplicated(paste(ds_officer_long$officer_id, ds_officer_long$command_id))))
testit::assert("The officer_id-preference combination should be unique.", all(!duplicated(paste(ds_officer_long$officer_id, ds_officer_long$preference))))
as.data.frame(ds_officer_long[duplicated(paste(ds_officer_long$officer_id, ds_officer_long$preference)), ])

# ---- specify-columns-to-upload -----------------------------------------------
# dput(colnames(ds_command_long)) # Print colnames for line below.
ds_command_long <- ds_command_long %>%
  dplyr::select_(.dots=c("command_id", "officer_id", "preference"))#, "command_name", "billet_count_max"))
ds_officer_long <- ds_officer_long %>%
  dplyr::select_(.dots=c("command_id", "officer_id", "preference"))#, "officer_tag" , "officer_name_last"))

# ---- save-to-disk ------------------------------------------------------------
readr::write_csv(ds_command_long, path_out_command_wide)
readr::write_csv(ds_officer_long, path_out_officer_wide)
