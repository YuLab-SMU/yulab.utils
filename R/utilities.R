`%||%` <- function(a, b) ifelse(is.null(a), b, a)

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
        fn <- tryCatch(eval(parse(text=caller)), error=function(e) NULL)
        if (is.null(fn)) return("")
    } else {
        fn <- caller
    }

    return(environmentName(environment(fn)))
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


