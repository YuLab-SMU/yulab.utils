#' @importFrom httr2 request
#' @importFrom httr2 req_progress
#' @importFrom httr2 req_perform
mydownload <- function(url, destfile) {
    # method <- "auto"
    # if (.Platform$OS.type == "windows") method <- "curl"
    # utils::download.file(url, destfile=f, method = method)

    req <- request(url) |> 
        req_progress()
    
    req |> req_perform(path = destfile)
}
