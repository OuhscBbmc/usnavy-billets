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

requireNamespace("corrplot")
requireNamespace("TabularManifest") # devtools::install_github("Melinae/TabularManifest")

# ---- declare-globals ---------------------------------------------------------
options(show.signif.stars=F) #Turn off the annotations on p-values

path_input <- "data-unshared/derived/survey-dm-1.csv"

col_types = readr::cols_only(
  response_index              = readr::col_integer(),
  transparent                 = readr::col_integer(),
  satisfaction                = readr::col_integer(),
  favoritism                  = readr::col_integer(),
  assignment_rank             = readr::col_character(),
  assignment_rank_collapsed   = readr::col_integer(),
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

TabularManifest::histogram_discrete(ds, variable_name="assignment_rank")
TabularManifest::histogram_continuous(ds, variable_name="assignment_rank_collapsed", bin_width=1, rounded_digits=1)
TabularManifest::histogram_continuous(ds, variable_name="missing_item_count", bin_width=1, rounded_digits=1)


# ---- correlations ------------------------------------------------------------
outcomes <- c("transparent", "satisfaction", "favoritism", "assignment_rank_collapsed", "missing_item_count")

correlation_matrix <- function( d, outcomes, outcomes_pretty=gsub("_", "\n", outcomes), title="" ) {
  square <- cor(d[, outcomes], use="pairwise.complete.obs")
  dimnames(square) <- list(outcomes_pretty, outcomes_pretty)
  corrplot::corrplot(square, method="ellipse", addCoef.col="gray30", tl.col="gray10", diag=F, cl.pos="n")
  mtext(text = title, line = +3, col="DarkBlue", font=2)
}
correlation_matrix(
  ds,
  outcomes,
  title = "Correlations Among Responses"
)


scatter_matrix <- function( d, outcomes, outcomes_pretty=gsub("_", "\n", outcomes), title="" ) {
  pointsCex <- .8
  panel.hist <- function(x, ...) {
    usr <- par("usr")
    on.exit(par(usr))
    par(usr=c(usr[1:2], 0, 1.5))

    h <- hist(x, plot=F)
    breaks <- h$breaks
    nB <- length(breaks)
    y <- h$counts
    y <- y/max(y)
    rect(breaks[-nB], 0, breaks[-1], y, col="white", ...)
  }
  pairs(labels = outcomes_pretty,
        #pch=".",
        cex=pointsCex,
        x=d[, outcomes],
        lower.panel=panel.smooth,
        upper.panel=panel.smooth, #panel.cor,
        diag.panel=panel.hist
  )
  mtext(text = title, line = -1, col="tomato",font=2)
}
scatter_matrix(ds, outcomes)

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
