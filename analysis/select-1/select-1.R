# knitr::stitch_rmd(script="./analysis/select.R", output="./analysis/stitched-output/select.md")
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.

# ---- load-sources ------------------------------------------------------------

# ---- load-packages -----------------------------------------------------------
# Run this line if necessary: install.packages(c("magrittr", "ggplot2", "matchingMarkets", "readr", "tidyr", "dplyr"))

# Attach these packages so their functions don't need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
library(magrittr, quietly=TRUE)
library(ggplot2, quietly=TRUE)

# Verify these packages are available on the machine, but their functions need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
requireNamespace("matchingMarkets")  # devtools::install_version("matchingMarkets", version = "0.2-1", repos = "http://cran.us.r-project.org")
requireNamespace("readr")
requireNamespace("tidyr")
requireNamespace("dplyr") #Avoid attaching dplyr, b/c its function names conflict with a lot of packages (esp base, stats, and plyr).

# ---- declare-globals ---------------------------------------------------------
path_in_roster_command    <- "./data-phi-free/raw/command-roster.csv"
path_in_roster_officer    <- "./data-phi-free/raw/officer-roster.csv"
path_in_command           <- "./data-phi-free/derived/command.csv"
path_in_officer           <- "./data-phi-free/derived/officer.csv"

col_types_command <- readr::cols_only(
  command_id          = readr::col_integer(),
  officer_id          = readr::col_integer(),
  preference          = readr::col_integer()
)

col_types_officer <- readr::cols_only(
  command_id        = readr::col_integer(),
  officer_id        = readr::col_integer(),
  preference        = readr::col_integer()
)

col_types_roster_command <- readr::cols_only(
  command_id         = readr::col_integer(),
  command_name       = readr::col_character(),
  billet_count_max   = readr::col_integer()
)

col_types_roster_officer <- readr::cols_only(
  officer_id         = readr::col_integer(),
  officer_tag        = readr::col_character(),
  officer_name_last  = readr::col_character()
)

# ---- load-data ---------------------------------------------------------------
# Read the CSVs
ds_command_long    <- readr::read_csv(path_in_command       , col_types=col_types_command       ) #Ranked by the commands
ds_officer_long    <- readr::read_csv(path_in_officer       , col_types=col_types_officer       ) #Ranked by the officers

ds_command_roster  <- readr::read_csv(path_in_roster_command, col_types=col_types_roster_command)
ds_officer_roster  <- readr::read_csv(path_in_roster_officer, col_types=col_types_roster_officer)

# ---- tweak-data --------------------------------------------------------------
# OuhscMunge::column_rename_headstart(ds_officer_long)

ds_command_roster$command_index   <- seq_len(nrow(ds_command_roster))
ds_officer_roster$officer_index   <- seq_len(nrow(ds_officer_roster))

ds_command <- ds_command_long %>%
  dplyr::select_(
    "command_id"              = "`command_id`"
    , "officer_id"            = "`officer_id`"
    , "preference"            = "`preference`"
  ) %>%
  dplyr::mutate(
    command_id   = sprintf("c_%03d", command_id),
    officer_id   = sprintf("o_%03d", officer_id)
  ) %>%
  tidyr::spread(key=command_id, value=preference)

command <- ds_command %>%
  dplyr::select(-officer_id) %>%
  as.matrix()
row.names(command) <- ds_command$officer_id

ds_officer <- ds_officer_long %>%
  dplyr::select_(
    "command_id"              = "`command_id`"
    , "officer_id"            = "`officer_id`"
    , "preference"            = "`preference`"
  ) %>%
  dplyr::mutate(
    command_id   = sprintf("c_%03d", command_id),
    officer_id   = sprintf("o_%03d", officer_id)
  ) %>%
  tidyr::spread(key=officer_id, value=preference)

officer <- ds_officer %>%
  dplyr::select(-command_id) %>%
  as.matrix()
row.names(officer) <- ds_officer$command_id

