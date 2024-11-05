
get_gse <- function(gseID) {
    gsecat <- sub("\\d{3}$", "nnn", gseID)
    gsesoft <- sprintf("%s_family.soft.gz", gseID)
    url <- sprintf("https://ftp.ncbi.nlm.nih.gov/geo/series/%s/%s/soft/%s", gsecat, gseID, gsesoft)
    yulab.utils:::mydownload(url, destfile = gsesoft)
    GEOquery::getGEO(filename = gsesoft)
}

get_gsm <- function(gse) {
    lapply(GEOquery::GSMList(gse), function(x) x@header$supplementary_file)
}



download_gsm <- function(gsm) {
    for (x in gsm) {
        destfile <- sub(".*/([^/]+)$", "\\1", x)
        yulab.utils:::mydownload(x, destfile = destfile)
    }
}

gseID <- "GSE123904"

gse <- get_gse(gseID)
gsm <- get_gsm(gse)

download_gsm(gsm)

