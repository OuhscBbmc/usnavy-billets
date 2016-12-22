#' @name long_to_preference
#' @export long_to_preference
#' @title Convert a long-form ranks into a preference matrix.
#' @description A long-format dataset (where each row is a specific rank) for the school and for the students
#' are converted to a wide-format preference matrix.

#' @param d_rank_school How the schools ranked the students.  A 1 represents a school's top choice.
#' @param d_rank_student How the students ranked the schools.  A 1 represents a student's top choice.

#' @author Will Beasley

long_to_preference <- function( d_rank_school, d_rank_student ) {

  # Create the two roster datasets, which link the ID in the INDEX
  d_roster_school <- d_rank_school %>%
    dplyr::distinct_("school_id", .keep_all=FALSE) %>%
    dplyr::mutate(school_index = seq_len(nrow(.)))

  d_roster_student <- d_rank_student %>%
    dplyr::distinct_("student_id", .keep_all=FALSE) %>%
    dplyr::mutate(student_index = seq_len(nrow(.)))

  # Create the two preference datasets, where each cell represent the index.
  d_preference_school <- d_rank_school %>%
    dplyr::group_by_("school_id") %>%
    dplyr::mutate(
       order     = sort.list(rank, decreasing=F),
       order     = dplyr::if_else(order %in% which(is.na(rank)), NA_integer_, order)
    ) %>%
    dplyr::ungroup() %>%
    dplyr::left_join(d_roster_school, by="school_id") %>%
    dplyr::left_join(d_roster_student, by="student_id") %>%
    dplyr::select_("school_index", "student_index", "order") %>%
    tidyr::spread_(key="school_index", value="order")

  d_preference_student <- d_rank_student %>%
    dplyr::group_by_("student_id") %>%
    dplyr::mutate(
       order     = sort.list(rank, decreasing=F),
       order     = dplyr::if_else(order %in% which(is.na(rank)), NA_integer_, order)
    ) %>%
    dplyr::ungroup() %>%
    dplyr::left_join(d_roster_student, by="student_id") %>%
    dplyr::left_join(d_roster_school, by="school_id") %>%
    dplyr::select_("student_index", "school_index", "order") %>%
    tidyr::spread_(key="student_index", value="order")

  # Create the two preference matrices, that are stripped of almost all meta-data.
  preference_school <- d_preference_school %>%
    dplyr::select_("-student_index") %>%
    as.matrix()

  preference_student <- d_preference_student %>%
    dplyr::select_("-school_index") %>%
    as.matrix()

  list(
    d_roster_school    = d_roster_school,
    d_roster_student   = d_roster_student,
    preference_school  = preference_school,
    preference_student = preference_student
  )
}

