# knitr::stitch_rmd(script="./manipulation/selection-munge.R", output="./stitched-output/manipulation/selection-munge.md")
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
set.seed(43) #So the random sampling won't change.
path_in_command_roster              <- "data-phi-free/raw/2018/command-roster.csv"
path_in_command_wide                <- "data-phi-free/raw/2018/command-wide.csv"
path_out_command_wide               <- "data-phi-free/derived/command.csv"

path_in_officer_roster              <- "data-phi-free/raw/2018/officer-roster.csv"
path_in_officer_wide                <- "data-phi-free/raw/2018/officer-wide.csv"
path_out_officer_wide               <- "data-phi-free/derived/officer.csv"

col_types_command_roster <- readr::cols_only(
  command_id          = readr::col_integer(),
  command_name        = readr::col_character(),
  billet_count_max    = readr::col_integer()
)
col_types_officer_roster <- readr::cols_only(
  officer_id          = readr::col_integer(),
  officer_tag         = readr::col_character(),
  officer_name_last   = readr::col_character()
)

col_types_wide <- readr::cols(
  .default = readr::col_integer()
)

# ---- load-data ---------------------------------------------------------------
# Read the CSVs
ds_command_roster      <- readr::read_csv(path_in_command_roster, col_types=col_types_command_roster)
ds_command_wide        <- readr::read_csv(path_in_command_wide,   col_types=col_types_wide)

ds_officer_roster      <- readr::read_csv(path_in_officer_roster, col_types=col_types_officer_roster)
ds_officer_wide        <- readr::read_csv(path_in_officer_wide,   col_types=col_types_wide)

rm(path_in_command_roster, col_types_command_roster)
rm( path_in_command_wide)
rm(path_in_officer_roster, col_types_officer_roster)
rm(path_in_officer_wide, col_types_wide)

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
  tidyr::gather(key=command_name, value=rank, -officer_id) %>%
  dplyr::left_join(ds_command_roster, by="command_name") %>%
  dplyr::arrange(command_id, officer_id)

ds_officer_long <- ds_officer_wide %>%
  dplyr::rename_(
    "officer_id"     = "Code"
  ) %>%
  tidyr::gather(key=command_name, value=rank, -officer_id) %>%
  dplyr::left_join(
    ds_command_roster %>%
      dplyr::select(command_id, command_name),
    by="command_name"
  ) %>%
  dplyr::left_join(ds_officer_roster, by="officer_id") %>%
  dplyr::arrange(command_id, officer_id)


# ---- verify-not-all-missing --------------------------------------------------
ds_command_missing_ranks <- ds_command_long %>%
  dplyr::group_by(command_id) %>%
  dplyr::summarize(
    nonmissing_rank_count  = sum(!is.na(rank))
  ) %>%
  dplyr::ungroup() %>%

  dplyr::filter(nonmissing_rank_count == 0L)

ds_officer_missing_ranks <- ds_officer_long %>%
  dplyr::group_by(officer_id) %>%
  dplyr::summarize(
    nonmissing_rank_count  = sum(!is.na(rank))
  ) %>%
  dplyr::ungroup() %>%
  # as.data.frame() %>%
  dplyr::filter(nonmissing_rank_count == 0L)

testit::assert("All commands should rank at least one officer.", nrow(ds_command_missing_ranks) == 0L)
testit::assert("All officers should rank at least one command.", nrow(ds_officer_missing_ranks) == 0L)


# ---- verify-values-command -----------------------------------------------------------
# Sniff out problems
testit::assert("The officer_id must be nonmissing.", all(!is.na(ds_command_long$officer_id)))
testit::assert("The command_name must be nonmissing.", all(!is.na(ds_command_long$command_name)))
# testit::assert("The rank must be nonmissing.", all(!is.na(ds_command_long$rank)))
testit::assert("The command_id must be nonmissing.", all(!is.na(ds_command_long$command_id)))
testit::assert("The billet_count_max must be nonmissing.", all(!is.na(ds_command_long$billet_count_max)))
testit::assert("The officer_id-command_id combination should be unique.", all(!duplicated(paste(ds_command_long$officer_id, ds_command_long$command_id))))
# testit::assert("The command_id-rank combination should be unique.", all(!duplicated(paste(ds_command_long$command_id, ds_command_long$rank))))

# ---- verify-values-officer -----------------------------------------------------------
# Sniff out problems
testit::assert("The officer_id must be nonmissing.", all(!is.na(ds_officer_long$officer_id)))
testit::assert("The command_name must be nonmissing.", all(!is.na(ds_officer_long$command_name)))
# testit::assert("The rank must be nonmissing.", all(!is.na(ds_officer_long$rank)))
testit::assert("The command_id must be nonmissing.", all(!is.na(ds_officer_long$command_id)))
testit::assert("The officer_id-command_id combination should be unique.", all(!duplicated(paste(ds_officer_long$officer_id, ds_officer_long$command_id))))
# testit::assert("The officer_id-rank combination should be unique.", all(!duplicated(paste(ds_officer_long$officer_id, ds_officer_long$rank))))
as.data.frame(ds_officer_long[duplicated(paste(ds_officer_long$officer_id, ds_officer_long$rank)), ])

# ---- specify-columns-to-upload -----------------------------------------------
# dput(colnames(ds_command_long)) # Print colnames for line below.
ds_command_long <- ds_command_long %>%
  dplyr::select_(.dots=c("command_id", "officer_id", "rank"))#, "command_name", "billet_count_max"))
ds_officer_long <- ds_officer_long %>%
  dplyr::select_(.dots=c("command_id", "officer_id", "rank"))#, "officer_tag" , "officer_name_last"))

# ---- save-to-disk ------------------------------------------------------------
readr::write_csv(ds_command_long, path_out_command_wide)
readr::write_csv(ds_officer_long, path_out_officer_wide)
