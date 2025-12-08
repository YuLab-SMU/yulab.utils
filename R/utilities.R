`%||%` <- function(a, b) if (is.null(a)) b else a

.hi <- function(package = NULL, n=2L) {
    env <- sys.parent(n)
    
    if (!is.null(env)) {
        caller <- deparse(sys.call(env))
        caller <- sub("(\\w+)\\(.*", "\\1", caller)
        if (is.null(package)) return(FALSE)
        if (get_caller_package(caller) %in% package) return(TRUE)
    }

    return(FALSE)
} 

get_caller_package <- function(caller) {
    if (is.character(caller)) {
        fn <- tryCatch(get(caller, mode = "function"), error = function(e) NULL)
        if (is.null(fn)) return("")
    } else {
        fn <- caller
    }

    environmentName(environment(fn))
}

.called_by_package <- function(package) {
  call_stack <- sys.calls()
  pattern <- sprintf("^package:%s", package)
  for (call in call_stack) {
    call <- as.character(as.expression(call))
    if (grepl(pattern, call)) {
      return(TRUE)
    }
  }
  return(FALSE)
}

assert_single_string <- function(x, name) {
  if (!is.character(x) || length(x) != 1 || x == "") {
    yulab_abort(sprintf("%s must be a single non-empty character string", name), class = "parameter_error")
  }
  invisible(TRUE)
}

normalize_path2 <- function(path) {
  normalizePath(path, winslash = "/", mustWork = FALSE)
}

has_permission <- function(path, mode) {
  file.access(path, mode) == 0
}


