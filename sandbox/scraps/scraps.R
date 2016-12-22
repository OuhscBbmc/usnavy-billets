
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


# ---- replacted by long-to-preference -----------------------------------------

ds_command_roster$command_index   <- seq_len(nrow(ds_command_roster))
ds_officer_roster$officer_index   <- seq_len(nrow(ds_officer_roster))

ds_command <- ds_command_long %>%
  dplyr::select_(
    "command_id"              = "`command_id`"
    , "officer_id"            = "`officer_id`"
    , "preference"            = "`preference`"
  ) %>%
  dplyr::left_join(
    ds_officer_roster %>%
      dplyr::select(officer_id, officer_index),
    by="officer_id"
  ) %>%
  dplyr::mutate(
    command_id   = sprintf("c_%03d", command_id),
    officer_id   = sprintf("o_%03d", officer_id)
  ) %>%
  tidyr::spread(key=command_id, value=preference)

command_rank <- ds_command %>%
  dplyr::select(-officer_id) %>%
  as.matrix()
row.names(command_rank) <- command_rank[, "officer_index"]
command_rank <-  command_rank[, "-officer_index"]


ds_command_roster %>%
  dplyr::left_join(command_rank)

match(13:1, 1:4)

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
  tidyr::spread(key=officer_id, value=preference) %>%
  dplyr::left_join(
    ds_command_roster %>%
      dplyr::select(command_id, command_index),
    by="command_id"
  )
officer <- ds_officer %>%
  dplyr::select(-command_id) %>%
  as.matrix()
row.names(officer) <- ds_officer$command_id

ds_command_long  <- dplyr::rename_(ds_command_long, "preference_from_command"="preference")
ds_officer_long  <- dplyr::rename_(ds_officer_long, "preference_from_officer"="preference")

convert_ranking_to_preference <- function( utility ) {

  apply(utility, 2, function( x ) {
    # Determine the order of (negative) values within a row.
    s <- sort.list(x, decreasing=F)

    # Re-establish the missing values.
    missing_indices <- which(is.na(x))
    ifelse(s %in% missing_indices, NA_integer_, s)
  })
}

command_preference <- ds_command %>%
  dplyr::select(-officer_id) %>%
  convert_ranking_to_preference()
officer_preference <- ds_officer %>%
  dplyr::select(-command_id) %>%
  convert_ranking_to_preference()


# ---- rmd-walk-through --------------------------------------------------------

# <!-- To walk through an example from the command's perspective, look at the fifth row in the first table.  The values represent how the `r nrow(ds_command_roster)` commands ranked officer ```r ds_command$officer_id[5]```.  The first four commands (i.e., ```r paste(colnames(ds_command)[2:5], collapse=", ")```) ranked officer ```r ds_command$officer_id[5]``` as `r as.data.frame(ds_command[5, 2:4])`, and `r as.data.frame(ds_command[5, 5])`.
#
# To walk through an example from the officer's perspective, look at the second row in the second table.  The values represent how the `r nrow(ds_officer_roster)` officers ranked command ```r ds_officer$command_id[2]```.  The first four officers (i.e., ```r paste(colnames(ds_officer)[2:5], collapse=", ")```) ranked officer ```r ds_officer$command_id[2]``` as `r as.data.frame(ds_officer[2, 2:4])`, and `r as.data.frame(ds_officer[2, 5])`.-->


