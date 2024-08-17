#' @importFrom httr2 request
#' @importFrom httr2 req_progress
#' @importFrom httr2 req_perform
mydownload <- function(url, destfile) {
    req <- request(url) |> 
        req_progress()
    
    req |> req_perform(path = destfile)
}
