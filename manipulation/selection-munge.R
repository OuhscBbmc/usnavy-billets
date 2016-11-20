rm(list=ls(all=TRUE))  #Clear the variables from previous runs.

# ---- load-sources ------------------------------------------------------------
# Call `base::source()` on any repo file that defines functions needed below.  Ideally, no real operations are performed.

# ---- load-packages -----------------------------------------------------------
# Attach these package(s) so their functions don't need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
library(magrittr, quietly=TRUE)

# Verify these packages are available on the machine, but their functions need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
requireNamespace("readr")
requireNamespace("tidyr")
requireNamespace("dplyr") #Avoid attaching dplyr, b/c its function names conflict with a lot of packages (esp base, stats, and plyr).
requireNamespace("testit") #For asserting conditions meet expected patterns.

# ---- declare-globals ---------------------------------------------------------
# Constant values that won't change.
path_in_command_roster              <- "data-phi-free/raw/command-roster.csv"
path_in_command_wide                <- "data-phi-free/raw/command-wide.csv"
path_out_command_wide               <- "data-phi-free/derived/command.csv"

# ---- load-data ---------------------------------------------------------------
# Read the CSVs
ds_command_roster      <- readr::read_csv(path_in_command_roster)
ds_command_wide        <- readr::read_csv(path_in_command_wide)

rm(path_in_command_roster, path_in_command_wide)

# Print the first few rows of each table, especially if you're stitching with knitr (see first line of this file).
#   If you print, make sure that the datasets don't contain any PHI.
#   A normal `data.frame` will print all rows.  But `readr::read_csv()` returns a `tibble::tibble`,
#   which prints only the first 10 rows by default.  It also lists the data type of each column.
ds_command_roster
ds_command_wide

# ---- tweak-data --------------------------------------------------------------
# ds_nurse_month_ruralOklahoma <- ds_nurse_month_rural[ds_nurse_month_rural$HOME_COUNTY=="Oklahoma", ]

# OuhscMunge::column_rename_headstart(ds_county) #Spit out columns to help write call ato `dplyr::rename()`.
# colnames(ds_command_wide)  <- make.names(colnames(ds_command_wide))

ds_command_long <- ds_command_wide %>%
  dplyr::rename_(
    "officer_id"     = "Code"
  ) %>%
  tidyr::gather(key=command_name, value=preference, -officer_id) %>%
  dplyr::mutate(
    preference    = dplyr::coalesce(preference, 0L)
  ) %>%
  dplyr::left_join(ds_command_roster, by="command_name") %>%
  dplyr::arrange(command_id, officer_id)

# ---- verify-values-command -----------------------------------------------------------
# Sniff out problems
testit::assert("The officer_id must be nonmissing.", all(!is.na(ds_command_long$officer_id)))
testit::assert("The command_name must be nonmissing.", all(!is.na(ds_command_long$command_name)))
testit::assert("The preference must be nonmissing.", all(!is.na(ds_command_long$preference)))
testit::assert("The command_id must be nonmissing.", all(!is.na(ds_command_long$command_id)))
testit::assert("The billet_count_max must be nonmissing.", all(!is.na(ds_command_long$billet_count_max)))
testit::assert("The officer_id-command_id combination should be unique.", all(!duplicated(paste(ds_command_long$officer_id, ds_command_long$command_id))))

# ---- specify-columns-to-upload -----------------------------------------------
# dput(colnames(ds_command_long)) # Print colnames for line below.
ds_command_long <- ds_command_long %>%
  dplyr::select_(.dots=c("command_id", "officer_id", "preference", "command_name", "billet_count_max"))

# ---- save-to-disk ------------------------------------------------------------
readr::write_csv(ds_command_long, path_out_command_wide)
