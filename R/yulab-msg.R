##' Messages for R package developed by YuLab
##'
##' 
##' @title yulab_msg
##' @param pkgname package name
##' @param n number of citation messages 
##' @return package message
##' @export
##' @author Guangchuang Yu
yulab_msg <- function(pkgname = NULL, n = 1) {
    
    pkgs_knowledge <- c("GOSemSim",
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
    

    if (pkgname %in% pkgs_knowledge) {
        id <- 1
    } else if (pkgname %in% pkgs_tree) {
        id <- 2
    } else {
        id <- 3
    }

    header_msg <- yulab_msg_header(pkgname, id)
    
    if (id == 1) {
        citation_msg <- random_ref(pkgname, ref_knowledge(), random_n = n)
    } else if (id == 2) {
        citation_msg <- random_ref(pkgname, ref_ggtree(), random_n = n)
    } else {
        citation_msg <- NULL
    }

    if (is.null(citation_msg)) return(header_msg)

    sprintf("%s%s", header_msg, citation_msg)
}

##' @importFrom utils packageDescription
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


ref_knowledge <- function() {
    refs <- c(
        ChIPseeker_CP = paste(
            "Qianwen Wang, Ming Li, Tianzhi Wu, Li Zhan, Lin Li, Meijun Chen, Wenqin Xie, Zijing Xie, Erqiang Hu, Shuangbin Xu, Guangchuang Yu.",
            "Exploring epigenomic datasets by ChIPseeker.",
            "Current Protocols 2022, 2(10): e585"),
        ChIPseeker = paste(
            "Guangchuang Yu, Li-Gen Wang, and Qing-Yu He.",
            "ChIPseeker: an R/Bioconductor package for ChIP peak annotation, comparison and visualization.",
            "Bioinformatics 2015, 31(14):2382-2383"),
        GOSemSim_MMB = paste(
            "Guangchuang Yu.",
            "Gene Ontology Semantic Similarity Analysis Using GOSemSim.",
            "In: Kidder B. (eds) Stem Cell Transcriptional Networks.",
            "Methods in Molecular Biology, 2020, 2117:207-215.",
            "Humana, New York, NY."),
        GOSemSim = paste(
            "Guangchuang Yu, Fei Li, Yide Qin, Xiaochen Bo, Yibo Wu and Shengqi Wang.",
            "GOSemSim: an R package for measuring semantic similarity among GO terms and gene products.",
            "Bioinformatics 2010 26(7):976-978"),
        DOSE = paste(
            "Guangchuang Yu, Li-Gen Wang, Guang-Rong Yan, Qing-Yu He.",
            "DOSE: an R/Bioconductor package for Disease Ontology Semantic and Enrichment analysis.",
            "Bioinformatics 2015 31(4):608-609"),         
        ReactomePA = paste(
            "Guangchuang Yu, Qing-Yu He.",
            "ReactomePA: an R/Bioconductor package for reactome pathway analysis and visualization.",
            "Molecular BioSystems 2016, 12(2):477-479"),
        clusterProfiler_NP = paste(
            "S Xu, E Hu, Y Cai, Z Xie, X Luo, L Zhan, W Tang,",
            "Q Wang, B Liu, R Wang, W Xie, T Wu, L Xie, G Yu.", 
            "Using clusterProfiler to characterize multiomics data.", 
            "Nature Protocols. 2024, doi:10.1038/s41596-024-01020-z"),
        clusterProfiler_Innovation = paste(
            "T Wu, E Hu, S Xu, M Chen, P Guo, Z Dai, T Feng, L Zhou,",
            "W Tang, L Zhan, X Fu, S Liu, X Bo, and G Yu.", 
            "clusterProfiler 4.0: A universal enrichment tool for interpreting omics data.", 
            "The Innovation. 2021, 2(3):100141"),
        clusterProfiler = paste(
            "Guangchuang Yu, Li-Gen Wang, Yanyan Han and Qing-Yu He.",
            "clusterProfiler: an R package for comparing biological themes among gene clusters.",
            "OMICS: A Journal of Integrative Biology 2012, 16(5):284-287"),
        meshes = paste(
            "Guangchuang Yu.",
            "Using meshes for MeSH term enrichment and semantic analyses.",
            "Bioinformatics 2018, 34(21):3766-3767, doi:10.1093/bioinformatics/bty410")        
         )
         
    return(refs)
}


ref_ggtree <- function() {
    refs <- c(
        ggtreeBook = paste(
            "Guangchuang Yu. ",
            "Data Integration, Manipulation and Visualization of Phylogenetic Trees (1st edition).",
            "Chapman and Hall/CRC. 2022, doi:10.1201/9781003279242, ISBN: 9781032233574\n"),
        ggtreeCPB = paste0(
            "Guangchuang Yu. ",
            "Using ggtree to visualize data on tree-like structures. ",
            "Current Protocols in Bioinformatics. 2020, 69:e96. doi:10.1002/cpbi.96\n"
        ),
        ggtree_imeta = paste0(
            "Shuangbin Xu, Lin Li, Xiao Luo, Meijun Chen, Wenli Tang, Li Zhan, Zehan Dai, Tommy T. Lam, Yi Guan, Guangchuang Yu. ",
            "Ggtree: A serialized data object for visualization of a phylogenetic tree and annotation data. ",
            "iMeta 2022, 1(4):e56. doi:10.1002/imt2.56\n"),
        ggtreeMBE = paste0(
            "Guangchuang Yu, Tommy Tsan-Yuk Lam, Huachen Zhu, Yi Guan. ",
            "Two methods for mapping and visualizing associated data on phylogeny using ggtree. ",
            "Molecular Biology and Evolution. 2018, 35(12):3041-3043. doi:10.1093/molbev/msy194\n"
        ),
        ggtree = paste0(
            "Guangchuang Yu, David Smith, Huachen Zhu, Yi Guan, Tommy Tsan-Yuk Lam. ",
            "ggtree: an R package for visualization and annotation of phylogenetic trees with their covariates and other associated data. ",
            "Methods in Ecology and Evolution. 2017, 8(1):28-36. doi:10.1111/2041-210X.12628\n"
        ),
        treeio = paste0(
            "LG Wang, TTY Lam, S Xu, Z Dai, L Zhou, T Feng, P Guo, CW Dunn, BR Jones, T Bradley, H Zhu, Y Guan, Y Jiang, G Yu. ",
            "treeio: an R package for phylogenetic tree input and output with richly annotated and associated data. ",
            "Molecular Biology and Evolution. 2020, 37(2):599-603. doi: 10.1093/molbev/msz240\n"            
        ),
        ggtreeExtra = paste0(
            "S Xu, Z Dai, P Guo, X Fu, S Liu, L Zhou, W Tang, T Feng, M Chen, L Zhan, T Wu, E Hu, Y Jiang, X Bo, G Yu. ",
            "ggtreeExtra: Compact visualization of richly annotated phylogenetic data. ",
            "Molecular Biology and Evolution. 2021, 38(9):4039-4042. doi: 10.1093/molbev/msab166\n"
        )
    )

    return(refs)
}


