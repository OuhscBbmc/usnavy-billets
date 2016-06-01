# knitr::stitch_rmd(script="./analysis/select.R", output="./analysis/stitched-output/select.md")
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.

# ---- load-sources ------------------------------------------------------------

# ---- load-packages -----------------------------------------------------------
# Run this line if necessary: install.packages(c("magrittr", "ggplot2", "matchingMarkets", "readr", "tidyr", "dplyr"))

# Attach these packages so their functions don't need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
library(magrittr, quietly=TRUE)
library(ggplot2, quietly=TRUE)

# Verify these packages are available on the machine, but their functions need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
requireNamespace("matchingMarkets")
requireNamespace("readr")
requireNamespace("tidyr")
requireNamespace("dplyr") #Avoid attaching dplyr, b/c its function names conflict with a lot of packages (esp base, stats, and plyr).

# ---- declare-globals ---------------------------------------------------------
path_in_hospital   <- "./data-phi-free/derived/hospital.csv"
path_in_officer    <- "./data-phi-free/derived/officer.csv"

# ---- load-data ---------------------------------------------------------------
# Read the CSVs
ds_hospital_long   <- readr::read_csv(path_in_hospital) #Ranked by the hospitals
ds_officer_long    <- readr::read_csv(path_in_officer)  #Ranked by the officers

ds_hospital_roster <- readr::read_csv("./data-phi-free/raw/hospital-roster.csv")
ds_officer_roster  <- readr::read_csv("./data-phi-free/raw/officer-roster.csv")

# ---- tweak-data --------------------------------------------------------------
ds_hospital_roster$hospital_index <- seq_len(nrow(ds_hospital_roster))
ds_officer_roster$officer_index   <- seq_len(nrow(ds_officer_roster))

ds_hospital <- ds_hospital_long %>%
  dplyr::mutate(
    hospital_id  = sprintf("h_%03d", hospital_id),
    officer_id   = sprintf("o_%03d", officer_id)
  ) %>%
  tidyr::spread(key=hospital_id, value=preference)

hospital <- ds_hospital %>%
  dplyr::select(-officer_id) %>%
  as.matrix()
row.names(hospital) <- ds_hospital$officer_id

ds_officer <- ds_officer_long %>%
  dplyr::mutate(
    hospital_id  = sprintf("b_%03d", hospital_id),
    officer_id   = sprintf("o_%03d", officer_id)
  ) %>%
  tidyr::spread(key=officer_id, value=preference)

officer <- ds_officer %>%
  dplyr::select(-hospital_id) %>%
  as.matrix()
row.names(officer) <- ds_officer$hospital_id

ds_hospital_long <- dplyr::rename_(ds_hospital_long, "preference_from_hospital"="preference")
ds_officer_long  <- dplyr::rename_(ds_officer_long , "preference_from_officer"="preference")

# ---- transpose-transitions ------------------------------------------------------------------
library(dplyr)
transpose_transition_frame <- function( d2, id_name ) {
  # browser()
  d <- as.data.frame(t(d2), stringsAsFactors = FALSE)
  colnames(d) <- as.character(d[1, ])
  # d <- d[-1, ] #Drop the first row (which became column headers)
  d <- d %>%
    dplyr::add_rownames(id_name) %>%
    dplyr::slice(-1) %>%  #Drop the first row (which became column headers)
    dplyr::mutate_each(dplyr::funs(as.integer), starts_with("^o_\\d+$"))
  return( d )
}
ds_hospital_transition <- transpose_transition_frame(ds_hospital, id_name="hospital_id")
ds_officer_transition  <- transpose_transition_frame(ds_officer, id_name="officer_id")
detach("package:dplyr", character.only = TRUE)

# ---- rankings-raw ------------------------------------------------------------------
cat("\n\n### Input Provided from Each Hospital\n\n")
ds_hospital_transition %>%
  knitr::kable(format="markdown", align='r')

cat("\n\n### Input Provided from Each Officer\n\n")
ds_officer_transition %>%
  knitr::kable(format="markdown", align='r')

# ---- match ------------------------------------------------------------------
m <- matchingMarkets::daa(
  c.prefs = hospital, #College/hospital preferences (each officer  is a row)
  s.prefs = officer, #Student/officer   preferences (each hospital is a row)
  nSlots  = ds_hospital_roster$billet_count_max
)
# print(m)

m$edgelist %>%
  dplyr::mutate(
    students         = ifelse(students==0, "*not matched*", students),
    colleges         = ifelse(colleges==0, "*not matched*", colleges)
  ) %>%
  dplyr::rename_(
    "hospital id"   = "colleges",
    "officer id"    = "students"
  ) %>%
  knitr::kable(
    format       = "markdown"
  )

# ---- display ------------------------------------------------------------------
ds_edge <- m$edgelist %>%
  dplyr::rename(
    hospital_index  = colleges,
    officer_index   = students
  ) %>%
  dplyr::right_join(ds_hospital_roster, by="hospital_index") %>%
  dplyr::right_join(ds_officer_roster , by="officer_index" ) %>%
  dplyr::left_join(ds_hospital_long, by=c("hospital_id", "officer_id")) %>%
  dplyr::left_join(ds_officer_long , by=c("hospital_id", "officer_id")) %>%
  dplyr::arrange(desc(billet_count_max), hospital_id)

ds_edge %>%
  knitr::kable(
    col.names    = gsub("_", "<br/>", colnames(ds_edge)),
    format       = "markdown"
  )

# ---- graph-desirability ------------------------------------------------------------------
set.seed(23) #For the sake of keeping the jittering constant between runs.
ggplot(ds_hospital_long, aes(x=officer_id, y=preference_from_hospital))  +
  stat_summary(fun.y="mean", geom="point", shape=23, size=5, fill="white", alpha=.3, na.rm=T) + #See Chang (2013), Recipe 6.8.
  geom_point(shape=21, color="royalblue", fill="skyblue", alpha=.2, position=position_jitter(width=.4, height=0)) +
  theme_light() +
  labs(title="How the Hospitals Ranked the Officers", x="Officer ID", y="Preference from Hospital\n(lower is a more desirable officer)")

last_plot() %+%
  ds_officer_long %+%
  aes(x=hospital_id, y=preference_from_officer) +
  labs(title="How the Officers Ranked the Hospitals", x="Hospital ID", y="Preference from Officer\n(lower is a more desirable hospital)")

