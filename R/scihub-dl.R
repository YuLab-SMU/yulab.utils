##' download publication via scihub
##' 
##' using scihub to download publication using doi
##' @rdname scihub-dl
##' @name scihub_dl
##' @param doi doi
##' @param scihub scihub website
##' @param download whether download the pdf file
##' @return pdf url
##' @author Guangchuang Yu
##' @export
scihub_dl <- function(doi, scihub = 'sci-hub.tw', download=TRUE) {
    url <- paste0('https://', scihub, '/', doi)
    x <- readLines(url)
    i <- grep('id = "pdf"', x)
    pdf_url <-sub(".*(//.*\\.pdf).*", "https:\\1", x[i])
    
    if (download) {
        outfile <- sub(".*/", "", pdf_url)
        utils::download.file(pdf_url, destfile = outfile)
    }
    invisible(pdf_url)
}

