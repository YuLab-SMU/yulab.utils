bib_ggtree <- function(id) {
    bib <- c(
        jgg2024 = bib_shinyTempSignal_jgg2024,
        bib2022 = bib_ggmsa_bib2022,
        book = bib_ggtree_book2022,
        imeta2022 = bib_ggtree_imeta2022,
        cpb2020 = bib_ggtree_cpb2020,
        mbe2020 = bib_treeio_mbe2020,
        mbe2018 = bib_ggtree_mbe2018,
        mee2017 = bib_ggtree_mee2017
    )

    if (!id %in% names(bib)) return(NULL)

    bib[id]
}


ref_ggtree <- function() {
    refs <- c(
        shinyTempSignal = paste(
            "L Zhan, X Luo, W Xie, XA Zhu, Z Xie, J Lin, L Li, W Tang, R Wang, L Deng, Y Liao, B Liu, Y Cai, Q Wang, S Xu, G Yu.", 
            "shinyTempSignal: an R shiny application for exploring temporal and other phylogenetic signals.",
            "Journal of Genetics and Genomics 2024, 51(7):762-768. doi: 10.1016/j.jgg.2024.02.004"),
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
        ),
        ggmsa = paste(
            "L Zhou, T Feng, S Xu, F Gao, TT Lam, Q Wang, T Wu, H Huang, L Zhan, L Li, Y Guan, Z Dai, G Yu.",
            "ggmsa: a visual exploration tool for multiple sequence alignment and associated data.",
            "Bioinformatics. 2022, 23(4):bbac222. 10.1093/bib/bbac222"
        )
    )

    return(refs)
}

refs <- ref_ggtree()

bib_ggtree_book2022 <- bibentry(
    bibtype  = "book",
    title = "Data Integration, Manipulation and Visualization of Phylogenetic Treess",
    author = person("Guangchuang", "Yu"),
	publisher = "Chapman and Hall/{CRC}",
    year = "2022",
	edition = "1st edition",
    doi = "10.1201/9781003279242",
    url = "https://www.amazon.com/Integration-Manipulation-Visualization-Phylogenetic-Computational-ebook/dp/B0B5NLZR1Z/",
    textVersion = refs['ggtreeBook']   
)

bib_ggtree_imeta2022 <- bibentry(
    bibtype  = "article",
    title = "Ggtree: A serialized data object for visualization of a phylogenetic tree and annotation data",
    author = personList(
        person("Shuangbin", "Xu"),
        person("Lin", "Li"),
        person("Xiao", "Luo"),
        person("Meijun", "Chen"),
        person("Wenli", "Tang"),
        person("Li", "Zhan"),
        person("Zehan", "Dai"),
        person("Tommy T. Lam"),
        person("Yi", "Guan"),
        person("Guangchuang", "Yu")
    ),
    year = "2022",
    journal = "iMeta",
    volume = "1",
    number = "4",
    pages = "e56",
    doi = "10.1002/imt2.56",
    url = "https://onlinelibrary.wiley.com/doi/full/10.1002/imt2.56",
    textVersion = refs['ggtree_imeta']
)


bib_ggtree_cpb2020 <- bibentry(
    bibtype  = "article",
    title = "Using ggtree to Visualize Data on Tree-Like Structures",
    author = person("Guangchuang", "Yu"),
    year = "2020",
    journal = "Current Protocols in Bioinformatics",
    volume = "69",
    pages = "e96",
    number = "1",
    url = "https://currentprotocols.onlinelibrary.wiley.com/doi/abs/10.1002/cpbi.96",
    doi = "10.1002/cpbi.96",
    textVersion = refs['ggtreeCPB']   
)


bib_ggtree_mbe2018 <- bibentry(
    bibtype  = "article",
    title  = "Two methods for mapping and visualizing associated data on phylogeny using ggtree.",
    author = personList(
        as.person("Guangchuang Yu"),
        as.person("Tommy Tsan-Yuk Lam"),
        as.person("Huachen Zhu"),
        as.person("Yi Guan")
    ),
    year    = "2018",
    journal = "Molecular Biology and Evolution",
    volume  = "35",
    issue   = "2",
    number  = "",
    pages   = "3041-3043",
    doi     = "10.1093/molbev/msy194",
    PMID    = "",
    url     = "https://academic.oup.com/mbe/article/35/12/3041/5142656",
    textVersion = refs['ggtreeMBE']
)

