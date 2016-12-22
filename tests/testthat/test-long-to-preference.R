library(testthat)
context("Convert Long Rank to Preference")

ds_school_rank_long <- tibble::tribble(
  ~school_id, ~student_id, ~rank,
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
  ~student_id, ~school_id, ~rank,
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

long_to_preference(d_rank_school=ds_school_rank_long, d_rank_student=ds_student_rank_long)

# Each element is the student index
school_preference <- matrix(as.integer(c(
#C1,C2,C3   # The 3 schools --each column represents a school's 4 preferences.
  1, 2, 3,  # Preference 1
  2, 3, 1,  # Preference 2
  3, 1,NA,  # Preference 3
  4, 4,NA   # Preference 4
)), ncol=3, byrow=TRUE)


# Each element is the school index/id
student_preference <- matrix(as.integer(c(
#S1,S2,S3,S4   # The 4 students --each column represents an student's 3 preferences
  1, 2, 3, 3,  # Preference 1
  2, 3, 1, 1,  # Preference 2
  3, 1, 2,NA   # Preference 3
)), ncol=4, byrow=TRUE)

test_that("RelativePath", {
})
