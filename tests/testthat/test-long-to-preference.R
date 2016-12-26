library(testthat)
context("Convert Long Rank to Preference")

ds_college_rank_long <- tibble::tribble(
  ~college_id, ~student_id, ~rank,
         "a",         "m",    1L,
         "a",         "n",    2L,
         "a",         "o",    3L,
         "a",         "p",    4L,
         "b",         "m",    3L,
         "b",         "n",    1L,
         "b",         "o",    2L,
         "b",         "p",    4L,
         "c",         "m",    2L,
         "c",         "n",    NA,
         "c",         "o",    1L,
         "c",         "p",    NA
)

ds_student_rank_long <- tibble::tribble(
  ~student_id, ~college_id, ~rank,
          "m",        "a",    1L,
          "m",        "b",    2L,
          "m",        "c",    3L,
          "n",        "a",    3L,
          "n",        "b",    1L,
          "n",        "c",    2L,
          "o",        "a",    2L,
          "o",        "b",    3L,
          "o",        "c",    1L,
          "p",        "a",    2L,
          "p",        "b",    NA,
          "p",        "c",    1L
)


# Each element is the student index
college_preference <- matrix(as.integer(c(
#C1,C2,C3   # The 3 colleges --each column represents a college's 4 preferences.
  1, 2, 3,  # Preference 1
  2, 3, 1,  # Preference 2
  3, 1,NA,  # Preference 3
  4, 4,NA   # Preference 4
)), ncol=3, byrow=TRUE)


# Each element is the college index/id
student_preference <- matrix(as.integer(c(
#S1,S2,S3,S4   # The 4 students --each column represents an student's 3 preferences
  1, 2, 3, 3,  # Preference 1
  2, 3, 1, 1,  # Preference 2
  3, 1, 2,NA   # Preference 3
)), ncol=4, byrow=TRUE)

test_that("Scenario 1", {
  observed <- USNavyBillets::long_to_preference(d_rank_college=ds_college_rank_long, d_rank_student=ds_student_rank_long)

  testthat::expect_equal(
    object   = unname(observed$preference_college),
    expected = college_preference,
    label    = "The college's preference matrix should be correct."
  )

  testthat::expect_equal(
    object   = unname(observed$preference_student),
    expected = student_preference,
    label    = "The student's preference matrix should be correct."
  )
})
