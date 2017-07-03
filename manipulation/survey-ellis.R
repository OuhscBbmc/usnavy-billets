# knitr::stitch_rmd(script="./manipulation/te-ellis.R", output="./stitched-output/manipulation/te-ellis.md") # dir.create(output="./stitched-output/manipulation/", recursive=T)
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
# path_raw                         <- "data-unshared/raw/ascii.csv"
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
    , "assignment_current_rank"    = "`Describe your current assignment:`"
    # , "assignment_current_rank2" = "`Describe your current assignment: [Other]`"
  )  %>%
  dplyr::mutate(
    missing_item_count    = is.na(transparent) + is.na(satisfaction) + is.na(favoritism) + is.na(assignment_current_rank)
  ) %>%
  dplyr::mutate(
    assignment_current_rank = dplyr::recode(
      assignment_current_rank,
      "1st choice"        = "1st",
      "2nd choice"        = "2nd",
      "3rd choice"        = "3rd",
      "4th choice"        = "4th",
      "> 4th choice"      = "5th+",
      "Other"             = "Other",
      .missing            = "Unknown"
    )
  )
table(ds$missing_item_count)

# ---- verify-values -----------------------------------------------------------
# Sniff out problems
checkmate::assert_integer(  ds$response_id              , lower=1L           , any.missing=F, unique=T)
checkmate::assert_integer(  ds$response_index           , lower=1L           , any.missing=F, unique=T)
checkmate::assert_integer(  ds$transparent              , lower=1L, upper=5L , any.missing=T)
checkmate::assert_integer(  ds$satisfaction             , lower=1L, upper=5L , any.missing=T)
checkmate::assert_integer(  ds$favoritism               , lower=1L, upper=5L , any.missing=T)
checkmate::assert_character(ds$assignment_current_rank  , min.chars=3        , any.missing=F)
checkmate::assert_integer(  ds$missing_item_count       , lower=0L, upper=4L , any.missing=F)

# ---- specify-columns-to-upload -----------------------------------------------
# dput(colnames(ds)) # Print colnames for line below.
columns_to_write <- c(
  "response_id",
  "transparent", "satisfaction", "favoritism",
  "assignment_current_rank", "missing_item_count"
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
readr::write_csv(ds, path_derived)


# ---- save-to-db --------------------------------------------------------------
# If there's no PHI, a local database like SQLite fits a nice niche if
#   * the data is relational and
#   * later, only portions need to be queried/retrieved at a time (b/c everything won't need to be loaded into R's memory)

sql_create_tbl_county <- "
  CREATE TABLE `tbl_county` (
  	county_id              INTEGER NOT NULL PRIMARY KEY,
    county_name            VARCHAR NOT NULL,
    region_id              INTEGER NOT NULL
  );"

sql_create_tbl_te_month <- "
  CREATE TABLE `tbl_te_month` (
  	county_month_id                    INTEGER NOT NULL PRIMARY KEY,
  	county_id                          INTEGER NOT NULL,
    month                              VARCHAR NOT NULL,         -- There's no date type in SQLite.  Make sure it's ISO8601: yyyy-mm-dd
    fte                                REAL    NOT NULL,
    fte_approximated                   REAL    NOT NULL,
    month_missing                      INTEGER NOT NULL,         -- There's no bit/boolean type in SQLite
    fte_rolling_median_11_month        INTEGER, --  NOT NULL

    FOREIGN KEY(county_id) REFERENCES tbl_county(county_id)
  );"

# Remove old DB
if( file.exists(path_db) ) file.remove(path_db)

# Open connection
cnn <- DBI::dbConnect(drv=RSQLite::SQLite(), dbname=path_db)
RSQLite::dbSendQuery(cnn, "PRAGMA foreign_keys=ON;") #This needs to be activated each time a connection is made. #http://stackoverflow.com/questions/15301643/sqlite3-forgets-to-use-foreign-keys
dbListTables(cnn)

# Create tables
dbSendQuery(cnn, sql_create_tbl_county)
dbSendQuery(cnn, sql_create_tbl_te_month)
dbListTables(cnn)

# Write to database
dbWriteTable(cnn, name='tbl_county',              value=ds_county,        append=TRUE, row.names=FALSE)
ds %>%
  dplyr::mutate(
    month               = strftime(month, "%Y-%m-%d"),
    fte_approximated    = as.logical(fte_approximated),
    month_missing       = as.logical(month_missing)
  ) %>%
  dplyr::select(county_month_id, county_id, month, fte, fte_approximated, month_missing, fte_rolling_median_11_month) %>%
  dbWriteTable(value=., conn=cnn, name='tbl_te_month', append=TRUE, row.names=FALSE)

# Close connection
dbDisconnect(cnn)

# # ---- upload-to-db ----------------------------------------------------------
# If there's PHI, write to a central database server that authenticates users (like SQL Server).
# (startTime <- Sys.time())
# dbTable <- "Osdh.tblC1TEMonth"
# channel <- RODBC::odbcConnect("te-example") #getSqlTypeInfo("Microsoft SQL Server") #;odbcGetInfo(channel)
#
# columnInfo <- RODBC::sqlColumns(channel, dbTable)
# varTypes <- as.character(columnInfo$TYPE_NAME)
# names(varTypes) <- as.character(columnInfo$COLUMN_NAME)  #varTypes
#
# RODBC::sqlClear(channel, dbTable)
# RODBC::sqlSave(channel, ds_slim, dbTable, append=TRUE, rownames=FALSE, fast=TRUE, varTypes=varTypes)
# RODBC::odbcClose(channel)
# rm(columnInfo, channel, columns_to_write, dbTable, varTypes)
# (elapsedDuration <-  Sys.time() - startTime) #21.4032 secs 2015-10-31


#Possibly consider writing to sqlite (with RSQLite) if there's no PHI, or a central database if there is PHI.

# ---- inspect, fig.width=10, fig.height=6, fig.path=figure_path -----------------------------------------------------------------
# This last section is kinda cheating, and should belong in an 'analysis' file, not a 'manipulation' file.
#   It's included here for the sake of demonstration.

library(ggplot2)

# Graph each county-month
ggplot(ds, aes(x=month, y=fte, group=factor(county_id), color=factor(county_id), shape=fte_approximated, ymin=0)) +
  geom_point(position=position_jitter(height=.05, width=5), size=4, na.rm=T) +
  # geom_text(aes(label=county_month_id)) +
  geom_line(position=position_jitter(height=.1, width=5)) +
  scale_shape_manual(values=c("TRUE"=21, "FALSE"=NA)) +
  theme_light() +
  guides(color = guide_legend(ncol=4, override.aes = list(size=3, alpha = 1))) +
  guides(shape = guide_legend(ncol=2, override.aes = list(size=3, alpha = 1))) +
  labs(title="FTE sum each month (by county)", y="Sum of FTE for County")

# Graph each region-month
ds_region <- ds %>%
  dplyr::group_by(region_id, month) %>%
  dplyr::summarize(
    fte              = sum(fte, na.rm=T),
    fte_approximated = any(fte_approximated)
  ) %>%
  dplyr::ungroup()

last_plot() %+%
  ds_region +
  aes(group=factor(region_id), color=factor(region_id)) +
  labs(title="FTE sum each month (by region)", y="Sum of FTE for Region")

# last_plot() +
#   aes(y=fmla_hours) +
#   labs(title="fmla_hours sum each month (by county)")
