#' @rdname yread
#' @export
yread_tsv <- function(file, reader = utils::read.delim, 
                params = list(),
                cache_dir = tempdir()
            ) {
    # e.g. params = list(sep = "\t", header = FALSE)
    
    yread(file, 
        reader = reader, 
        params = params,
        cache_dir = cache_dir
    )
}



#' read file with caching
#' 
#' This function read a file (local or url) and cache the content.
#' @title yread
#' @rdname yread
#' @param file a file or url
#' @param reader a function to read the 'file_url'
#' @param params a list of parameters that passed to the 'reader'
#' @param cache_dir a folder to store cache files. If set to NULL will disable cache.
#' @return the output of using the 'reader' to read the 'file_url' with parameters specified by the 'params'
#' @author Yonghe Xia and Guangchuang Yu 
#' @importFrom fs path_join
#' @importFrom digest digest
#' @export
yread <- function(file, reader = readLines, params = list(), 
                cache_dir = NULL) {

    if (!is.null(cache_dir)) {
        # Generate a unique cache filename based on the file URL
        cache_filename <- fs::path_join(c(cache_dir, paste0(digest::digest(file), ".rds")))
    } else {
        cache_filename <- NULL
    }

    # Check if the cached file exists
    if (!is.null(cache_filename) && file.exists(cache_filename)) {
        # If cached file exists, load and return the cached data
        cached_data <- readRDS(cache_filename)
        return(cached_data)
    } else {
        # If cached file does not exist, read and cache the data
        data <- do.call(reader, args = c(file, params))
        if (!is.null(cache_filename)) {
            saveRDS(data, cache_filename)
        }
        return(data)
    }
}

##' read clipboard
##'
##'
##' @title read.cb
##' @param reader function to read the clipboard
##' @param ... parameters for the reader
##' @return clipboard content, output type depends on the output of the reader
##' @author Guangchuang Yu
##' @importFrom utils read.table
##' @export
read.cb <- function(reader = read.table, ...) {
    os <- Sys.info()[1]
    if (os == "Darwin") {
        clip <- pipe("pbpaste")
    } else {
        clip <- "clipboard"
    }
    reader(clip, ...)
}


##' open selected directory or file
##'
##'
##' @title o
##' @param file to be open; open working directory by default
##' @return No return value, called for opening specific directory or file
##' @examples
##' \dontrun{
##' ## to open current working directory
##' o()
##' }
##' @export
##' @author Guangchuang Yu
o <- function(file=".") {
    file <- normalizePath(file)
    os <- Sys.info()[1]
    if (is.rserver()) {
        if (dir.exists(file)) {
            stop("open directory in RStudio Server is not supported.")
        }
        rserver_ip <- getOption("rserver_ip")
        if (!is.null(rserver_ip)) {
            rserver_port <- getOption("rserver_port") %||% '8787' 
            if (!startsWith(rserver_ip, "http")) {
                rserver_ip <- paste0("http://", rserver_ip)
            }
            utils::browseURL(
                       paste0(
                           paste(rserver_ip, rserver_port, sep=":"),
                           "/file_show?path=",
                           file
                       ))
        } else {
            file.edit <- get("file.edit")
            file.edit(file)   
        }
    } else if (os == "Darwin") {
        cmd <- paste("open", file)
        system(cmd)
    } else if (os == "Linux") {
        cmd <- paste("xdg-open", file, "&")
        system(cmd)
    } else if (os == "Windows") {
        ## wd <- sub("/", "\\", getwd())
        ## cmd <- paste("explorer", wd)
        ## suppressWarnings(shell(cmd))
        cmd <- paste("start", file)
        shell(cmd)
    }
}


is.rserver <- function(){
    RStudio.Version <- tryCatch(get("RStudio.Version"), error = function(e) NULL)
    if(is.null(RStudio.Version)) return(FALSE)
    if(!is.function(RStudio.Version)) return(FALSE)
    RStudio.Version()$mode == 'server'
}

##' Open data frame in Excel. It can be used in pipe.
##'
##'
##' @title show_in_excel
##' @param .data a data frame to be open
##' @return original .data
##' @export
##' @author Guangchuang Yu
show_in_excel <- function(.data) {
    f <- tempfile(fileext = '.csv')
    utils::write.csv(.data, file=f)
    o(f)
    invisible(.data)
}
