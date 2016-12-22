
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
