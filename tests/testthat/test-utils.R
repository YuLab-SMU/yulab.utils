test_that("%||% returns fallback only when NULL", {
  expect_equal(NULL %||% 1, 1)
  expect_equal(0 %||% 1, 0)
  expect_equal("" %||% "x", "")
})

test_that("parse_ratio handles spaces and invalid inputs", {
  expect_equal(parse_ratio("1/5"), 0.2)
  expect_equal(parse_ratio(" 2 / 4 "), 0.5)
  expect_true(is.na(parse_ratio("a/b")))
  expect_true(is.na(parse_ratio("1/0")))
})

test_that("quiet suppresses output and returns value invisibly", {
  f <- function() { cat("hello\n"); 1 }
  res <- quiet(f())
  expect_equal(res, 1)
  expect_invisible(quiet(f()))
})
