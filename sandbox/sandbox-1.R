# knitr::stitch_rmd(script="./sandbox/sandbox-1.R", output="./stitched-output/sandbox/sandbox-1.md")
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.

# ---- load-sources ------------------------------------------------------------

# ---- load-packages -----------------------------------------------------------
# Run this line if necessary: install.packages(c("magrittr", "ggplot2", "matchingMarkets", "readr", "tidyr", "dplyr"))

# Attach these packages so their functions don't need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
library(magrittr, quietly=TRUE)
library(ggplot2, quietly=TRUE)

# Verify these packages are available on the machine, but their functions need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
requireNamespace("matchingR")  # devtools::install_version("jtilly/matchingR")
# requireNamespace("matchingMarkets")  # devtools::install_version("matchingMarkets", version = "0.2-1", repos = "http://cran.us.r-project.org")
requireNamespace("readr")
requireNamespace("tidyr")
requireNamespace("dplyr") #Avoid attaching dplyr, b/c its function names conflict with a lot of packages (esp base, stats, and plyr).

# ---- declare-globals ---------------------------------------------------------
# Constant values that won't change.
set.seed(43) #So the random sampling won't change.
command_count  <- 3L
officer_count  <- 4L

ds_base <-
  tidyr::crossing(
    command_index   = seq_len(command_count),
    officer_index   = seq_len(officer_count)
  ) %>%
  dplyr::mutate(
    command_id      = sprintf("c_%03d", command_index + 200L),
    officer_id      = sprintf("o_%03d", officer_index + 400L)
  )

ds_command_long <- ds_base %>%
  dplyr::group_by(command_index) %>%
  dplyr::mutate(
    preference       = sample(n()),
    billet_count_max = 1L
  ) %>%
  dplyr::ungroup()

ds_officer_long <- ds_base %>%
  dplyr::group_by(officer_index) %>%
  dplyr::mutate(
    preference      = sample(n())
  ) %>%
  dplyr::ungroup()

# ---- load-data ---------------------------------------------------------------
# Read the CSVs

ds_command_long
ds_officer_long

# ---- tweak-data --------------------------------------------------------------
# OuhscMunge::column_rename_headstart(ds_county) #Spit out columns to help write call ato `dplyr::rename()`.


# ---- verify-values-command -----------------------------------------------------------
# Sniff out problems
testit::assert("The officer_id must be nonmissing.", all(!is.na(ds_command_long$officer_id)))
testit::assert("The preference must be nonmissing.", all(!is.na(ds_command_long$preference)))
testit::assert("The command_id must be nonmissing.", all(!is.na(ds_command_long$command_id)))
testit::assert("The billet_count_max must be nonmissing.", all(!is.na(ds_command_long$billet_count_max)))
testit::assert("The officer_id-command_id combination should be unique.", all(!duplicated(paste(ds_command_long$officer_id, ds_command_long$command_id))))
testit::assert("The command_id-preference combination should be unique.", all(!duplicated(paste(ds_command_long$command_id, ds_command_long$preference))))

# ---- verify-values-officer -----------------------------------------------------------
# Sniff out problems
testit::assert("The officer_id must be nonmissing.", all(!is.na(ds_officer_long$officer_id)))
testit::assert("The preference must be nonmissing.", all(!is.na(ds_officer_long$preference)))
testit::assert("The command_id must be nonmissing.", all(!is.na(ds_officer_long$command_id)))
testit::assert("The officer_id-command_id combination should be unique.", all(!duplicated(paste(ds_officer_long$officer_id, ds_officer_long$command_id))))
testit::assert("The officer_id-preference combination should be unique.", all(!duplicated(paste(ds_officer_long$officer_id, ds_officer_long$preference))))
# as.data.frame(ds_officer_long[duplicated(paste(ds_officer_long$officer_id, ds_officer_long$preference)), ])

# ---- transition-matrix -------------------------------------------------------
command_transition <- ds_command_long %>%
  dplyr::select(command_index, officer_index, preference) %>%
  tidyr::spread(key=command_index, value=preference) %>%
  dplyr::select(-officer_index) %>%
  as.matrix() %>%
  unname()

officer_transition <- ds_officer_long %>%
  dplyr::select(command_index, officer_index, preference) %>%
  tidyr::spread(key=officer_index, value=preference) %>%
  dplyr::select(-command_index) %>%
  as.matrix() %>%
  unname()


# ---- match ------------------------------------------------------------------

matchingR::galeShapley.validate(
  reviewerPref = command_transition,
  proposerPref = officer_transition
)
matchingR::galeShapley.collegeAdmissions(
  collegePref = command_transition,
  studentPref = officer_transition
)

# m <- matchingMarkets::hri(
#   c.prefs = command_transition, #College/command preferences (each officer is a row)
#   s.prefs = officer_transition, #Student/officer preferences (each command is a row)
#   nSlots  =c(1,1,1)
# )
# # print(m)
#
# m
#
# m$matchings %>%
#   dplyr::select(-matching, -sOptimal, -cOptimal) %>%
#   # dplyr::select(-matching, -slots, -sOptimal, -cOptimal) %>%
#   # dplyr::mutate(
#   #   student          = ifelse(student==0, "*not matched*", student),
#   #   college          = ifelse(college==0, "*not matched*", college)
#   # ) %>%
#   dplyr::arrange(college, student) %>%
#   dplyr::rename_(
#     "command<br/>index"    = "college",
#     "officer<br/>index"    = "student"
#   ) %>%
#   knitr::kable(
#     format       = "markdown"
#     , align = c("r", "l")
#   )

# # ---- display ------------------------------------------------------------------
# ds_edge <- m$matchings %>%
#   tibble::as_tibble() %>%
#   dplyr::select(-matching, -slots, -sOptimal, -cOptimal) %>%
#   dplyr::rename(
#     command_index   = college,
#     officer_index   = student
#   ) %>%
#   dplyr::right_join(ds_command_roster, by="command_index") %>%
#   dplyr::right_join(ds_officer_roster, by="officer_index" ) %>%
#   dplyr::left_join(ds_command_long, by=c("command_id", "officer_id")) %>%
#   dplyr::left_join(ds_officer_long, by=c("command_id", "officer_id")) %>%
#   dplyr::arrange(desc(billet_count_max), command_id) %>%
#   dplyr::mutate(
#     command_id   = sprintf("c_%03d", command_id),
#     officer_id   = sprintf("o_%03d", officer_id)
#   )
#
# ds_edge %>%
#   knitr::kable(
#     col.names    = gsub("_", "<br/>", colnames(ds_edge)),
#     format       = "markdown"
#   )
#
# # ---- graph-desirability ------------------------------------------------------------------
# set.seed(23) #For the sake of keeping the jittering constant between runs.
# ggplot(ds_command_long, aes(x=officer_id, y=preference_from_command))  +
#   stat_summary(fun.y="mean", geom="point", shape=23, size=5, fill="white", alpha=.3, na.rm=T) + #See Chang (2013), Recipe 6.8.
#   geom_point(shape=21, color="royalblue", fill="skyblue", alpha=.2, position=position_jitter(width=.4, height=0)) +
#   theme_light() +
#   labs(title="How the Commands Ranked the Officers", x="Officer ID", y="Preference from Command\n(lower is a more desirable officer)")
#
# last_plot() %+%
#   ds_officer_long %+%
#   aes(x=command_id, y=preference_from_officer) +
#   labs(title="How the Officers Ranked the Commands", x="command ID", y="Preference from Officer\n(lower is a more desirable command)")
#
