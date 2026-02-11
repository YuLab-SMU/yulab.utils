test_that("c2 concatenates numeric vectors", {
    a <- c2(1:5, 6:10)
    expect_s3_class(a, "chunked_array")
    expect_equal(length(a), 10)
    expect_equal(as.vector(a), 1:10)
})

test_that("c2 concatenates character vectors", {
    a <- c2(letters[1:3], letters[4:6])
    expect_s3_class(a, "chunked_array")
    expect_equal(length(a), 6)
    expect_equal(as.vector(a), letters[1:6])
})

test_that("c2 rejects mixed types", {
    expect_error(c2(1:5, letters[1:3]))
})

test_that("c2 handles empty vector input", {
    a <- c2(integer(0), 1:5)
    expect_s3_class(a, "chunked_array")
    expect_equal(as.vector(a), 1:5)

    b <- c2(1:5, integer(0))
    expect_s3_class(b, "chunked_array")
    expect_equal(as.vector(b), 1:5)
})

test_that("c2 chain calls work", {
    a <- c2(c2(1:3, 4:6), 7:9)
    expect_equal(length(a), 9)
    expect_equal(as.vector(a), 1:9)
})

test_that("as_chunked_array creates from vector", {
    a <- as_chunked_array(1:5)
    expect_s3_class(a, "chunked_array")
    expect_equal(as.vector(a), 1:5)
})

test_that("as_chunked_array returns chunked_array as-is", {
    a <- as_chunked_array(1:5)
    b <- as_chunked_array(a)
    expect_identical(a, b)
})

test_that("as_chunked_array rejects unsupported types", {
    expect_error(as_chunked_array(TRUE))
})

test_that("c.chunked_array works with multiple args", {
    a <- as_chunked_array(1:3)
    b <- as_chunked_array(4:6)
    res <- c(a, b, as_chunked_array(7:9))
    expect_equal(length(res), 9)
    expect_equal(as.vector(res), 1:9)
})

test_that("length works for single and multi-chunk", {
    a <- as_chunked_array(1:10)
    expect_equal(length(a), 10)

    b <- c2(1:5, 6:10)
    expect_equal(length(b), 10)
})

test_that("length handles empty chunked_array", {
    # empty vector wrapped
    a <- as_chunked_array(integer(0))
    expect_equal(length(a), 0)
})

test_that("positive indexing works", {
    a <- c2(1:5, 6:10)
    expect_equal(a[1], 1)
    expect_equal(a[10], 10)
    expect_equal(a[c(1, 5, 6, 10)], c(1, 5, 6, 10))
})

test_that("negative indexing works", {
    a <- c2(1:5, 6:10)
    expect_equal(a[-(1:5)], 6:10)
})

test_that("logical indexing works", {
    a <- c2(1:5, 6:10)
    mask <- rep(c(TRUE, FALSE), 5)
    expect_equal(a[mask], c(1, 3, 5, 7, 9))
})

test_that("NA indexing returns NA (R convention)", {
    a <- c2(1:5, 6:10)
    res <- a[c(1, NA, 3)]
    expect_equal(res[1], 1)
    expect_true(is.na(res[2]))
    expect_equal(res[3], 3)
})

test_that("empty indexing returns empty", {
    a <- c2(1:5, 6:10)
    expect_equal(length(a[integer(0)]), 0)
})

test_that("print outputs correct format", {
    a <- c2(1:5, 6:10)
    out <- capture.output(print(a))
    expect_match(out, "chunked array with size of 10")
})

test_that("type check works correctly", {
    a <- as_chunked_array(1:5)
    expect_true(yulab.utils:::ca_is_numeric(a))
    expect_false(yulab.utils:::ca_is_character(a))

    b <- as_chunked_array(letters[1:5])
    expect_false(yulab.utils:::ca_is_numeric(b))
    expect_true(yulab.utils:::ca_is_character(b))
})

test_that("as.vector restores plain vector", {
    a <- c2(1:5, 6:10)
    v <- as.vector(a)
    expect_equal(v, 1:10)
    expect_false(inherits(v, "chunked_array"))
})
