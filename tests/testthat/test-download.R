test_that("download_yulab_file decompresses gz files without R.utils", {
    srcdir <- tempfile()
    outdir <- tempfile()
    dir.create(srcdir)
    dir.create(outdir)
    on.exit(unlink(c(srcdir, outdir), recursive = TRUE), add = TRUE)

    gzfile_path <- file.path(srcdir, "foo.txt.gz")
    con <- gzfile(gzfile_path, "wb")
    writeLines("hello from yulab", con)
    close(con)

    dest <- file.path(outdir, "foo.txt")
    res <- suppressMessages(
        download_yulab_file(dest, urls = paste0("file://", srcdir), gzfile = TRUE)
    )

    expect_equal(res, dest)
    expect_true(file.exists(dest))
    expect_equal(readLines(dest), "hello from yulab")
    ## the downloaded archive is not kept around
    expect_false(file.exists(paste0(dest, ".gz")))
})

test_that("download_yulab_file handles plain files", {
    srcdir <- tempfile()
    outdir <- tempfile()
    dir.create(srcdir)
    dir.create(outdir)
    on.exit(unlink(c(srcdir, outdir), recursive = TRUE), add = TRUE)

    writeLines("plain content", file.path(srcdir, "bar.txt"))

    dest <- file.path(outdir, "bar.txt")
    res <- suppressMessages(
        download_yulab_file(dest, urls = paste0("file://", srcdir))
    )

    expect_equal(res, dest)
    expect_equal(readLines(dest), "plain content")
    ## no partial download left behind
    expect_false(file.exists(paste0(dest, ".part")))
})

test_that("download_yulab_file fails loudly when all mirrors fail", {
    outdir <- tempfile()
    dir.create(outdir)
    on.exit(unlink(outdir, recursive = TRUE), add = TRUE)

    dest <- file.path(outdir, "missing.txt")

    expect_error(
        suppressMessages(
            download_yulab_file(dest, urls = "file:///definitely/not/here")
        ),
        class = "download_error"
    )
    expect_false(file.exists(dest))
})
