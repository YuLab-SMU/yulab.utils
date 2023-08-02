##‘ @importFrom memoise memoise
.onLoad <- function(libname, pkgname) { 
    read_with_cache <<- memoise::memoise(read_with_cache)
    read_tsv_with_cache <<- memoise::memoise(read_tsv_with_cache) 
}
