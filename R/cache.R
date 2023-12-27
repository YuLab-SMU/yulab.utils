##' @rdname yulab-cache
##' @export
initial_yulab_cache <- function() {
    pos <- 1
    envir <- as.environment(pos)
    assign(".yulabCache", new.env(), envir = envir)
}

##' @rdname yulab-cache
##' @export
get_yulab_cache <- function() {
    if (!exists(".yulabCache", envir = .GlobalEnv)) {
        initial_yulab_cache()
    }
    get(".yulabCache", envir = .GlobalEnv)
}

##' @rdname yulab-cache
##' @export
rm_yulab_cache <- function() {
    if (exists(".yulabCache", envir = .GlobalEnv)) {
        rm(".yulabCache", envir = .GlobalEnv)
    }
}

##' @rdname yulab-cache
##' @export
initial_yulab_cache_item <- function(item) {
    env <- get_yulab_cache()
    assign(item, list(), envir = env)    
}

##' @rdname yulab-cache
##' @export
get_yulab_cache_item <- function(item) {
    env <- get_yulab_cache()
    if (!exists(item, envir = env)) {
        initial_yulab_cache_item(item)
    }

    get(item, envir = env, inherits = FALSE)
}

##' @rdname yulab-cache
##' @export
rm_yulab_cache_item <- function(item) {
    env <- get_yulab_cache()
    if (exists(item, envir = env)) {
        rm(list = item, envir = env)
    }
}

##' cache intermediate data
##'
##' Yulab provides a set of utilities to cache intermediate data, 
##' including initialize the cached item, update cached item and rmove the cached item, etc.
##' 
##' @rdname yulab-cache
##' @param item the name of the cached item
##' @param elements elements to be cached in the item
##' @return return the cache environment, item or selected elements, depends on the functions.
##' @importFrom utils modifyList
##' @export
##' @examples
##' \dontrun{
##'  slow_fib <- function(x) {
##'      if (x < 2) return(1)
##'      slow_fib(x-2) + slow_fib(x-1)
##'  }
##'  
##'  fast_fib <- function(x) {
##'      if (x < 2) return(1)
##'      res <- get_yulab_cache_element('fibonacci', as.character(x))
##'      if (!is.null(res)) { 
##'          return(res)
##'      }
##'      res <- fast_fib(x-2) + fast_fib(x-1)
##'      e <- list()
##'      e[[as.character(x)]] <- res
##'      update_yulab_cache_item('fibonacci', e)
##'      return(res)
##'  }
##'
##'  system.time(slow_fib(30))
##'  system.time(fast_fib(30)) 
##'     
##'  }
update_yulab_cache_item <- function(item, elements) {

    msg <- "new elements should be stored as a named list"
    if (!inherits(elements, 'list')) {
        stop(msg)
    } 

    if (is.null(names(elements))) {
        stop(msg)
    }
    
    if(any(names(elements) == "")) {
        stop(msg)
    }

    env <- get_yulab_cache()
    res <- get_yulab_cache_item(item)
    res <- modifyList(res, elements)
    assign(item, res, envir = env)
}

##' @rdname yulab-cache
##' @export
get_yulab_cache_element <- function(item, elements) {
    x <- get_yulab_cache_item(item)
    n <- length(elements)
    if (n == 1) return(x[[elements]])

    return(x[elements])
}


