test_that("user_dir() follows tools::R_user_dir() and R_USER_*_DIR", {
  d <- file.path(tempdir(), "ud-test")
  unlink(d, recursive = TRUE)
  old <- Sys.getenv("R_USER_DATA_DIR", NA_character_)
  Sys.setenv(R_USER_DATA_DIR = d)
  on.exit(if (is.na(old)) Sys.unsetenv("R_USER_DATA_DIR") else Sys.setenv(R_USER_DATA_DIR = old), add = TRUE)

  expect_equal(user_dir("yulabtest"), tools::R_user_dir("yulabtest", "data"))
  expect_true(startsWith(user_dir("yulabtest"), d))
  expect_equal(user_dir("yulabtest", "cache"), tools::R_user_dir("yulabtest", "cache"))
  expect_true(dir.exists(user_dir("yulabtest", "cache")))
  # appauthor is accepted but ignored, as with tools::R_user_dir()
  expect_equal(user_dir("yulabtest", appauthor = "someone"),
               tools::R_user_dir("yulabtest", "data"))
  expect_error(user_dir(), "appname")
  expect_error(user_dir("x", "nope"))
})