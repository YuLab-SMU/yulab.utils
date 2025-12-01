#' normalized data by range
#'
#'
#' @title scale-range
#' @param data the input data.
#' @return normalized data
#' @export
#' @author Guangchuang Yu
scale_range <- function(data) {
  normalized_data <- apply(data, 2, function(x) {
    (x - min(x, na.rm = TRUE)) / (max(x, na.rm = TRUE) - min(x, na.rm = TRUE))
  })
  as.data.frame(normalized_data)
}
