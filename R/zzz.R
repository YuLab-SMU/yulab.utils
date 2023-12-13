##‘ @importFrom memoise memoise
.onLoad <- function(libname, pkgname) { 
    yread <<- memoise::memoise(yread)
    yread_tsv <<- memoise::memoise(yread_tsv) 
}



.onAttach <- function(libname, pkgname) {
    set_translate_source("baidu")
    set_translate_option(appid = "20231211001907382", key = "UM3Z6c5iQMOYNkkN5dzV")
}