ds_command_long  <- dplyr::rename_(ds_command_long, "preference_from_command"="preference")
ds_officer_long  <- dplyr::rename_(ds_officer_long, "preference_from_officer"="preference")

# ---- transpose-transitions ------------------------------------------------------------------
library(dplyr)
transpose_transition_frame <- function( d2, id_name ) {
  # browser()
  d <- as.data.frame(t(d2), stringsAsFactors = FALSE)
  colnames(d) <- as.character(d[1, ])
  # d <- d[-1, ] #Drop the first row (which became column headers)
  d <- d %>%
    tibble::rownames_to_column(id_name) %>%
    dplyr::slice(-1) %>%  #Drop the first row (which became column headers)
    dplyr::mutate_each(dplyr::funs(as.integer), starts_with("^o_\\d+$"))
  return( d )
}
ds_command_transition  <- transpose_transition_frame(ds_command, id_name="command_id")
ds_officer_transition  <- transpose_transition_frame(ds_officer, id_name="officer_id")
detach("package:dplyr", character.only = TRUE)

# ---- rankings-raw ------------------------------------------------------------------
cat("\n\n### Input Provided from Each Command\n\n")
ds_command_transition %>%
  knitr::kable(format="markdown", align='r')

cat("\n\n### Input Provided from Each Officer\n\n")
ds_officer_transition %>%
  knitr::kable(format="markdown", align='r')

# ---- match ------------------------------------------------------------------
m <- matchingMarkets::daa(
  c.prefs = command, #College/command preferences (each officer is a row)
  s.prefs = officer, #Student/officer preferences (each command is a row)
  nSlots  = ds_command_roster$billet_count_max
)
# print(m)

m$edgelist %>%
  dplyr::mutate(
    students         = ifelse(students==0, "*not matched*", students),
    colleges         = ifelse(colleges==0, "*not matched*", colleges)
  ) %>%
  dplyr::rename_(
    "command<br/>index"    = "colleges",
    "officer<br/>index"    = "students"
  ) %>%
  knitr::kable(
    format       = "markdown"
  )

# ---- display ------------------------------------------------------------------
ds_edge <- m$edgelist %>%
  tibble::as_tibble() %>%
  dplyr::rename(
    command_index   = colleges,
    officer_index   = students
  ) %>%
  dplyr::right_join(ds_command_roster, by="command_index") %>%
  dplyr::right_join(ds_officer_roster, by="officer_index" ) %>%
  dplyr::left_join(ds_command_long, by=c("command_id", "officer_id")) %>%
  dplyr::left_join(ds_officer_long, by=c("command_id", "officer_id")) %>%
  dplyr::arrange(desc(billet_count_max), command_id) %>%
  dplyr::mutate(
    command_id   = sprintf("c_%03d", command_id),
    officer_id   = sprintf("o_%03d", officer_id)
  )

ds_edge %>%
  knitr::kable(
    col.names    = gsub("_", "<br/>", colnames(ds_edge)),
    format       = "markdown"
  )

# ---- graph-desirability ------------------------------------------------------------------
set.seed(23) #For the sake of keeping the jittering constant between runs.
ggplot(ds_command_long, aes(x=officer_id, y=preference_from_command))  +
  stat_summary(fun.y="mean", geom="point", shape=23, size=5, fill="white", alpha=.3, na.rm=T) + #See Chang (2013), Recipe 6.8.
  geom_point(shape=21, color="royalblue", fill="skyblue", alpha=.2, position=position_jitter(width=.4, height=0)) +
  theme_light() +
  labs(title="How the Commands Ranked the Officers", x="Officer ID", y="Preference from Command\n(lower is a more desirable officer)")

last_plot() %+%
  ds_officer_long %+%
  aes(x=command_id, y=preference_from_officer) +
  labs(title="How the Officers Ranked the Commands", x="command ID", y="Preference from Officer\n(lower is a more desirable command)")

