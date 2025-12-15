# caching mechanism
# - get_cache_item() auto-initializes cache items if they don't exist
# - get_cache_element() retrieves specific elements from cache items
# - update_cache_item() stores data in cache items
# - rm_cache_item() removes cache items



.yulabCache <- new.env(parent = emptyenv())

#' @rdname yulab-cache
#' @export
#' @family cache-utils
initial_cache <- function() {
    rm(list = ls(envir = .yulabCache), envir = .yulabCache)
}

#' @rdname yulab-cache
#' @export
#' @family cache-utils
get_cache <- function() {
    .yulabCache
}

#' @rdname yulab-cache
#' @export
#' @family cache-utils
rm_cache <- function() {
    rm(list = ls(envir = .yulabCache), envir = .yulabCache)
}

#' @rdname yulab-cache
#' @export
#' @family cache-utils
initial_cache_item <- function(item) {
    env <- get_cache()
    assign(item, list(), envir = env)    
}

#' @rdname yulab-cache
#' @export
get_cache_item <- function(item) {
    env <- get_cache()
    if (!exists(item, envir = env)) {
        initial_cache_item(item)
    }

    get(item, envir = env, inherits = FALSE)
}

#' @rdname yulab-cache
#' @export
rm_cache_item <- function(item) {
    env <- get_cache()
    if (exists(item, envir = env)) {
        rm(list = item, envir = env)
    }
}

#' Cache intermediate data
#'
#' Utilities to cache intermediate data: initialize items, update items,
#' remove items, and retrieve elements.
#' 
#' @rdname yulab-cache
#' @param item Cache item name
#' @param elements Elements to cache
#' @param default Default value if cache element is missing
#' @param prune_expired Logical, whether to prune expired items
#' @param ttl Time-to-live in seconds
#' @return Cache environment, item, or selected elements
#' @importFrom utils modifyList
#' @importFrom stats setNames
#' @export
#' @examples
#' \dontrun{
#'  slow_fib <- function(x) {
#'      if (x < 2) return(1)
#'      slow_fib(x-2) + slow_fib(x-1)
#'  }
#'  
#'  fast_fib <- function(x) {
#'      if (x < 2) return(1)
#'      res <- get_cache_element('fibonacci', as.character(x))
#'      if (!is.null(res)) {
#'          return(res)
#'      }
#'      res <- fast_fib(x-2) + fast_fib(x-1)
#'      e <- list()
#'      e[[as.character(x)]] <- res
#'      update_cache_item('fibonacci', e)
#'      return(res)
#'  }
#'
#'  system.time(slow_fib(30))
#'  system.time(fast_fib(30)) 
#'     
#'  }
#' @family cache-utils
update_cache_item <- function(item, elements, ttl = NULL) {

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

    if (!is.null(ttl)) {
        expires <- Sys.time() + as.difftime(ttl, units = "secs")
        elements <- lapply(elements, function(v) list(value = v, expires = expires))
        names(elements) <- names(elements)
    }

    env <- get_cache()
    res <- get_cache_item(item)
    res <- modifyList(res, elements)
    assign(item, res, envir = env)
}

#' @rdname yulab-cache
#' @family cache-utils
#' @export
get_cache_element <- function(item, elements, default = NULL, prune_expired = TRUE) {
    x <- get_cache_item(item)
    fetch_one <- function(k) {
        val <- x[[k]]
        if (is.null(val)) return(default)
        if (is.list(val) && !is.null(val$expires)) {
            if (prune_expired && isTRUE(Sys.time() > val$expires)) {
                rm_cache_entry(item, k)
                return(default)
            }
            return(val$value)
        }
        val
    }
    n <- length(elements)
    if (n == 1) return(fetch_one(elements))
    setNames(lapply(elements, fetch_one), elements)
}

rm_cache_entry <- function(item, key) {
    env <- get_cache()
    x <- get_cache_item(item)
    x[[key]] <- NULL
    assign(item, x, envir = env)
}

#' @rdname yulab-cache
#' @export
prune_cache_item <- function(item) {
    x <- get_cache_item(item)
    expired <- vapply(names(x), function(k) {
        v <- x[[k]]
        is.list(v) && !is.null(v$expires) && isTRUE(Sys.time() > v$expires)
    }, logical(1))
    if (any(expired)) {
        x[names(x)[expired]] <- NULL
        env <- get_cache()
        assign(item, x, envir = env)
    }
    invisible(TRUE)
}

#' @rdname yulab-cache
#' @export
cache_list_items <- function() {
    ls(envir = get_cache())
}

#' @rdname yulab-cache
#' @export
cache_size <- function() {
    env <- get_cache()
    items <- ls(envir = env)
    sizes <- vapply(items, function(k) utils::object.size(get(k, envir = env)), numeric(1))
    sum(sizes)
}

#' @rdname yulab-cache
#' @param path File path to save or load cache
#' @export
cache_save <- function(path) {
    env <- get_cache()
    obj <- as.list(env)
    saveRDS(obj, path)
    invisible(path)
}

#' @rdname yulab-cache
#' @export
cache_load <- function(path) {
    obj <- readRDS(path)
    env <- get_cache()
    for (k in names(obj)) assign(k, obj[[k]], envir = env)
    invisible(TRUE)
}

#' @rdname yulab-cache
#' @param key Element key
#' @param compute Function to compute value when missing
#' @param ttl Time-to-live in seconds
#' @export
with_cache <- function(item, key, compute, ttl = NULL) {
    k <- as.character(key)
    val <- get_cache_element(item, k)
    if (!is.null(val)) return(val)
    res <- compute()
    e <- list()
    e[[k]] <- res
    update_cache_item(item, e, ttl = ttl)
    res
}


