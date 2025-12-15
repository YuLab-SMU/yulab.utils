mydownload <- function(url, destfile) {
    if (is.installed('httr2')) {
        req <- httr2::request(url) |> httr2::req_progress()
        req |> httr2::req_perform(path = destfile)
    } else {
        download.file(url = url, destfile = destfile)
    }
}


#' Process YuLab File Download
#' 
#' @param destfile character. Local file path.
#' @param urls character vector. Base URLs for download. Remote is is `urls/basename(destfile)`
#' @param gzfile logical. Whether the remote file is gzipped.
#' @param appname character. R package name.
#' @author Guangchuang Yu
#' @importFrom utils read.delim
#' @export
download_yulab_file <- function(destfile, urls, gzfile = FALSE, appname = NULL) {
    file0 <- basename(destfile)
    if (!is.null(appname)) {
        destfile <- file.path(user_dir(appname), file0)
    }

    need_dl <- TRUE
    dl_url <- urls[1]

    if (file.exists(destfile)) {
        need_dl <- FALSE
        for (url in urls) {
            md5_url <- sprintf("%s/md5.txt", url)
            md5 <- tryCatch(read.delim(md5_url, header = FALSE), error = function(e) NULL)

            if (!is.null(md5)) {
                md5_remote <- md5[md5[, 1] == file0, 2]
                if (length(md5_remote) > 0) {
                    md5_local <- digest::digest(destfile, algo = 'md5', file = TRUE)
                    if (md5_remote != md5_local) {
                        message(sprintf("%s is outdated, download the latest version...", file0))
                        need_dl <- TRUE
                        dl_url <- url
                    }
                    break
                }
            }
        }
    } else {
        message(sprintf("%s is not found, download it online...", file0))
    }

    if (need_dl) {
        if (dl_url != urls[1]) {
            urls <- unique(c(dl_url, urls))
        }

        for (url in urls) {
            if (gzfile) {
                furl <- sprintf('%s/%s.gz', url, file0)
                tpfile <- sprintf("%s.gz", destfile)
            } else {
                furl <- sprintf('%s/%s', url, file0)
                tpfile <- destfile
            }
            
            res <- tryCatch({
                mydownload(furl, tpfile)
                if (gzfile) {
                    check_pkg_installed('R.utils')
                    R.utils::gunzip(tpfile, overwrite = TRUE)
                }
                TRUE
            }, error = function(e) FALSE)

            if (res) break
        }
    }
}
