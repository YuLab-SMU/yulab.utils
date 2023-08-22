#' all possible combinations of n sets
#'
#' @title combinations
#' @param n number of sets
#' @return a list of all combinations
#' @importFrom utils combn
#' @export
combinations <- function(n){
  l <- lapply(seq_len(n), function(x){
    m <- combn(n,x)
    mat2list(m)
  })
  unlist(l, recursive = F)
}
