test_that("update_cache_item with ttl expires entries", {
  item <- paste0("ttltest_", as.integer(runif(1) * 1e6))
  update_cache_item(item, list(a = 1), ttl = 0.01)
  val1 <- get_cache_element(item, "a")
  expect_equal(val1, 1)
  Sys.sleep(0.05)
  val2 <- get_cache_element(item, "a")
  expect_null(val2)
})

test_that("with_cache computes and caches results", {
  item <- paste0("withcache_", as.integer(runif(1) * 1e6))
  calls <- 0
  f <- function() { calls <<- calls + 1; 42 }
  v1 <- with_cache(item, "k", f, ttl = 1)
  v2 <- with_cache(item, "k", f, ttl = 1)
  expect_equal(v1, 42)
  expect_equal(v2, 42)
  expect_equal(calls, 1)
})

test_that("cache_save/cache_load round-trip", {
  item <- paste0("savecache_", as.integer(runif(1) * 1e6))
  update_cache_item(item, list(x = 123))
  tf <- tempfile(fileext = ".rds")
  cache_save(tf)
  rm_cache()
  cache_load(tf)
  expect_equal(get_cache_element(item, "x"), 123)
  unlink(tf)
})
