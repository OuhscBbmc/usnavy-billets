# knitr::stitch_rmd(script="./manipulation/survey-ellis.R", output="./stitched-output/manipulation/survey-ellis.md") # dir.create(output="./stitched-output/manipulation/", recursive=T)
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.

# ---- load-sources ------------------------------------------------------------
# Call `base::source()` on any repo file that defines functions needed below.  Ideally, no real operations are performed.

# ---- load-packages -----------------------------------------------------------
# Attach these package(s) so their functions don't need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
library(magrittr            , quietly=TRUE)

# Verify these packages are available on the machine, but their functions need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
requireNamespace("readr"        )
requireNamespace("tidyr"        )
requireNamespace("dplyr"        ) # void attaching dplyr, b/c its function names conflict with a lot of packages (esp base, stats, and plyr).
requireNamespace("testit"       ) # or asserting conditions meet expected patterns.
requireNamespace("checkmate"    ) # or asserting conditions meet expected patterns. # devtools::install_github("mllg/checkmate")

# ---- declare-globals ---------------------------------------------------------
# Constant values that won't change.
path_raw                        <- "data-unshared/raw/Raw DM Survey 1 Results.csv"
path_derived                    <- "data-unshared/derived/survey-dm-1.csv"

col_types <- readr::cols_only(
    `Response ID` = readr::col_integer(),
  # `Date submitted` = readr::col_datetime(format = ""),
  # `Last page` = readr::col_integer(),
  # `Start language` = readr::col_character(),
  # `Date started` = readr::col_datetime(format = ""),
  # `Date last action` = readr::col_datetime(format = ""),
  # `What is your primary??specialty-` = readr::col_character(),
  # `What is your primary??specialty- [Other]` = readr::col_character(),
  # `What is your rank-` = readr::col_character(),
  # `What year did you??execute orders for your current billet-?? (Consider retour orders the same as a PCS set of orders.)` = readr::col_character(),
  # `What year did you??execute orders for your current billet-?? (Consider retour orders the same as a PCS set of orders.) [Other]` = readr::col_character(),
  # `How would you describe your current billet-` = readr::col_character(),
  # `How would you describe your current billet- [Other]` = readr::col_character(),
  # `For your last set of orders, how many months prior to your move were your orders released-?? That is, how many months did you have to prepare for your PCS-` = readr::col_character(),
  # `For your last set of orders, how many months prior to your move were your orders released-?? That is, how many months did you have to prepare for your PCS- [Other]` = readr::col_character(),
  `On a scale of 1 to 5, with 1 being not transparent and 5 being very transparent, how would you rate the transparency of your detailing experience for your last set of orders-` = readr::col_integer(),
  `On a scale of 1 to 5, with 1 being unsatisfied and 5 being very satisfied, how would you rate your overall??detailing experience for your last set of orders-` = readr::col_integer(),
  `On a scale of 1 to 5, with 1 representing a significant problem and 5 being not a problem at all, how would you rank the problem of favoritism in the billet assignment process-` = readr::col_integer(),
  `Describe your current assignment:` = readr::col_character()
  # `Describe your current assignment: [Other]` = readr::col_character()
  # `Please rank your desired billet locations with the top level being the most desireable, and the bottom being the least desireable. [Ranking 1]` = readr::col_character(),
  # `Please rank your desired billet locations with the top level being the most desireable, and the bottom being the least desireable. [Ranking 2]` = readr::col_character(),
  # `Please rank your desired billet locations with the top level being the most desireable, and the bottom being the least desireable. [Ranking 3]` = readr::col_character(),
  # `Please rank your desired billet locations with the top level being the most desireable, and the bottom being the least desireable. [Ranking 4]` = readr::col_character(),
  # `Please rank your desired billet locations with the top level being the most desireable, and the bottom being the least desireable. [Ranking 5]` = readr::col_character(),
  # `Please rank your desired billet locations with the top level being the most desireable, and the bottom being the least desireable. [Ranking 6]` = readr::col_character(),
  # `Please rank your desired billet locations with the top level being the most desireable, and the bottom being the least desireable. [Ranking 7]` = readr::col_character(),
  # `Please rank your desired billet locations with the top level being the most desireable, and the bottom being the least desireable. [Ranking 8]` = readr::col_character(),
  # `Please rank your desired billet locations with the top level being the most desireable, and the bottom being the least desireable. [Ranking 9]` = readr::col_character(),
  # `Which career path do you want to pursue in the next 5-10?? years-` = readr::col_character(),
  # `Which career path do you want to pursue in the next 5-10?? years- [Other]` = readr::col_character(),
  # `Neither the Army nor the Air Force have physicians in the detailer role.?? Instead, they have nurses or medical administrators work with specialty leaders to determine assigments.?? This is different from the current Navy Medical Corps billet assignment process where the detailer??is a physician*.?? Would you??approve if the detailer position was filled by a non-physician-` = readr::col_character(),
  # `Neither the Army nor the Air Force have physicians in the detailer role.?? Instead, they have nurses or medical administrators work with specialty leaders to determine assigments.?? This is different from the current Navy Medical Corps billet assignment process where the detailer??is a physician*.?? Would you??approve if the detailer position was filled by a non-physician- [Other]` = readr::col_character(),
  # `How long should an individual be allowed to remain at one command-` = readr::col_character(),
  # `How long should an individual be allowed to remain at one command- [Other]` = readr::col_character(),
  # `Do you think that there is a problem in the Medical Corps with members not moving-?? That is, are there too many physicians who get to stay in one place too long-` = readr::col_character(),
  # `Do you think that there is a problem in the Medical Corps with members not moving-?? That is, are there too many physicians who get to stay in one place too long- [Other]` = readr::col_character(),
  # `Civilian medical residency positions are assigned using the National Residency Match Program where members submit a preference list, residency directors submit a preference list, and a computer algorithm optimizes a match.?? This is different from the current Navy Medical Corps billet assignment process where the detailer and specialty leader take input from medical officers and then make a decision.?? Of these two options, which would you prefer for your military billet assignment-` = readr::col_character(),
  # `Civilian medical residency positions are assigned using the National Residency Match Program where members submit a preference list, residency directors submit a preference list, and a computer algorithm optimizes a match.?? This is different from the current Navy Medical Corps billet assignment process where the detailer and specialty leader take input from medical officers and then make a decision.?? Of these two options, which would you prefer for your military billet assignment- [Other]` = readr::col_character(),
  # `The later the match day, the more information one has before creating their rank list.?? The earlier the match day, the sooner one can have certainty and prepare.?? Assuming your were scheduled to??execute new orders in July of 2017, what month would you want the match to occur in-` = readr::col_character(),
  # `The later the match day, the more information one has before creating their rank list.?? The earlier the match day, the sooner one can have certainty and prepare.?? Assuming your were scheduled to??execute new orders in July of 2017, what month would you want the match to occur in- [Other]` = readr::col_character(),
  # `Do you think members who are coming from operational or OCONUS assignments should be given preference in billet assignment-` = readr::col_character(),
  # `Do you think members with more seniority (as defined by time in service or rank)??should be given preference in billet assignment-` = readr::col_character(),
  # `Any last thoughts or input regarding the billet assignment process-` = readr::col_character()
)

