#' install github package 
#'
#' it download the zip file first and use `install_zip` to install it
#' @title install_zip_gh
#' @param repo github repo
#' @param ref github branch, default is HEAD, which means the default branch of the GitHub repo
#' @param subdir sub directory that contains R package files, default is NULL
#' @param args argument to build package
#' @return No return value, called for installing github package
#' @importFrom utils download.file
#' @export
#' @author Guangchuang Yu
install_zip_gh <- function(repo, ref = "HEAD", subdir = NULL, args = "--no-build-vignettes") {
    ## repo <- 'GuangchuangYu/nCov2019'
    url <- paste0('https://codeload.github.com/', repo, '/zip/', ref)
    f <- tempfile(fileext=".zip")
    mydownload(url, destfile = f)

    if (!is_valid_zip(f)) {
        stop("Invalid zip file downloaded, please check the 'ref' parameter to set a correct github branch.")
    }
    
    install_zip(f, subdir = subdir, args=args)
}

#' install R package from zip file of source codes
#'
#' 
#' @title install_zip
#' @param file zip file
#' @param args argument to build package
#' @param subdir sub directory that contains R package files, default is NULL
#' @return No return value, called for install R package from zip file of source codes
#' @export
#' @author Guangchuang Yu
install_zip <- function(file, subdir = NULL, args = "--no-build-vignettes") {
    dir <- tempfile()
    utils::unzip(file, exdir=dir)

    fs <- list.files(path=dir, full.names=T)
    #if (length(fs) == 1 && dir.exists(fs)) {
    #    dir <- fs
    #}
    ## dir <- paste0(dir, '/', basename(repo), '-master')
    dir <- fs[which.max(file.info(fs)$atime)]
    if (!is.null(subdir)) dir <- file.path(dir, subdir)
    
    if ("INDEX" %in% list.files(dir)) {
        # file is binary package
        pkg <- file
    } else {  
        # file is zip of package source
        ## remotes::install_local(path=dir, ..., force=TRUE)
        ## pkg <- pkgbuild::build(dir, args=args)
        build <- get_fun_from_pkg('pkgbuild', 'build')
        pkg <- build(dir, args=args)
    }
    utils::install.packages(pkg, repos=NULL)
}


is_valid_zip <- function(zipfile) {
    fs <- tryCatch(utils::unzip(zipfile, list=TRUE), error = function(e) NULL)
    if (is.null(fs)) return(FALSE)
    return(TRUE)
}

