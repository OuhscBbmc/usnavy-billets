# knitr::stitch_rmd(script="./analysis/select.R", output="./analysis/stitched-output/select.md")
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.

# ---- load-sources ------------------------------------------------------------

# ---- load-packages -----------------------------------------------------------
# Attach these packages so their functions don't need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
library(magrittr, quietly=TRUE)

# Verify these packages are available on the machine, but their functions need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
# run this line if necessary: install.packages(c("matchingMarkets", "readr", "tidyr", "dplyr"))
requireNamespace("matchingMarkets")
requireNamespace("readr")
requireNamespace("tidyr")
requireNamespace("dplyr") #Avoid attaching dplyr, b/c its function names conflict with a lot of packages (esp base, stats, and plyr).

# ---- declare-globals ---------------------------------------------------------
path_in_hospital   <- "./data-phi-free/derived/hospital.csv"
path_in_officer    <- "./data-phi-free/derived/officer.csv"

# ---- load-data ---------------------------------------------------------------
# Read the CSVs
ds_hospital_long   <- readr::read_csv(path_in_hospital)
ds_officer_long    <- readr::read_csv(path_in_officer)

ds_hospital_roster <- readr::read_csv("./data-phi-free/raw/hospital-roster.csv")
ds_officer_roster  <- readr::read_csv("./data-phi-free/raw/officer-roster.csv")

# ---- tweak-data --------------------------------------------------------------
ds_hospital_roster$hospital_index <- seq_len(nrow(ds_hospital_roster))
ds_officer_roster$officer_index   <- seq_len(nrow(ds_officer_roster))

ds_hospital <- ds_hospital_long %>%
  dplyr::mutate(
    hospital_id  = sprintf("b_%03d", hospital_id),
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

ds_hospital_long <- dplyr::rename_(ds_hospital_long, "preference_of_hospital"="preference")
ds_officer_long  <- dplyr::rename_(ds_officer_long , "preference_of_officer"="preference")


# ---- rankings-raw ------------------------------------------------------------------

cat("\n\n### Input from Each Hospital\n\n")
knitr::kable(ds_hospital, format="markdown")

cat("\n\n### Input from Each Officer\n\n")
knitr::kable(ds_officer, format="markdown")

# ---- select ------------------------------------------------------------------
m <- matchingMarkets::daa(
  c.prefs = hospital, #College/hospital preferences (each officer  is a row)
  s.prefs = officer, #Student/officer   preferences (each hospital is a row)
  nSlots  = ds_hospital_roster$billet_count_max
)
print(m)

knitr::kable(m$s.prefs)

# ---- join ------------------------------------------------------------------
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

knitr::kable(ds_edge, col.names=gsub("_", "<br/>", colnames(ds_edge)))