# ---- load-data ---------------------------------------------------------------
# Read the CSVs
ds <- readr::read_csv(path_raw, col_types=col_types)

rm(path_raw, col_types)

dim(ds)

# ---- tweak-data --------------------------------------------------------------
# OuhscMunge::column_rename_headstart(ds) #Spit out columns to help write call ato `dplyr::rename()`.
ds <- ds %>%
  dplyr::select_( #`select()` implicitly drops the other columns not mentioned.
    "response_id"                  = "`Response ID`"
    , "transparent"                = "`On a scale of 1 to 5, with 1 being not transparent and 5 being very transparent, how would you rate the transparency of your detailing experience for your last set of orders-`"
    , "satisfaction"               = "`On a scale of 1 to 5, with 1 being unsatisfied and 5 being very satisfied, how would you rate your overall??detailing experience for your last set of orders-`"
    , "favoritism"                 = "`On a scale of 1 to 5, with 1 representing a significant problem and 5 being not a problem at all, how would you rank the problem of favoritism in the billet assignment process-`"
    , "assignment_rank"            = "`Describe your current assignment:`"
    # , "assignment_rank2"         = "`Describe your current assignment: [Other]`"
  )  %>%
  dplyr::mutate(
    response_index        = sample.int(n(), replace=F),
    missing_item_count    = is.na(transparent) + is.na(satisfaction) + is.na(favoritism) + is.na(assignment_rank)
  ) %>%
  dplyr::mutate(
    assignment_rank_collapsed  = dplyr::recode(
      assignment_rank,
      "1st choice"        = 1L,
      "2nd choice"        = 2L,
      "3rd choice"        = 3L,
      "4th choice"        = 4L,
      "> 4th choice"      = 6L,
      "Other"             = NA_integer_
    )
  ) %>%
  dplyr::mutate(
    assignment_rank = dplyr::recode(
      assignment_rank,
      "1st choice"        = "1st",
      "2nd choice"        = "2nd",
      "3rd choice"        = "3rd",
      "4th choice"        = "4th",
      "> 4th choice"      = "5th+",
      "Other"             = "Other",
      .missing            = "Unknown"
    )
  ) %>%
  dplyr::arrange(response_index)
ds$assignment_rank_collapsed

table(ds$missing_item_count)

# ---- verify-values -----------------------------------------------------------
# Sniff out problems
checkmate::assert_integer(  ds$response_id              , lower=1L                  , any.missing=F, unique=T)
checkmate::assert_integer(  ds$response_index           , lower=1L, upper=nrow(ds)  , any.missing=F, unique=T)
checkmate::assert_integer(  ds$transparent              , lower=1L, upper=5L        , any.missing=T)
checkmate::assert_integer(  ds$satisfaction             , lower=1L, upper=5L        , any.missing=T)
checkmate::assert_integer(  ds$favoritism               , lower=1L, upper=5L        , any.missing=T)
checkmate::assert_character(ds$assignment_rank          , min.chars=3               , any.missing=F)
checkmate::assert_integer(  ds$assignment_rank_collapsed, lower=1L, upper=6L        , any.missing=T)
checkmate::assert_integer(  ds$missing_item_count       , lower=0L, upper=4L        , any.missing=F)

# ---- specify-columns-to-upload -----------------------------------------------
# dput(colnames(ds)) # Print colnames for line below.
columns_to_write <- c(
  "response_index",
  "transparent", "satisfaction", "favoritism",
  "assignment_rank", "assignment_rank_collapsed", "missing_item_count"
)
ds_slim <- ds %>%
  dplyr::select_(.dots=columns_to_write) %>%
  dplyr::mutate(
    # fte_approximated <- as.integer(fte_approximated)
  )
ds_slim

rm(columns_to_write)

# ---- save-to-disk ------------------------------------------------------------
# If there's no PHI, a rectangular CSV is usually adequate, and it's portable to other machines and software.
readr::write_csv(ds_slim, path_derived)
