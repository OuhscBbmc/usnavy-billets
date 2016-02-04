# knitr::stitch_rmd(script="./analysis/select.R", output="./analysis/stitched-output/select.md")
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.

# ---- load-sources ------------------------------------------------------------

# ---- load-packages -----------------------------------------------------------
# Attach these packages so their functions don't need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
library(magrittr, quietly=TRUE)

# Verify these packages are available on the machine, but their functions need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
requireNamespace("matchingMarkets")
requireNamespace("readr")
requireNamespace("tidyr")
requireNamespace("dplyr") #Avoid attaching dplyr, b/c its function names conflict with a lot of packages (esp base, stats, and plyr).

# ---- declare-globals ---------------------------------------------------------
path_in_billet  <- "./data-phi-free/derived/billet.csv"
path_in_officer <- "./data-phi-free/derived/officer.csv"

# ---- load-data ---------------------------------------------------------------
# Read the CSVs
ds_billet_long   <- readr::read_csv(path_in_billet)
ds_officer_long  <- readr::read_csv(path_in_officer)

ds_billet_roster   <- readr::read_csv("./data-phi-free/raw/billet-roster.csv")
ds_officer_roster  <- readr::read_csv("./data-phi-free/raw/officer-roster.csv")

# ---- tweak-data --------------------------------------------------------------
ds_billet <- ds_billet_long %>%
  dplyr::mutate(
    billet_id  = sprintf("b_%03d", billet_id),
    officer_id = sprintf("o_%03d", officer_id)
  ) %>%
  tidyr::spread(key=officer_id, value=preference) %>%
  dplyr::mutate(billet_index = seq_len(n()))

billet <- ds_billet %>%
  dplyr::select(-billet_id, -billet_index) %>%
  as.matrix()
row.names(billet) <- ds_billet$billet_id

ds_officer <- ds_officer_long %>%
  dplyr::mutate(
    billet_id = sprintf("b_%03d", billet_id),
    officer_id = sprintf("o_%03d", officer_id)
  ) %>%
  tidyr::spread(key=billet_id, value=preference) %>%
  dplyr::mutate(officer_index = seq_len(n()))

officer <- ds_officer %>%
  dplyr::select(-officer_id, -officer_index) %>%
  as.matrix()
row.names(officer) <- ds_officer$officer_id


# ---- select ------------------------------------------------------------------
m <- matchingMarkets::daa(c.prefs=billet, s.prefs=officer)
print(m)

# ---- join ------------------------------------------------------------------
ds_edge <-m$edgelist %>%
  dplyr::rename(
    billet_index  = colleges,
    officer_index = students
  ) %>%
  dplyr::left_join(ds_billet[, c("billet_id", "billet_index")], by="billet_index") %>%
  dplyr::left_join(ds_officer[, c("officer_id", "officer_index")], by="officer_index") %>%
  dplyr::mutate(
    billet_id   = as.integer(gsub("^b_(\\d+)$", "\\1", billet_id, perl=T)),
    officer_id  = as.integer(gsub("^o_(\\d+)$", "\\1", officer_id, perl=T))
  ) %>%
  dplyr::left_join(ds_billet_roster, by="billet_id") %>%
  dplyr::left_join(ds_officer_roster, by="officer_id")

knitr::kable(ds_edge)
