# context("vector_coding")

testthat::test_that("errors", {
  testthat::expect_error(
    phase_angle(c(1, 2), c(1, 2, 3)),
    "joint angles length not the same"
  )

  testthat::expect_error(
    ang_ang_plot(c(1, 2), c(1, 2, 3)),
    "joint angles length not the same"
  )
})
