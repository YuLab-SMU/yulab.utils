bib_ggtree <- function(id) {
    bib <- list(
        book = bibentry(
            bibtype  = "book",
            title = "Data Integration, Manipulation and Visualization of Phylogenetic Treess",
            author = person("Guangchuang", "Yu"),
            publisher = "Chapman and Hall/{CRC}",
            year = "2022",
            edition = "1st edition",
            doi = "10.1201/9781003279242",
            url = "https://www.amazon.com/Integration-Manipulation-Visualization-Phylogenetic-Computational-ebook/dp/B0B5NLZR1Z/",
            textVersion = ref_ggtree()['ggtreeBook']  
        )
    )

    if (id %in% names(bib)) return(NULL)

    bib[[id]]
}

