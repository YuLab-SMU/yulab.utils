## biorxiv_get_publication <- function(url) {
##     # url <- "https://www.biorxiv.org/search/visualization%20numresults%3A75%20sort%3Arelevance-rank"
##     x <- readLines(url)
##     pub <- x[grep("/content/10.1101", x)]

##     pub_url <- gsub(".*(/content/[[:digit:]\\.v/]+).*", "\\1", pub)
##     pub_url <- paste0("https://www.biorxiv.org", pub_url)
##     pub_title <- gsub("<[^>]+>", "", pub) %>%
##         sub("^\\s+", "", .) %>%
##         sub("\\s+$", "", .)

##     data.frame(url = pub_url,
##                title = pub_title)
## }

## biorxiv_get_correspondance <- function(url) {
##     # url <- "https://www.biorxiv.org/content/10.1101/701680v3"
##     x <- readLines(url)

##     i <- grep("citation_author\"", x)
##     j <- grep("citation_author_email", x)

##     idx <- vapply(j, function(ii) {
##         jj <- ii - i
##         i[which(jj == min(jj[jj >0]))]
##     }, numeric(1))

##     author <- x[idx] %>% unique %>%
##         sub(".*content=\"([^\"]+).*", "\\1", .)

##     email <- x[j] %>% unique %>%
##         sub(".*content=\"([^\"]+).*", "\\1", .)

##     data.frame(author = author, email = email) %>% unique 
## }



## url <- "https://www.biorxiv.org/search/visualization%20numresults%3A75%20sort%3Arelevance-rank"
## y <- biorxiv_get_publication(url)
## xx <- lapply(y$url, function(x) {
##     cat("parsing", x, "\n")
##     biorxiv_get_correspondance(x)
## })
