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
  rank                = readr::col_integer()
)

col_types_officer <- readr::cols_only(
  command_id        = readr::col_integer(),
  officer_id        = readr::col_integer(),
  rank              = readr::col_integer()
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

rm(path_in_command  , path_in_officer  , path_in_roster_command  , path_in_roster_officer  )
rm(col_types_command, col_types_officer, col_types_roster_command, col_types_roster_officer)

# ---- tweak-data --------------------------------------------------------------
# OuhscMunge::column_rename_headstart(ds_command_long)
ds_command_long <- ds_command_long %>%
  dplyr::select_(
    "college_id"            = "`command_id`"
    , "student_id"          = "`officer_id`"
    , "rank"
  )

ds_officer_long <- ds_officer_long %>%
  dplyr::select_(
    "college_id"            = "`command_id`"
    , "student_id"          = "`officer_id`"
    , "rank"
  )

ds_officer_roster <- ds_officer_roster %>%
  dplyr::semi_join(ds_officer_long, by=c("officer_id"="student_id"))

# ---- rankings-raw ------------------------------------------------------------------
cat("\n\n### Input Provided from Each Command\n\n")
ds_command_long %>%
  dplyr::mutate(
    rank = dplyr::coalesce(as.character(rank), "-")
  ) %>%
  tidyr::spread(key=student_id, value=rank) %>%
  # dplyr::filter(!is.na(rank)) %>%
  # dplyr::arrange(college_id, student_id) %>%
  knitr::kable(format="markdown", align='r')

cat("\n\n### Input Provided from Each Officer\n\n")
ds_officer_long %>%
  dplyr::mutate(
    rank = dplyr::coalesce(as.character(rank), "-")
  ) %>%
  tidyr::spread(key=college_id, value=rank)  %>%
  # dplyr::filter(!is.na(rank)) %>%
  # dplyr::arrange(student_id, college_id) %>%
  knitr::kable(format="markdown", align='r')

# ---- remove-joint-unranked ---------------------------------------------------
ds_joint_long <- ds_command_long %>%
  dplyr::full_join(ds_officer_long, by=c("college_id", "student_id")) %>%
  dplyr::select_(
    "college_id"
    , "student_id"
    , "rank_from_college"                = "`rank.x`"
    , "rank_from_student"                = "`rank.y`"
  ) %>%
  dplyr::mutate(
    joint    = !is.na(rank_from_college) & !is.na(rank_from_student)
  )

ds_college_joint_unranked <- ds_joint_long %>%
  dplyr::group_by(college_id) %>%
  dplyr::summarize(
    joint_count  = sum(joint, na.rm=t)
  ) %>%
  dplyr::ungroup() %>%
  dplyr::filter(joint_count==0L) #%>%
  # .[["college_id"]]

ds_student_joint_unranked <- ds_joint_long %>%
  dplyr::group_by(student_id) %>%
  dplyr::summarize(
    joint_count  = sum(joint, na.rm=t)
  ) %>%
  dplyr::ungroup() %>%
  dplyr::filter(joint_count==0L)# %>%
  # .[["student_id"]]

cat(
  "The following ",
  nrow(ds_college_joint_unranked),
  " colleges/commands were never ranked by students/officers who ranked them: ",
  paste(ds_college_joint_unranked$college_id, collapse=", "),
  ".  They will be removed.",
  sep = ""
)

cat(
  "The following ",
  nrow(ds_student_joint_unranked),
  " students/officers were never ranked by colleges/commands who ranked them: ",
  paste(ds_student_joint_unranked$student_id, collapse=", "),
  ".  They will be removed.",
  sep = ""
)

ds_command_long <- ds_command_long %>%
  dplyr::filter(!(college_id %in% ds_college_joint_unranked$college_id)) %>%
  dplyr::filter(!(student_id %in% ds_student_joint_unranked$student_id))

ds_officer_long <- ds_officer_long %>%
  dplyr::filter(!(college_id %in% ds_college_joint_unranked$college_id)) %>%
  dplyr::filter(!(student_id %in% ds_student_joint_unranked$student_id))

# ---- convert-to-preferences --------------------------------------------------
converted <- USNavyBillets::long_to_preference(d_rank_college=ds_command_long, d_rank_student=ds_officer_long)

ds_command_roster <- ds_command_roster %>%
  dplyr::left_join(converted$d_roster_college, by=c("command_id"="college_id")) %>%
  dplyr::rename_("command_index" = "college_index")
ds_officer_roster <- ds_officer_roster %>%
  dplyr::left_join(converted$d_roster_student, by=c("officer_id"="student_id")) %>%
  dplyr::rename_("officer_index" = "student_index")

billet_count_ordered_by_index <- ds_command_roster %>%
  dplyr::arrange(command_index) %>%
  .[["billet_count_max"]]


# ---- preferences ------------------------------------------------------------------
cat("\n\n### Input Provided from Each Command\n\n")
converted$preference_college %>%
  tibble::as_tibble() %>%
  dplyr::mutate(sum = rowSums(., na.rm=T)) %>%
  replace(is.na(.), "-") %>%
  dplyr::filter(sum > 0L ) %>%
  dplyr::select(-sum) %>%
  knitr::kable(format="markdown", align='r')

cat("\n\n### Input Provided from Each Command --recoded\n\n")
ds_command_preference_pretty <- converted$preference_college %>%
  tibble::as_tibble() %>%
  dplyr::mutate(
    choice = seq_len(n())
  ) %>%
  tidyr::gather(key=command_index, value=officer_index, -choice) %>%
  dplyr::mutate(command_index = as.integer(command_index)) %>%
  dplyr::filter(!is.na(officer_index)) %>%
  dplyr::left_join(ds_command_roster[, c("command_name", "command_index")], by="command_index") %>%
  dplyr::left_join(ds_officer_roster[, c("officer_id", "officer_index")], by="officer_index") %>%
  dplyr::select( -command_index, -officer_index) %>%
  tidyr::spread(key=command_name, value=officer_id)

ds_command_preference_pretty %>%
  replace(is.na(.), "-") %>%
  knitr::kable(
    col.names    = gsub("_", "<br/>", colnames(ds_command_preference_pretty)),
    format       = "markdown",
    align        = c("c")
  )


cat("\n\n### Input Provided from Each Officer\n\n")
converted$preference_student %>%
  tibble::as_tibble() %>%
  dplyr::mutate(sum = rowSums(., na.rm=T)) %>%
  replace(is.na(.), "-") %>%
  dplyr::filter(sum > 0L ) %>%
  dplyr::select(-sum) %>%
  knitr::kable(format="markdown", align='r')


cat("\n\n### Input Provided from Each Officer --recoded\n\n")
ds_officer_preference_pretty <- converted$preference_student %>%
  tibble::as_tibble() %>%
  dplyr::mutate(
    choice = seq_len(n())
  ) %>%
  tidyr::gather(key=officer_index, value=command_index, -choice) %>%
  dplyr::mutate(officer_index = as.integer(officer_index)) %>%
  dplyr::filter(!is.na(command_index)) %>%
  dplyr::left_join(ds_command_roster[, c("command_name", "command_index")], by="command_index") %>%
  dplyr::left_join(ds_officer_roster[, c("officer_id", "officer_index")], by="officer_index") %>%
  dplyr::select( -command_index, -officer_index) %>%
  dplyr::mutate(command_name = gsub(" ", "<br/>", command_name)) %>%
  tidyr::spread(key=officer_id, value=command_name)

ds_officer_preference_pretty %>%
  replace(is.na(.), "-") %>%
  knitr::kable(
    col.names    = gsub("_", "<br/>", colnames(ds_officer_preference_pretty)),
    format       = "markdown",
    align        = c("c")
  )


# ---- match ------------------------------------------------------------------
m <- matchingMarkets::hri(
  c.prefs = converted$preference_college, #College/command preferences (each officer is a row)
  s.prefs = converted$preference_student, #Student/officer preferences (each command is a row)
  nSlots  = billet_count_ordered_by_index
)
# print(m)

ds_match <- m$matchings %>%
  tibble::as_tibble() %>%
  dplyr::select_(
    "command_index"   = "college",
    "officer_index"   = "student",
    "command_rank"    = "cRank",
    "officer_rank"    = "sRank",
    "command_optimal" = "cOptimal",
    "officer_optimal" = "sOptimal",
    "matching",
    "slots"
  ) %>%
  dplyr::arrange(command_index, officer_index)

ds_command_unmatched <- ds_command_roster %>%
  dplyr::anti_join(ds_match, by="command_index") %>%
  dplyr::union(
    ds_command_roster %>%
      dplyr::right_join(ds_college_joint_unranked, by=c("command_id"="college_id")) %>%
      dplyr::select(-joint_count)
  ) %>%
  dplyr::arrange(command_id)

ds_officer_unmatched <- ds_officer_roster %>%
  dplyr::anti_join(ds_match, by="officer_index") %>%
  dplyr::union(
    ds_officer_roster %>%
      dplyr::right_join(ds_student_joint_unranked, by=c("officer_id"="student_id")) %>%
      dplyr::select(-joint_count)
  ) %>%
  dplyr::arrange(officer_id)

ds_match %>%
  knitr::kable(
    col.names    = gsub("_", "<br/>", colnames(ds_match)),
    format       = "markdown"
    # , align = c("r", "l")
  )

# ---- display ------------------------------------------------------------------
ds_edge <- ds_match %>%
  dplyr::select(-matching, -slots, -command_optimal, -officer_optimal) %>%
  dplyr::left_join(ds_command_roster, by="command_index") %>%
  dplyr::left_join(ds_officer_roster, by="officer_index" ) %>%
  # dplyr::left_join(ds_command_long, by=c("command_id"="college_id", "officer_id"="student_id")) %>%
  # dplyr::left_join(ds_officer_long, by=c("command_id"="college_id", "officer_id"="student_id")) %>%
  dplyr::arrange(desc(billet_count_max), command_id) %>%
  dplyr::mutate(
    command_id   = dplyr::if_else(!is.na(command_id), sprintf("c_%03d", command_id), "-"),
    officer_id   = dplyr::if_else(!is.na(officer_id), sprintf("o_%03d", officer_id), "-")
  ) %>%
  dplyr::arrange(command_id, command_index, officer_id, officer_index)

ds_edge %>%
  replace(is.na(.), "-") %>%
  knitr::kable(
    col.names    = gsub("_", "<br/>", colnames(ds_edge)),
    format       = "markdown"
  )


# ---- unmatched ---------------------------------------------------------------

ds_command_unmatched %>%
  knitr::kable(
    col.names    = gsub("_", "<br/>", colnames(ds_command_unmatched)),
    format       = "markdown"
  )

ds_officer_unmatched %>%
  knitr::kable(
    col.names    = gsub("_", "<br/>", colnames(ds_officer_unmatched)),
    format       = "markdown"
  )


# ---- graph-desirability ------------------------------------------------------------------
set.seed(23) #For the sake of keeping the jittering constant between runs.
ggplot(ds_command_long, aes(x=student_id, y=rank))  +
  stat_summary(fun.y="mean", geom="point", shape=23, size=5, fill="white", alpha=.3, na.rm=T) + #See Chang (2013), Recipe 6.8.
  geom_point(shape=21, color="royalblue", fill="skyblue", alpha=.2, position=position_jitter(width=.4, height=0), na.rm=T) +
  theme_light() +
  labs(title="How the Commands Ranked the Officers", x="Officer ID", y="Preference from Command\n(lower is a more desirable officer)")

last_plot() %+%
  ds_officer_long %+%
  aes(x=student_id) +
  labs(title="How the Officers Ranked the Commands", x="command ID", y="Preference from Officer\n(lower is a more desirable command)")

