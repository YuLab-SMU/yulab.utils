get_runinfo <- function(sra_id) {
    x <- rentrez::entrez_fetch(db='sra', rettype='runinfo', id = sra_id)
    read.csv(textConnection(x))
}



id <- "SRX5137765"
d <- get_runinfo(id)
head(d,2)

sprintf("fastq-dump %s", d$Run[1:3])
