mydownload <- function(url, destfile) {
    if (is.installed('httr2')) {    
        req <- httr2::request(url) |> 
            httr2::req_progress()
        
        req |> httr2::req_perform(path = destfile)
    } else {
        download.file(url = url, destfile = destfile)
    }
}

