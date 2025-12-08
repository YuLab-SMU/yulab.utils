test_that("check_file validates existence and permissions", {
  tf <- tempfile()
  writeLines("x", tf)
  expect_silent(check_file(tf, operation = "read", must_exist = TRUE))
  unlink(tf)
  expect_error(check_file(tf, operation = "read", must_exist = TRUE))
})

test_that("check_directory can create missing dir", {
  td <- tempfile()
  expect_message(check_directory(td, create_if_missing = TRUE), "Created directory")
  expect_true(dir.exists(td))
  unlink(td, recursive = TRUE)
})

test_that("check_range validates numeric bounds", {
  expect_silent(check_range(5, min = 1, max = 10))
  expect_error(check_range(0, min = 1))
  expect_error(check_range(11, max = 10))
})
