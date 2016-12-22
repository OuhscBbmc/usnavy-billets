#' @name long_to_preference
#' @export long_to_preference
#' @title Convert a long-form ranks into a preference matrix.
#' @description A long-format dataset (where each row is a specific rank) for the school and for the students
#' are converted to a wide-format preference matrix.

#' @param d_rank_school How the schools ranked the students.  A 1 represents a school's top choice.
#' @param d_rank_student How the students ranked the schools.  A 1 represents a student's top choice.

#' @author Will Beasley

long_to_preference <- function( d_rank_school, d_rank_student ) {

  # ds_roster_a$index   <- seq_len(nrow(ds_roster_a))
  d_roster_school <- d_rank_school %>%
    dplyr::distinct_("school_id", .keep_all=FALSE) %>%
    dplyr::mutate(school_index = seq_len(nrow(.)))

  d_roster_student <- d_rank_student %>%
    dplyr::distinct_("student_id", .keep_all=FALSE) %>%
    dplyr::mutate(student_index = seq_len(nrow(.)))

  d_preference_school <- d_rank_school %>%
    dplyr::group_by_("school_id") %>%
    dplyr::mutate(
       order     = sort.list(rank, decreasing=F),
       missing   = is.na(rank),
       order     = dplyr::if_else(missing, NA_integer_, order)
    ) %>%
    dplyr::ungroup() %>%
    dplyr::left_join(d_roster_school, by="school_id") %>%
    dplyr::left_join(d_roster_student, by="student_id") %>%
    dplyr::select_("school_index", "student_index", "order") %>%
    tidyr::spread_(key="school_index", value="order")

  command_preference <- d_preference_school %>%
    dplyr::select_("-student_index") %>%
    as.matrix()

}

