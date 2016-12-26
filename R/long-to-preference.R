#' @name long_to_preference
#' @export long_to_preference
#' @title Convert a long-form ranks into a preference matrix.
#' @description A long-format dataset (where each row is a specific rank) for the college and for the students
#' are converted to a wide-format preference matrix.

#' @param d_rank_college How the colleges ranked the students.  A 1 represents a college's top choice.
#' @param d_rank_student How the students ranked the colleges.  A 1 represents a student's top choice.
#' @importFrom magrittr %>%
#' @importFrom dplyr n
#' @author Will Beasley

long_to_preference <- function( d_rank_college, d_rank_student ) {

  # Create the two roster datasets, which link the ID in the INDEX
  d_roster_college <- d_rank_college %>%
    dplyr::distinct_("college_id", .keep_all=FALSE) %>%
    dplyr::mutate(college_index = seq_len(n()))

  d_roster_student <- d_rank_student %>%
    dplyr::distinct_("student_id", .keep_all=FALSE) %>%
    dplyr::mutate(student_index = seq_len(n()))

  # Create the two preference datasets, where each cell represent the index.
  d_preference_college <- d_rank_college %>%
    dplyr::group_by_("college_id") %>%
    dplyr::mutate(
       order     = sort.list(rank, decreasing=F),
       order     = dplyr::if_else(order %in% which(is.na(rank)), NA_integer_, order)
    ) %>%
    dplyr::ungroup() %>%
    dplyr::left_join(d_roster_college, by="college_id") %>%
    dplyr::left_join(d_roster_student, by="student_id") %>%
    dplyr::select_("college_index", "student_index", "order") %>%
    tidyr::spread_(key="college_index", value="order")

  d_preference_student <- d_rank_student %>%
    dplyr::group_by_("student_id") %>%
    dplyr::mutate(
       order     = sort.list(rank, decreasing=F),
       order     = dplyr::if_else(order %in% which(is.na(rank)), NA_integer_, order)
    ) %>%
    dplyr::ungroup() %>%
    dplyr::left_join(d_roster_student, by="student_id") %>%
    dplyr::left_join(d_roster_college, by="college_id") %>%
    dplyr::select_("student_index", "college_index", "order") %>%
    tidyr::spread_(key="student_index", value="order")

  # Create the two preference matrices, that are stripped of almost all meta-data.
  preference_college <- d_preference_college %>%
    dplyr::select_("-student_index") %>%
    as.matrix()

  preference_student <- d_preference_student %>%
    dplyr::select_("-college_index") %>%
    as.matrix()

  list(
    d_roster_college    = d_roster_college,
    d_roster_student   = d_roster_student,
    preference_college  = preference_college,
    preference_student = preference_student
  )
}

