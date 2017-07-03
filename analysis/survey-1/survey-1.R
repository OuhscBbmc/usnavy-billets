rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.

# ---- load-sources ------------------------------------------------------------
#Load any source files that contain/define functions, but that don't load any other types of variables
#   into memory.  Avoid side effects and don't pollute the global environment.
# source("./SomethingSomething.R")

# ---- load-packages -----------------------------------------------------------
library(magrittr) #Pipes
library(ggplot2) #For graphing
requireNamespace("dplyr")
# requireNamespace("tidyr") #For converting wide to long
# requireNamespace("RColorBrewer")
# requireNamespace("scales") #For formating values in graphs
# requireNamespace("mgcv) #For the Generalized Additive Model that smooths the longitudinal graphs.
requireNamespace("TabularManifest") # devtools::install_github("Melinae/TabularManifest")

# ---- declare-globals ---------------------------------------------------------
options(show.signif.stars=F) #Turn off the annotations on p-values

path_input <- "data-unshared/derived/survey-dm-1.csv"

col_types = readr::cols_only(
  response_index              = readr::col_integer(),
  transparent                 = readr::col_integer(),
  satisfaction                = readr::col_integer(),
  favoritism                  = readr::col_integer(),
  assignment_current_rank     = readr::col_character(),
  missing_item_count          = readr::col_integer()
)

# ---- load-data ---------------------------------------------------------------
ds <- readr::read_csv(path_input, col_types=col_types) # 'ds' stands for 'datasets'
# ---- tweak-data --------------------------------------------------------------

# ---- marginals ---------------------------------------------------------------
TabularManifest::histogram_continuous(ds, variable_name="response_index", bin_width=50, rounded_digits=1)
TabularManifest::histogram_continuous(ds, variable_name="transparent", bin_width=1, rounded_digits=1)
TabularManifest::histogram_continuous(ds, variable_name="satisfaction", bin_width=1, rounded_digits=1)
TabularManifest::histogram_continuous(ds, variable_name="favoritism", bin_width=1, rounded_digits=1)

TabularManifest::histogram_discrete(ds, variable_name="assignment_current_rank")
TabularManifest::histogram_continuous(ds, variable_name="missing_item_count", bin_width=1, rounded_digits=1)

#
# # ---- scatterplots ------------------------------------------------------------
# g1 <- ggplot(ds, aes(x=gross_horsepower, y=quarter_mile_in_seconds, color=forward_gear_count_f)) +
#   geom_smooth(method="loess", span=2) +
#   geom_point(shape=1) +
#   theme_light() +
#   theme(axis.ticks = element_blank())
# g1
#
# g1 %+% aes(color=cylinder_count)
# g1 %+% aes(color=factor(cylinder_count))
