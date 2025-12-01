#' Messages for R package developed by YuLab
#'
#' 
#' @title yulab_msg
#' @param pkgname package name
#' @param n number of citation messages 
#' @return package message
#' @export
#' @author Guangchuang Yu
yulab_msg <- function(pkgname = NULL, n = 1) {
    
    pkgs_knownledge <- c("GOSemSim",
                        "DOSE",
                        "clusterProfiler",
                        "meshes",
                        "ReactomePA",
                        "MicrobiomeProfiler",
                        "enrichplot",
                        "ChIPseeker")

    pkgs_tree <- c("tidytree",
                "treeio",
                "ggtree",
                "ggtreeExtra",
                "ggtreeSpace",
                "shinyTempSignal")
    

    if (pkgname %in% pkgs_knownledge) {
        id <- 1
    } else if (pkgname %in% pkgs_tree) {
        id <- 2
    } else {
        id <- 3
    }

    header_msg <- yulab_msg_header(pkgname, id)
    
    if (id == 1) {
        citation_msg <- random_ref(pkgname, ref_knownledge(), random_n = n)
    } else if (id == 2) {
        citation_msg <- random_ref(pkgname, ref_ggtree(), random_n = n)
    } else {
        citation_msg <- pkg_ref(pkgname)
    }

    if (is.null(citation_msg)) return(header_msg)

    sprintf("%s%s", header_msg, citation_msg)
}

#' @importFrom utils packageDescription
yulab_msg_header <- function(pkgname = NULL, id = 3) {
    if (is.null(pkgname)) return(NULL)

    pages <- c("contribution-knowledge-mining/",
            "contribution-tree-data/",
            "")

    urls <- sprintf("https://yulab-smu.top/%s", pages)

    pkgVersion <- packageDescription(pkgname, fields = "Version")
    sprintf("%s v%s Learn more at %s\n\n", pkgname, pkgVersion, urls[id])
}

random_ref <- function(pkgname, refs, random_n) {
    msg <- "Please cite:\n\n" 

    indx <- grep(pkgname, names(refs))
    if (length(indx) == 0) {
        refs <- sample(refs, random_n)
    } else if (length(indx) > random_n) {
        refs <- sample(refs[indx], random_n)
    } else {
        refs <- c(refs[indx], sample(refs[-indx], random_n - length(indx)))
    }

    refs <- paste0(refs, collapse="\n")
    
    if (nchar(refs) <= 0) return(NULL)

    paste(strwrap(paste0(msg, refs)), collapse = "\n")

}

pkg_ref <- function(pkgname) {
    refs <- c(
        fanyi = 
            paste("D Wang, G Chen, L Li, S Wen, Z Xie, X Luo, L Zhan, S Xu, J Li, R Wang, Q Wang, G Yu.",
                "Reducing language barriers, promoting information absorption, and communication using fanyi.",
                "Chinese Medical Journal. 2024, 137(16):1950-1956. doi: 10.1097/CM9.0000000000003242")
    )

    ref <- refs[pkgname]

    if (is.null(ref) || is.na(ref)) return(NULL)

    msg <- "Please cite:\n\n" 
    str_wrap(paste0(msg, refs, "\n"))
}