bib_ggtree_mee2017 <- bibentry(
    bibtype  = "article",
    title  = "ggtree: an R package for visualization and annotation of phylogenetic trees with their covariates and other associated data.",
    author = personList(
        as.person("Guangchuang Yu"),
        as.person("David Smith"),
        as.person("Huachen Zhu"),
        as.person("Yi Guan"),
        as.person("Tommy Tsan-Yuk Lam")
    ),
    year    = "2017",
    journal = "Methods in Ecology and Evolution",
    volume  = "8",
    issue   = "1",
    number  = "",
    pages   = "28-36",
    doi     = "10.1111/2041-210X.12628",
    PMID    = "",
    url     = "http://onlinelibrary.wiley.com/doi/10.1111/2041-210X.12628/abstract", 
    textVersion = refs['ggtree']
)

#' @importFrom utils bibentry
bib_shinyTempSignal_jgg2024 <- bibentry(
    bibtype  = "article",
    title  = "shinyTempSignal: an R shiny application for exploring temporal and other phylogenetic signals.",
    author = c(
        person("Li", "Zhan"),
        person("Xiao", "Luo"),
        person("Wenqin", "Xie"),
        person("Xuan-An", "Zhu"),
        person("Zijing", "Xie"),
        person("Jianfeng", "Lin"),
        person("Lin", "Li"),
        person("Wenli", "Tang"),
        person("Rui", "Wang"),
        person("Lin", "Deng"),
        person("Yufan", "Liao"),
        person("Bingdong", "Liu"),
        person("Yantong", "Cai"),
        person("Qianwen", "Wang"),
        person("Shuangbin", "Xu"),
        person("Guangchuang", "Yu")
        ),
    year    = "2024",
    journal = "Journal of Genetics and Genomics",
    volume  = "51",
    issue   = "7",
    number  = "",
    pages   = "762-768",
    doi     = "10.1016/j.jgg.2024.02.004",
    PMID    = "",
    url     = "https://www.sciencedirect.com/science/article/pii/S167385272400033X", 
    textVersion = refs['shinyTempSignal']
)

bib_treeio_mbe2020 <- bibentry(
    bibtype  = "article",
    title  = "treeio: an R package for phylogenetic tree input and output with richly annotated and associated data.",
    author = c(
        person("Li-Gen", "Wang"),
        person("Tommy Tsan-Yuk", "Lam"),
        person("Shuangbin", "Xu"),
        person("Zehan", "Dai"),
        person("Lang", "Zhou"),
        person("Tingze", "Feng"),
        person("Pingfan", "Guo"),
        person("Casey W.", "Dunn"),
        person("Bradley R.", "Jones"),
        person("Tyler", "Bradley"),
        person("Huachen", "Zhu"),
        person("Yi", "Guan"),
        person("Yong", "Jiang"),
        person("Guangchuang", "Yu")
        ),
    year    = "2020",
    journal = "Molecular Biology and Evolution",
    volume  = "37",
    issue   = "2",
    number  = "",
    pages   = "599-603",
    doi     = "10.1093/molbev/msz240",
    PMID    = "",
    url     = "", 
    textVersion = refs['treeio']
)

bib_ggmsa_bib2022 <- citEntry(
    entry  = "article",
    title  = "ggmsa: a visual exploration tool for multiple sequence alignment and associated data ",
    author = personList(
        as.person("Lang Zhou"),
        as.person("Tingze Feng"),
        as.person("Shuangbin Xu"),
        as.person("Fangluan Gao"),
        as.person("Tommy T Lam"),
        as.person("Qianwen Wang"),
        as.person("Tianzhi Wu"),
        as.person("Huina Huang"),
        as.person("Li Zhan"),
        as.person("Lin Li"),
        as.person("Yi Guan"),
        as.person("Zehan Dai"),
        as.person("Guangchuang Yu")
        ),
    journal = "BRIEFINGS IN BIOINFORMATICS",
    volume  = "23",
    issue   = "4",
    year    = "2022",
    month   = "06",
    ISSN    = "1467-5463",
    doi     = "10.1093/bib/bbac222",
    PMID    = "35671504",
    url     = "https://academic.oup.com/bib/article-abstract/23/4/bbac222/6603927",
    textVersion = refs['ggmsa']
)

